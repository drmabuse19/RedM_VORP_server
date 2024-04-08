---@diagnostic disable: undefined-global

local isProcessingPay = false
local timerUse = 0
local candrop = true
local cangive = true
local storemenu = false
local geninfo = {}
local CanOpen = true
local InventoryIsDisabled = false
-- * GLOBALS * --
InInventory = false
NUIService = {}

RegisterNetEvent('inv:dropstatus')
AddEventHandler('inv:dropstatus', function(x)
	candrop = x
end)

RegisterNetEvent('inv:givestatus')
AddEventHandler('inv:givestatus', function(x)
	cangive = x
end)


function NUIService.ReloadInventory(inventory)
	local payload = json.decode(inventory)
	if payload.itemList == '[]' then
		payload.itemList = {}
	end

	for _, item in pairs(payload.itemList) do
		if item.type == "item_weapon" then
			item.label = item.custom_label or Utils.GetWeaponLabel(item.name)
			local serial_number = ""
			local custom_desc = nil

			if item.serial_number then
				serial_number = item.serial_number
			end
			if item.custom_desc then
				local serial_number_str = "<br><br>" .. T.serialnumber .. serial_number
				if not string.find(item.custom_desc, serial_number_str, 1, true) then
					custom_desc = item.custom_desc .. "<br><br>" .. T.serialnumber .. serial_number
				end
			end

			if item.desc and custom_desc then
				item.desc = custom_desc
			end

			if item.desc == nil then
				local applySerial = Utils.filterWeaponsSerialNumber(item.name)
				item.desc = applySerial and
					Utils.GetWeaponDesc(item.name) .. "<br><br>" .. T.serialnumber .. serial_number or
					Utils.GetWeaponDesc(item.name)
			end
		end
	end
	SendNUIMessage(payload)
	Wait(500)
	NUIService.LoadInv()
end

function NUIService.OpenCustomInventory(name, id, capacity)
	local result = Core.Callback.TriggerAwait("vorp_inventory:Server:CanOpenCustom", id)
	CanOpen = result
	if CanOpen then
		CanOpen = false
		SetNuiFocus(true, true)
		SendNUIMessage({
			action = "display",
			type = "custom",
			title = tostring(name),
			id = tostring(id),
			capacity = capacity
		})
		InInventory = true
	end
end

function NUIService.NUIMoveToCustom(obj)
	TriggerServerEvent("vorp_inventory:MoveToCustom", json.encode(obj))
end

function NUIService.NUITakeFromCustom(obj)
	TriggerServerEvent("vorp_inventory:TakeFromCustom", json.encode(obj))
end

function NUIService.OpenClanInventory(clanName, clanId, capacity)
	SetNuiFocus(true, true)
	SendNUIMessage({
		action = "display",
		type = "clan",
		title = "" .. clanName .. "",
		clanid = clanId,
		capacity = capacity,
		search = Config.InventorySearchable
	})
	InInventory = true
end

function NUIService.NUIMoveToClan(obj)
	TriggerServerEvent("syn_clan:MoveToClan", json.encode(obj))
end

function NUIService.NUITakeFromClan(obj)
	TriggerServerEvent("syn_clan:TakeFromClan", json.encode(obj))
end

function NUIService.OpenContainerInventory(ContainerName, Containerid, capacity)
	SetNuiFocus(true, true)
	SendNUIMessage({
		action = "display",
		type = "Container",
		title = "" .. ContainerName .. "",
		Containerid = Containerid,
		capacity = capacity,
		search = Config.InventorySearchable
	})
	InInventory = true
end

function NUIService.NUIMoveToContainer(obj)
	TriggerServerEvent("syn_Container:MoveToContainer", json.encode(obj))
end

function NUIService.NUITakeFromContainer(obj)
	TriggerServerEvent("syn_Container:TakeFromContainer", json.encode(obj))
end

function NUIService.CloseInventory()
	if storemenu then
		storemenu = false
		geninfo = {}
		for _, item in pairs(UserInventory) do
			if item.metadata ~= nil and item.metadata.description ~= nil and
				(item.metadata.orgdescription ~= nil or item.metadata.orgdescription == "") then
				if item.metadata.orgdescription == "" then
					item.metadata.description = nil
				else
					item.metadata.description = item.metadata.orgdescription
				end
				item.metadata.orgdescription = nil
			end
		end
	end
	if not CanOpen then -- only trigger if someone is inside custom inv
		TriggerServerEvent("vorp_inventory:Server:UnlockCustomInv")
	end
	SetNuiFocus(false, false)
	SendNUIMessage({ action = "hide" })
	InInventory = false
	TriggerEvent("vorp_stables:setClosedInv", false)
	TriggerEvent("syn:closeinv")
