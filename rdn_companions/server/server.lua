-- Based on Malik's and Blue's animal shelters and vorp animal shelter --
local data = {}
local VorpCore = {}
local VorpInv

if Config.Framework == "redem" then
	TriggerEvent("redemrp_inventory:getData",function(call)
		data = call
	end)
elseif Config.Framework == "vorp" then
	TriggerEvent("getCore",function(core)
		VorpCore = core
	end)
	VorpInv = exports.vorp_inventory:vorp_inventoryApi()
end

RegisterServerEvent('rdn_companions:sellpet')
AddEventHandler('rdn_companions:sellpet', function()

	local _src = source

	if Config.Framework == "redem" then
	  TriggerEvent('redemrp:getPlayerFromId', _src, function(user)
			local u_identifier = user.getIdentifier()
			local u_charid = user.getSessionVar("charid")

			 MySQL.Sync.execute("DELETE FROM companions WHERE identifier = @identifier AND charidentifier = @charidentifier", {["identifier"] = u_identifier, ['charidentifier'] = u_charid})
			TriggerClientEvent('rdn_companions:removedog', _src)
			
		end)
	elseif Config.Framework == "vorp" then
			local Character = VorpCore.getUser(_src).getUsedCharacter
			local u_identifier = Character.identifier
			local u_charid = Character.charIdentifier
		 exports.ghmattimysql:execute("DELETE FROM companions WHERE identifier = @identifier AND charidentifier = @charidentifier", {["identifier"] = u_identifier, ['charidentifier'] = u_charid})
		TriggerClientEvent('rdn_companions:removedog', _src)
			
	end 
end)


RegisterServerEvent('rdn_companions:feedPet')
AddEventHandler('rdn_companions:feedPet', function(xp)

        local _src = source
		
		if Config.Framework == "redem" then
	TriggerEvent('redemrp:getPlayerFromId', _src, function(user)
        local u_identifier = user.getIdentifier()
        local u_charid = user.getSessionVar("charid")
		
		local currentXP = xp
		local newXp = currentXP + Config.XpPerFeed
	
		local ItemData = data.getItem(_src, Config.AnimalFood)
		local amount = ItemData.ItemAmount
		if amount >= 1 then
			if newXp <= Config.FullGrownXp then

				ItemData.RemoveItem(1)

				 local Parameters = { ['identifier'] = u_identifier, ['charidentifier'] = u_charid,  ['addedXp'] = Config.XpPerFeed }
				MySQL.Sync.execute("UPDATE companions SET xp = xp + @addedXp  WHERE identifier = @identifier AND charidentifier = @charidentifier", Parameters, function(result) end)		
				TriggerClientEvent('redem_roleplay:NotifyLeft',_src, "+"..Config.XpPerFeed.." Pet XP",newXp.."/"..Config.FullGrownXp.." XP" , "HUD_TOASTS", "toast_mp_status_change", 8000)
				TriggerClientEvent('rdn_companions:UpdateDogFed', _src, newXp)
			else
			
			ItemData.RemoveItem(1)
			
			TriggerClientEvent('rdn_companions:UpdateDogFed', _src, newXp)
			end	
		else
		 TriggerClientEvent( 'UI:DrawNotification', _src, _U('NoFood') )
		end
	end)
	elseif Config.Framework == 'vorp' then
		local Character = VorpCore.getUser(_src).getUsedCharacter
		local u_identifier = Character.identifier
		local u_charid = Character.charIdentifier		
		local currentXP = xp
		local newXp = currentXP + Config.XpPerFeed
		local amount = VorpInv.getItemCount(_src, Config.AnimalFood)
		if amount >= 1 then
			if newXp <= Config.FullGrownXp then

				VorpInv.subItem(_src,Config.AnimalFood,1)

				 local Parameters = { ['identifier'] = u_identifier, ['charidentifier'] = u_charid,  ['addedXp'] = Config.XpPerFeed }
				exports.ghmattimysql:execute("UPDATE companions SET xp = xp + @addedXp  WHERE identifier = @identifier AND charidentifier = @charidentifier", Parameters, function(result) end)		
				--TriggerClientEvent('redem_roleplay:NotifyLeft',_src, "+"..Config.XpPerFeed.." Pet XP",newXp.."/"..Config.FullGrownXp.." XP" , "generic_textures", "tick", 8000)	
				TriggerClientEvent('UI:DrawNotification', _src, "+"..Config.XpPerFeed.." Pet XP Progress:"..newXp.."/"..Config.FullGrownXp.." XP")				
				TriggerClientEvent('rdn_companions:UpdateDogFed', _src, newXp)
			else			
			VorpInv.subItem(_src,Config.AnimalFood,1)		
			TriggerClientEvent('rdn_companions:UpdateDogFed', _src, newXp)
			end	
		else
		 TriggerClientEvent('UI:DrawNotification', _src, _U('NoFood'))
		end
	end
end)

