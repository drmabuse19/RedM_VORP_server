local VORPcore = {}

TriggerEvent("getCore", function(core)
	VORPcore = core
end)

local posseid
local possename
local number

RegisterServerEvent("bcc-posse:grabinfo")
AddEventHandler("bcc-posse:grabinfo", function(id, radius)
	local _source = id
	if _source == nil then
		_source = source
	end
	Wait(100)
	local player = VORPcore.getUser(_source).getUsedCharacter
	local charid = player.charIdentifier
	local result = MySQL.query.await("SELECT posseid FROM characters WHERE charidentifier=@characterid",
		{ ["characterid"] = charid })
	if result ~= 0 then
		posseid = result[1].posseid
	else
		TriggerClientEvent("vorp:TipBottom", _source, "not in posse", 3000)
	end
	local inposse = false
	if posseid ~= 0 then
		inposse = true
	end
	TriggerClientEvent('bcc-posse:sendinfo', _source, posseid, inposse, radius)
end)

RegisterServerEvent("bcc-posse:checkposse")
AddEventHandler("bcc-posse:checkposse", function(targetid, id)
	local _source = source
	if _source == nil then
		_source = source
	end
	local target = VORPcore.getUser(targetid).getUsedCharacter
	local tarid = target.charIdentifier

	exports.ghmattimysql:execute("SELECT posseid FROM `characters` WHERE charidentifier = @characterid",
		{ ["@characterid"] = tarid },
		function(result)
			if result[1].posseid == id then
				id = result[1].posseid
				TriggerClientEvent('bcc-posse:possefound', _source)
			end
		end)
end)


RegisterServerEvent("bcc-posse:leaveposse")
AddEventHandler("bcc-posse:leaveposse", function(posseid)
	local _source = source
	local player = VORPcore.getUser(_source).getUsedCharacter
	local steamid = player.identifier
	local charid = player.charIdentifier
	exports.ghmattimysql:execute("SELECT id FROM `posse` WHERE characterid = @characterid",
		{ ["@characterid"] = charid },
		function(result)
			if result[1] then
				exports.ghmattimysql:execute(
					'UPDATE characters SET posseid=@newposseid WHERE posseid = posseid ',
					{ ['@newposseid'] = 0, ['posseid'] = posseid })


				exports.ghmattimysql:execute("SELECT * FROM `posse` WHERE characterid = @targetid",
					{ ["@targetid"] = charid },
					function(result)
						possename = result[1].possename
					end)

				exports.ghmattimysql:execute(
					'DELETE FROM posse WHERE identifier = @identifier AND characterid = @charid', {
						['@identifier'] = steamid,
						['@charid'] = charid,
					})
			else
				exports.ghmattimysql:execute(
					'UPDATE characters SET posseid=@newposseid WHERE posseid = posseid and charidentifier = @charid',
					{ ['@newposseid'] = 0, ['posseid'] = posseid, ['@charid'] = charid })
			end
		end)
end)

RegisterServerEvent("bcc-posse:beeninvitedsv")
AddEventHandler("bcc-posse:beeninvitedsv", function(targetid)
	local _source = source

	local target = VORPcore.getUser(targetid).getUsedCharacter
	local tarid = target.charIdentifier
	local Character = VORPcore.getUser(_source).getUsedCharacter
	local charid = Character.charIdentifier

	exports.ghmattimysql:execute("SELECT * FROM `characters` WHERE charidentifier = @targetid",
		{ ["@targetid"] = tarid },
		function(result)
			posseid = result[1].posseid

	exports.ghmattimysql:execute("SELECT * FROM `posse` WHERE characterid = @characterid",
		{ ["@characterid"] = charid },
		function(result)
			possename = result[1].possename
			number = result[1].id
			Wait(100)
			if posseid == 0 then
				TriggerClientEvent('bcc-posse:sendposseinvites', targetid, number, possename, true)
				TriggerClientEvent("vorp:NotifyLeft", targetid, 'Posse Invite', 'You have been invited to a posse',
					'inventory_items',
					'folder_invitations', 5000)
			else
				TriggerClientEvent("vorp:TipBottom", targetid, "already in posse", 3000)
			end
		end)
	end)

end)

RegisterServerEvent("bcc-posse:acceptinvite")
AddEventHandler("bcc-posse:acceptinvite", function(possenumber)
	local _source = source
	local Character = VORPcore.getUser(_source).getUsedCharacter
	local steamid = Character.identifier
	local charid = Character.charIdentifier

	exports.ghmattimysql:execute("SELECT * FROM `characters` WHERE charidentifier = @characterid",
		{ ["@characterid"] = charid },
		function(result)
			posseid = result[1].posseid

			if posseid == 0 then
				exports.ghmattimysql:execute(
					'UPDATE characters SET posseid=@posseid WHERE identifier=@identifier AND charidentifier=@charidentifier',
					{ ['posseid'] = possenumber, ['identifier'] = steamid, ['charidentifier'] = charid })
				TriggerClientEvent("vorp:TipBottom", _source, "joined posse", 3000)
			else
				TriggerClientEvent("vorp:TipBottom", _source, "already in posse", 3000)
			end
		end)
end)

RegisterServerEvent("bcc-posse:createposse")
AddEventHandler("bcc-posse:createposse", function(possename)
	local _source = source
	local player = VORPcore.getUser(_source).getUsedCharacter
	local steamid = player.identifier
	local charid = player.charIdentifier
	exports.ghmattimysql:execute("SELECT id FROM `posse` WHERE characterid = @characterid",
		{ ["@characterid"] = charid },
		function(result)
			if result[1] then
				TriggerClientEvent("vorp:TipBottom", _source, "Posse exists ", 3000)
			else
				exports.ghmattimysql:execute(
					"INSERT INTO posse (identifier, characterid, possename) VALUES (@identifier, @characterid, @possename)"
					, { ["@identifier"] = steamid, ["@characterid"] = charid, ["@possename"] = possename })
				TriggerClientEvent("vorp:TipBottom", _source, "Posse created ", 3000)
			end
		end)
	Wait(200)

	exports.ghmattimysql:execute("SELECT * FROM `posse` WHERE characterid = @characterid",
		{ ["@characterid"] = charid },
		function(result)
			posseid = result[1].id
			exports.ghmattimysql:execute(
				'UPDATE characters SET posseid=@posseid WHERE identifier=@identifier AND charidentifier=@charidentifier',
				{ ['posseid'] = posseid, ['identifier'] = steamid, ['charidentifier'] = charid })
		end)
end)

RegisterServerEvent("bcc-posse:posselist")
AddEventHandler("bcc-posse:posselist", function(possenumber)
	print(possenumber)
	local _source = source

	if possenumber > 0 then
		exports.ghmattimysql:execute(
			"SELECT firstname, lastname, charidentifier FROM characters WHERE posseid = @posseid",
			{ ["posseid"] = possenumber },
			function(result)
				TriggerClientEvent('bcc-posse:ViewMembersMenu', _source, result)
			end)
	end
end)