end

function NUIService.CloseInv()
	if storemenu then
		storemenu = false
		geninfo = {}
		for _, item in pairs(UserInventory) do
			if item.metadata ~= nil and item.metadata.description ~= nil and
				(item.metadata.orgdescription ~= nil or item.metadata.orgdescription == "") then
				if item.metadata.orgdescription == "" then
					item.metadata.description = nil
				else
					item.metadata.description = item.metadata.orgdescription
				end
				item.metadata.orgdescription = nil
			end
		end
	end

	if not CanOpen then -- only trigger if somone is inside
		TriggerServerEvent("vorp_inventory:Server:UnlockCustomInv")
	end
	SetNuiFocus(false, false)
	SendNUIMessage({ action = "hide" })
	InInventory = false
	TriggerEvent("vorp_stables:setClosedInv", false)
	TriggerEvent("syn:closeinv")
end

function NUIService.OpenHorseInventory(horseTitle, horseId, capacity)
	SetNuiFocus(true, true)
	SendNUIMessage({
		action = "display",
		type = "horse",
		title = horseTitle,
		horseid = horseId,
		capacity = capacity,
		search = Config.InventorySearchable
	})
	InInventory = true
	TriggerEvent("vorp_stables:setClosedInv", true)
end

function NUIService.NUIMoveToHorse(obj)
	TriggerServerEvent("vorp_stables:MoveToHorse", json.encode(obj))
end

function NUIService.NUITakeFromHorse(obj)
	TriggerServerEvent("vorp_stables:TakeFromHorse", json.encode(obj))
end

function NUIService.NUIMoveToStore(obj)
	TriggerServerEvent("syn_store:MoveToStore", json.encode(obj))
end

function NUIService.NUITakeFromStore(obj)
	TriggerServerEvent("syn_store:TakeFromStore", json.encode(obj))
end

function NUIService.OpenStoreInventory(StoreName, StoreId, capacity, geninfox)
	storemenu = true
	geninfo = geninfox
	SetNuiFocus(true, true)
	SendNUIMessage({
		action = "display",
		type = "store",
		title = StoreName,
		StoreId = StoreId,
		capacity = capacity,
		geninfo = geninfo,
		search = Config.InventorySearchable
	})
	InInventory = true
	TriggerEvent("syn_store:setClosedInv", true)
end

function NUIService.OpenstealInventory(stealName, stealId, capacity)
	SetNuiFocus(true, true)
	SendNUIMessage({
		action = "display",
		type = "steal",
		title = stealName,
		stealId = stealId,
		capacity = capacity,
		search = Config.InventorySearchable
	})
	InInventory = true
	TriggerEvent("vorp_stables:setClosedInv", true)
end

function NUIService.NUIMoveTosteal(obj)
	TriggerServerEvent("syn_search:MoveTosteal", json.encode(obj))
end

function NUIService.NUITakeFromsteal(obj)
	TriggerServerEvent("syn_search:TakeFromsteal", json.encode(obj))
end

function NUIService.OpenCartInventory(cartName, wagonId, capacity)
	SetNuiFocus(true, true)
	SendNUIMessage({
		action = "display",
		type = "cart",
		title = cartName,
		wagonid = wagonId,
		capacity = capacity,
		search = Config.InventorySearchable
	})
	InInventory = true

	TriggerEvent("vorp_stables:setClosedInv", true)
end

function NUIService.NUIMoveToCart(obj)
	TriggerServerEvent("vorp_stables:MoveToCart", json.encode(obj))
end

function NUIService.NUITakeFromCart(obj)
	TriggerServerEvent("vorp_stables:TakeFromCart", json.encode(obj))
end

function NUIService.OpenHouseInventory(houseName, houseId, capacity)
	SetNuiFocus(true, true)
	SendNUIMessage({
		action = "display",
		type = "house",
		title = houseName,
		houseId = houseId,
		capacity = capacity,
		search = Config.InventorySearchable
	})
	InInventory = true
end