RegisterServerEvent('rdn_companions:buydog')
AddEventHandler('rdn_companions:buydog', function (args)
        local _src = source
	if Config.Framework == "redem" then
	TriggerEvent('redemrp:getPlayerFromId', _src, function(user)
        local u_identifier = user.getIdentifier()
        local u_charid = user.getSessionVar("charid")
		local _price = args['Price']
		local _model = args['Model']
		local skin = math.floor(math.random(0, 2))
		local canTrack = CanTrack(_src)
		u_money = user.getMoney()

		if u_money <= _price then
			TriggerClientEvent( 'UI:DrawNotification', _src, _U('NoMoney') )
			return
		end

		MySQL.Async.fetchAll("SELECT * FROM companions WHERE identifier = @identifier AND charidentifier = @charidentifier", {['identifier'] = u_identifier, ['charidentifier'] = u_charid}, function(result)
			if #result > 0 then 
				local Parameters = { ['identifier'] = u_identifier, ['charidentifier'] = u_charid,  ['dog'] = _model, ['skin'] = skin , ['xp'] = 0 }
			   MySQL.Sync.execute(" UPDATE companions SET dog = @dog, skin = @skin, xp = @xp WHERE identifier = @identifier AND charidentifier = @charidentifier", Parameters, function(r1)
				end)
					user.removeMoney(_price)
					TriggerClientEvent('rdn_companions:spawndog', _src, _model, skin, true, 0,canTrack)
					TriggerClientEvent( 'UI:DrawNotification', _src, _U('ReplacePet') )				
			else
				local Parameters = { ['identifier'] = u_identifier, ['charidentifier'] = u_charid,  ['dog'] = _model, ['skin'] = skin, ['xp'] = 0 }
			   MySQL.Sync.execute("INSERT INTO companions ( `identifier`,`charidentifier`,`dog`,`skin`, `xp` ) VALUES ( @identifier,@charidentifier, @dog, @skin, @xp )", Parameters, function(r2)
				end)
					user.removeMoney(_price)
					TriggerClientEvent('rdn_companions:spawndog', _src, _model, skin, true, 0,canTrack)
					TriggerClientEvent( 'UI:DrawNotification', _src, _U('NewPet') )								
			end
		end)
	end)
	elseif Config.Framework == "vorp" then
		local Character = VorpCore.getUser(_src).getUsedCharacter
		local u_identifier = Character.identifier
		local u_charid = Character.charIdentifier
		local _price = args['Price']
		local _model = args['Model']
		local skin = math.floor(math.random(0, 2))
		local canTrack = CanTrack(_src)
		u_money = Character.money

		if u_money <= _price then
			TriggerClientEvent( 'UI:DrawNotification', _src, _U('NoMoney') )
			return
		end
		exports.ghmattimysql:execute("SELECT * FROM companions WHERE identifier = @identifier AND charidentifier = @charidentifier", {['identifier'] = u_identifier, ['charidentifier'] = u_charid}, function(result)
			if #result > 0 then 
				local Parameters = { ['identifier'] = u_identifier, ['charidentifier'] = u_charid,  ['dog'] = _model, ['skin'] = skin , ['xp'] = 0 }
			   exports.ghmattimysql:execute(" UPDATE companions SET dog = @dog, skin = @skin, xp = @xp WHERE identifier = @identifier AND charidentifier = @charidentifier", Parameters, function(r1)
					Character.removeCurrency(0, _price)
					TriggerClientEvent('rdn_companions:spawndog', _src, _model, skin, true, 0,canTrack)
					TriggerClientEvent( 'UI:DrawNotification', _src, _U('ReplacePet') )
				end)
			else
				local Parameters = { ['identifier'] = u_identifier, ['charidentifier'] = u_charid,  ['dog'] = _model, ['skin'] = skin, ['xp'] = 0 }
			   exports.ghmattimysql:execute("INSERT INTO companions ( `identifier`,`charidentifier`,`dog`,`skin`, `xp` ) VALUES ( @identifier,@charidentifier, @dog, @skin, @xp )", Parameters, function(r2)
					Character.removeCurrency(0, _price)
					TriggerClientEvent('rdn_companions:spawndog', _src, _model, skin, true, 0,canTrack)
					TriggerClientEvent( 'UI:DrawNotification', _src, _U('NewPet') )
				end)
			end
		end)			
	end
end)

