local VORPcore = {}
TriggerEvent("getCore", function(core)
	VORPcore = core
end)

local VORPInv =  exports.vorp_inventory:vorp_inventoryApi()


RegisterNetEvent('bccblindfold:toggleblindfold')
AddEventHandler('bccblindfold:toggleblindfold', function(player, toggle)
	local _source = source
	local passed = true
	if player ~= nil then
		if Config.blindfolditem and toggle == true then
			local itemCount = VORPInv.getItemCount(_source, 'blindfold')
			if itemCount > 0 then
				VORPInv.subItem(_source, 'blindfold', 1)
			else
				passed = false
				VORPcore.NotifyRightTip(_source, Config.lang.noitem,4000)
			end
		end

		if passed then
			if player == 'self' then
				player = source
			end
		
			local Character = VORPcore.getUser(player).getUsedCharacter
		
			local skin = json.decode(Character.skin)
			local comps = Character.comps
			local playerSex = string.gsub(tostring(skin["sex"]), "mp_", "")
		
			TriggerClientEvent('bccblindfold:togblindfold', player, playerSex, comps, toggle)
		end
	else
		VORPcore.NotifyRightTip(_source, Config.lang.noplayers,4000)
	end
end)

if Config.blindfolditem then
	-- Facemask Usable Item
	VORPInv.RegisterUsableItem('blindfold', function(data)
		-- VORPInv.subItem(data.source, 'blindfold', 1)
		TriggerClientEvent("bccblindfold:blindfolditem", data.source)
		VORPInv.CloseInv(data.source)
	end)		
end