function NUIService.NUIMoveToHouse(obj)
	TriggerServerEvent("vorp_housing:MoveToHouse", json.encode(obj))
end

function NUIService.NUITakeFromHouse(obj)
	TriggerServerEvent("vorp_housing:TakeFromHouse", json.encode(obj))
end

function NUIService.OpenBankInventory(bankName, bankId, capacity)
	SetNuiFocus(true, true)
	SendNUIMessage({
		action = "display",
		type = "bank",
		title = bankName,
		bankId = bankId,
		capacity = capacity,
		search = Config.InventorySearchable
	})
	InInventory = true
end

function NUIService.NUIMoveToBank(obj)
	TriggerServerEvent("vorp_bank:MoveToBank", json.encode(obj))
end

function NUIService.NUITakeFromBank(obj)
	TriggerServerEvent("vorp_bank:TakeFromBank", json.encode(obj))
end

function NUIService.OpenHideoutInventory(hideoutName, hideoutId, capacity)
	SetNuiFocus(true, true)
	SendNUIMessage({
		action = "display",
		type = "hideout",
		title = hideoutName,
		hideoutId = hideoutId,
		capacity = capacity,
		search = Config.InventorySearchable
	})
	InInventory = true
end

function NUIService.NUIMoveToHideout(obj)
	TriggerServerEvent("syn_underground:MoveToHideout", json.encode(obj))
end

function NUIService.NUITakeFromHideout(obj)
	TriggerServerEvent("syn_underground:TakeFromHideout", json.encode(obj))
end

function NUIService.setProcessingPayFalse()
	isProcessingPay = false
end

function NUIService.NUIUnequipWeapon(obj)
	local data = obj

	if UserWeapons[tonumber(data.id)] then
		UserWeapons[tonumber(data.id)]:UnequipWeapon()
	end

	NUIService.LoadInv()
end