RegisterServerEvent('rdn_companions:loaddog')
AddEventHandler('rdn_companions:loaddog', function()
    local _src   = source
	if Config.Framework == "redem" then
	TriggerEvent('redemrp:getPlayerFromId', _src, function(user)
		local u_identifier = user.getIdentifier()
		local u_charid = user.getSessionVar("charid")
		local canTrack = CanTrack(_src)
		local Parameters = { ['identifier'] = u_identifier, ['charidentifier'] = u_charid }
		MySQL.Async.fetchAll( "SELECT * FROM companions WHERE identifier = @identifier  AND charidentifier = @charidentifier", Parameters, function(result)
			if result[1] then
				local dog = result[1].dog
				local skin = result[1].skin
				local xp = result[1].xp or 0
				TriggerClientEvent("rdn_companions:spawndog", _src, dog, skin, false, xp,canTrack)
			else
				TriggerClientEvent( 'UI:DrawNotification', _src, _U('NoPet') )
			end
		end)
	end)
	elseif Config.Framework == "vorp" then
		local Character = VorpCore.getUser(_src).getUsedCharacter
		local u_identifier = Character.identifier
		local u_charid = Character.charIdentifier
		local canTrack = CanTrack(_src)
		local Parameters = { ['identifier'] = u_identifier, ['charidentifier'] = u_charid }
		exports.ghmattimysql:execute( "SELECT * FROM companions WHERE identifier = @identifier  AND charidentifier = @charidentifier", Parameters, function(result)
			if result[1] then
				local dog = result[1].dog
				local skin = result[1].skin
				local xp = result[1].xp or 0
				TriggerClientEvent("rdn_companions:spawndog", _src, dog, skin, false, xp,canTrack)
			else
				TriggerClientEvent( 'UI:DrawNotification', _src, _U('NoPet') )
			end
		end)	
	end
end)


function CanTrack(source)
	local cb = false
	if Config.TrackCommand then
		if Config.AnimalTrackingJobOnly then
			local job = getJob(source)
			for k, v in pairs(Config.AnimalTrackingJobs) do
				if job == v then
				cb = true
				end
			end
		else 
			cb = true
		end
	end
	return(cb)
end


function getJob(source)
 local cb = false
 
	 if Config.Framework == "redem" then
		TriggerEvent('redemrp:getPlayerFromId', source, function(user)
			cb = user.getJob() 
		end)	
	 elseif Config.Framework == "vorp" then
		local Character = VorpCore.getUser(source).getUsedCharacter
		cb = Character.job
	 end
	 
 return cb
end