function NUIService.NUIGetNearPlayers(obj)
	local nearestPlayers = Utils.getNearestPlayers()

	local playerIds = {}
	for _, player in pairs(nearestPlayers) do
		playerIds[#playerIds + 1] = GetPlayerServerId(player)
	end
	TriggerServerEvent('vorp_inventory:getNearbyCharacters', obj, playerIds)
end

function NUIService.NUISetNearPlayers(obj, nearestPlayers)
	local nuiReturn = {}
	local isAnyPlayerFound = next(nearestPlayers) ~= nil
	local itemId = obj.id or 0
	local itemCount = obj.count or 1
	local itemHash = obj.hash or 1

	if not isAnyPlayerFound then
		TriggerEvent('vorp:TipRight', T.noplayersnearby, 5000)
		return
	end

	if Config.Debug then
		print('[^NUISetNearPlayers^7] ^2Info^7: players found = ' .. json.encode(nearestPlayers))
	end

	nuiReturn.action = "nearPlayers"
	nuiReturn.foundAny = isAnyPlayerFound
	nuiReturn.players = nearestPlayers
	nuiReturn.item = nuiReturn.item or obj.item
	nuiReturn.hash = itemHash
	nuiReturn.count = itemCount
	nuiReturn.id = itemId
	nuiReturn.type = obj.type
	nuiReturn.what = nuiReturn.what or obj.what

	SendNUIMessage(nuiReturn)
end

function NUIService.NUIGiveItem(obj)
	if not cangive then
		TriggerEvent('vorp:TipRight', T.cantgivehere, 5000)
	end

	local nearestPlayers = Utils.getNearestPlayers()
	local data = Utils.expandoProcessing(obj)
	local data2 = Utils.expandoProcessing(data.data)
	local isvalid = Validator.IsValidNuiCallback(data.hsn)

	if isvalid then
		for _, player in pairs(nearestPlayers) do
			if player ~= PlayerId() then
				if GetPlayerServerId(player) == tonumber(data.player) then
					local itemId = data2.id
					local target = tonumber(data.player)

					if data2.type == "item_money" then
						if isProcessingPay then return end
						isProcessingPay = true
						TriggerServerEvent("vorpinventory:giveMoneyToPlayer", target, tonumber(data2.count))
					elseif Config.UseGoldItem and data2.type == "item_gold" then
						if isProcessingPay then return end
						isProcessingPay = true
						TriggerServerEvent("vorpinventory:giveGoldToPlayer", target, tonumber(data2.count))
					elseif data2.type == "item_ammo" then
						if isProcessingPay then return end
						isProcessingPay = true
						local amount = tonumber(data2.count)
						local ammotype = data2.item
						local maxcount = SharedData.MaxAmmo[ammotype]
						if amount > 0 and maxcount >= amount then
							TriggerServerEvent("vorpinventory:servergiveammo", ammotype, amount, target, maxcount)
						end
					elseif data2.type == "item_standard" then
						local amount = tonumber(data2.count)
						local item = UserInventory[itemId]

						if amount > 0 and item ~= nil and item:getCount() >= amount then
							local itemName = item:getName()

							TriggerServerEvent("vorpinventory:serverGiveItem", itemId, amount, target)
						end
					else
						TriggerServerEvent("vorpinventory:serverGiveWeapon", tonumber(itemId), target)
					end
					if Config.Debug then
						print('[^NUIGiveItem^7] ^2Info^7: Reloading inv after sending info of giving item ?');
					end
					NUIService.LoadInv()
				end
			end
		end
	end
end

function NUIService.NUIDropItem(obj)
	if candrop then
		local aux = Utils.expandoProcessing(obj)
		local isvalid = Validator.IsValidNuiCallback(aux.hsn)

		if isvalid then
			local itemName = aux.item
			local itemId = aux.id
			local metadata = aux.metadata
			local type = aux.type
			local qty = tonumber(aux.number)

			if type == "item_money" then
				TriggerServerEvent("vorpinventory:serverDropMoney", qty)
			end

			if Config.UseGoldItem then
				if type == "item_gold" then
					TriggerServerEvent("vorpinventory:serverDropGold", qty)
				end
			end

			if type == "item_standard" then
				if aux.number ~= nil and aux.number ~= '' then
					local item = UserInventory[itemId]
					if not item then
						return
					end

					if qty <= 0 or qty > item:getCount() then
						return
					end

					TriggerServerEvent("vorpinventory:serverDropItem", itemName, itemId, qty, metadata)

					item:quitCount(qty)
					if item:getCount() == 0 then
						UserInventory[itemId] = nil
					end
				end
			end

			if type == "item_weapon" then
				TriggerServerEvent("vorpinventory:serverDropWeapon", aux.id)

				if UserWeapons[aux.id] then
					local weapon = UserWeapons[aux.id]

					if weapon:getUsed() then
						weapon:setUsed(false)
						weapon:UnequipWeapon()
					end

					UserWeapons[aux.id] = nil
				end
			end
			SetTimeout(100, function()
				NUIService.LoadInv()
			end)
		end
	else
		TriggerEvent('vorp:TipRight', T.cantdrophere, 5000)
	end
end

local function getGuidFromItemId(inventoryId, itemData, category, slotId)
	local outItem = DataView.ArrayBuffer(8 * 13)

	if not itemData then
		itemData = 0
	end
	--InventoryGetGuidFromItemid
	local success = Citizen.InvokeNative(0x886DFD3E185C8A89, inventoryId, itemData, category, slotId, outItem:Buffer())
	if success then
		return outItem:Buffer() --Seems to not return anythign diff. May need to pull from native above
	else
		return nil
	end
end

local function addWardrobeInventoryItem(itemName, slotHash)
	local itemHash = GetHashKey(itemName)
	local addReason = GetHashKey("ADD_REASON_DEFAULT")
	local inventoryId = 1

	-- _ITEMDATABASE_IS_KEY_VALID
	local isValid = Citizen.InvokeNative(0x6D5D51B188333FD1, itemHash, 0) --ItemdatabaseIsKeyValid
	if not isValid then
		return false
	end

	local characterItem = getGuidFromItemId(inventoryId, nil, GetHashKey("CHARACTER"), 0xA1212100)
	if not characterItem then
		return false
	end

	local wardrobeItem = getGuidFromItemId(inventoryId, characterItem, GetHashKey("WARDROBE"), 0x3DABBFA7)
	if not wardrobeItem then
		return false
	end

	local itemData = DataView.ArrayBuffer(8 * 13)

	-- _INVENTORY_ADD_ITEM_WITH_GUID
	local isAdded = Citizen.InvokeNative(0xCB5D11F9508A928D, inventoryId, itemData:Buffer(), wardrobeItem, itemHash,
		slotHash, 1, addReason)
	if not isAdded then
		return false
	end

	-- _INVENTORY_EQUIP_ITEM_WITH_GUID
	local equipped = Citizen.InvokeNative(0x734311E2852760D0, inventoryId, itemData:Buffer(), true)
	return equipped;
end

function NUIService.NUIUseItem(data)
	if data.type == "item_standard" then
		if timerUse <= 0 then
			TriggerServerEvent("vorp_inventory:useItem", data)
			timerUse = 2000
		else
			TriggerEvent('vorp:TipRight', T.slow, 5000)
		end
	elseif data.type == "item_weapon" then
		local ped = PlayerPedId()
		local _, weaponHash = GetCurrentPedWeapon(ped, false, 0, false)
		local weaponId = tonumber(data.id)
		local weapName = joaat(UserWeapons[weaponId]:getName())
		local isWeaponAGun = Citizen.InvokeNative(0x705BE297EEBDB95D, weapName)
		local isWeaponOneHanded = Citizen.InvokeNative(0xD955FEE4B87AFA07, weapName)
		local isArmed = Citizen.InvokeNative(0xCB690F680A3EA971, ped, 4)
		local notdual = false

		if (isWeaponAGun and isWeaponOneHanded) and isArmed then
			addWardrobeInventoryItem("CLOTHING_ITEM_M_OFFHAND_000_TINT_004", 0xF20B6B4A)
			addWardrobeInventoryItem("UPGRADE_OFFHAND_HOLSTER", 0x39E57B01)
			UserWeapons[weaponId]:setUsed2(true)
			if weaponHash == weapName then
				UserWeapons[weaponId]:equipwep(true)
			else
				UserWeapons[weaponId]:equipwep()
			end
			UserWeapons[weaponId]:loadComponents()
			UserWeapons[weaponId]:setUsed(true)
			TriggerServerEvent("syn_weapons:weaponused", data)
		elseif not UserWeapons[weaponId]:getUsed() and not Citizen.InvokeNative(0x8DECB02F88F428BC, ped, weapName, 0, true) or Citizen.InvokeNative(0x30E7C16B12DA8211, joaat(weapName)) then
			notdual = true
		end

		if notdual then
			UserWeapons[weaponId]:equipwep()
			UserWeapons[weaponId]:loadComponents()
			UserWeapons[weaponId]:setUsed(true)
			TriggerServerEvent("syn_weapons:weaponused", data)
		end
		if UserWeapons[weaponId]:getUsed() then
			local serial = UserWeapons[weaponId]:getSerialNumber()
			LocalPlayer.state:set("GetEquippedWeaponData", { weaponId = weaponId, serialNumber = serial }, false)
		end
		NUIService.LoadInv()
	end
end

function NUIService.NUISound()
	PlaySoundFrontend("BACK", "RDRO_Character_Creator_Sounds", true, 0)
end

function NUIService.NUIFocusOff()
	NUIService.CloseInv()
end

function NUIService.OfflineFocusOff()
	NUIService.CloseInventory()
end

function NUIService.LoadInv()
	local payload = {}
	local items = {}

	TriggerServerEvent("vorpinventory:check_slots")

	if not storemenu then
		for _, item in pairs(UserInventory) do
			table.insert(items, item)
		end
	elseif storemenu then
		for _, item in pairs(UserInventory) do
			if item.metadata ~= nil and item.metadata.description ~= nil and item.metadata.orgdescription ~= nil then
				item.metadata.description = item.metadata.orgdescription
				item.metadata.orgdescription = nil
			end
		end
		if geninfo.buyitems ~= nil and next(geninfo.buyitems) ~= nil then
			local buyitems = geninfo.buyitems
			for _, item in pairs(UserInventory) do
				for k, v in ipairs(buyitems) do
					if item.name == v.name then
						if item.metadata.description ~= nil then
							item.metadata.orgdescription = item.metadata.description
							item.metadata.description = item.metadata.description ..
								"<br><span style=color:Green;>" .. T.cansell .. v.price .. "</span>"
						else
							item.metadata.orgdescription = ""
							item.metadata.description = "<span style=color:Green;>" .. T.cansell .. v.price .. "</span>"
						end
					end
				end
				table.insert(items, item)
			end
		else
			for _, item in pairs(UserInventory) do
				table.insert(items, item)
			end
		end
	end
	for _, currentWeapon in pairs(UserWeapons) do
		local label = currentWeapon:getCustomLabel() or currentWeapon:getLabel()
		local weapon = {}
		weapon.count = currentWeapon:getTotalAmmoCount()
		weapon.limit = -1
		weapon.label = label
		weapon.name = currentWeapon:getName()
		weapon.metadata = {}
		weapon.hash = GetHashKey(currentWeapon:getName())
		weapon.type = "item_weapon"
		weapon.canUse = true
		weapon.canRemove = true
		weapon.id = currentWeapon:getId()
		weapon.used = currentWeapon:getUsed()
		weapon.desc = currentWeapon:getDesc()
		weapon.group = 5
		weapon.serial_number = currentWeapon:getSerialNumber()
		weapon.custom_label = currentWeapon:getCustomLabel()
		weapon.custom_desc = currentWeapon:getCustomDesc()

		table.insert(items, weapon)
	end

	payload.action = "setItems"
	payload.itemList = items

	SendNUIMessage(payload)
end

function NUIService.OpenInv()
	SetNuiFocus(true, true)
	SendNUIMessage({
		action = "display",
		type = "main",
		search = Config.InventorySearchable,
		autofocus = Config.InventorySearchAutoFocus
	})
	InInventory = true
	NUIService.LoadInv()
end

function NUIService.TransactionStarted()
	SetNuiFocus(true, false)
	SendNUIMessage({ action = "transaction", type = "started", text = T.TransactionLoading })
end

function NUIService.TransactionComplete(keepInventoryOpen)
	keepInventoryOpen = keepInventoryOpen == nil and true or keepInventoryOpen
	SetNuiFocus(keepInventoryOpen, keepInventoryOpen)
	SendNUIMessage({ action = "transaction", type = "completed" })
end

function NUIService.initiateData()
	-- Add Locales
	SendNUIMessage({
		action = "initiate",
		language = {
			empty = T.emptyammo,
			prompttitle = T.prompttitle,
			prompttitle2 = T.prompttitle2,
			promptaccept = T.promptaccept,
			inventoryclose = T.inventoryclose,
			inventorysearch = T.inventorysearch,
			toplayerpromptitle = T.toplayerpromptitle,
			toplaterpromptaccept = T.toplaterpromptaccept,
			gunbeltlabel = T.gunbeltlabel,
			gunbeltdescription = T.gunbeltdescription,
			inventorymoneylabel = T.inventorymoneylabel,
			inventorymoneydescription = T.inventorymoneydescription,
			givemoney = T.givemoney,
			dropmoney = T.dropmoney,
			inventorygoldlabel = T.inventorygoldlabel,
			inventorygolddescription = T.inventorygolddescription,
			givegold = T.givegold,
			dropgold = T.dropgold,
			unequip = T.unequip,
			equip = T.equip,
			use = T.use,
			give = T.give,
			drop = T.drop
		},
		config = {
			UseGoldItem = Config.UseGoldItem,
			AddGoldItem = Config.AddGoldItem,
			AddDollarItem = Config.AddDollarItem,
			AddAmmoItem = Config.AddAmmoItem,
			DoubleClickToUse = Config.DoubleClickToUse,
			UseRolItem = Config.UseRolItem
		}
	})
end

-- Main loop
Citizen.CreateThread(function()
	Wait(5000)
	NUIService.initiateData()

	while true do
		local sleep = 1000
		if not InInventory then
			sleep = 0
			if IsControlJustReleased(1, Config.OpenKey) and IsInputDisabled(0) then
				local player = PlayerPedId()
				local hogtied = Citizen.InvokeNative(0x3AA24CCC0D451379, player)
				local cuffed = Citizen.InvokeNative(0x74E559B3BC910685, player)
				if not hogtied and not cuffed and not InventoryIsDisabled then
					NUIService.OpenInv()
				end
			end
		end

		if Config.DisableDeathInventory then
			if InInventory and IsPedDeadOrDying(PlayerPedId(), false) then
				NUIService.CloseInv()
			end
		end
		Wait(sleep)
	end
end)

-- Prevent Spam
Citizen.CreateThread(function()
	while true do
		Wait(1000)
		if timerUse > 0 then
			timerUse = timerUse - 1000
		end
	end
end)

function NUIService.ChangeClothing(item)
	if item then
		ExecuteCommand(tostring(item))
	end
end

function NUIService.DisableInventory(param)
	InventoryIsDisabled = param
end
