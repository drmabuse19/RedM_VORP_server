local VORPcore = {}
local posselist = {}
Possetable = {}
local possenumber
local playid
local isinvited = false
local invitedpossename
local possename = " "

TriggerEvent("getCore", function(core)
	VORPcore = core
end)

TriggerEvent('chat:addSuggestion', '/posse', 'Posse Menu Command')

RegisterCommand('posse', function()
	PosseMenu()
end)

RegisterNetEvent('bcc-posse:sendinfo')
AddEventHandler('bcc-posse:sendinfo', function(posseid, inposse, radius)
	local closestPlayer, closestDistance = GetClosestPlayer()
	local targetid = GetPlayerServerId(closestPlayer)
	possenumber = posseid
	if not inposse then
		inposse = false
	else
		inposse = true
		if closestPlayer ~= -1 and closestDistance <= radius then
			TriggerServerEvent('bcc-posse:checkposse', tonumber(targetid), possenumber)
		end
		--local id = GetPlayerServerId(GetPlayerIndex())
		--table.insert(Possetable, id)
	end
	print(possenumber)
end)

function CheckPosseArea(coords, radius)
	Possetable = {}
	local pedcoords = coords
	local ptable = GetActivePlayers()
	for _, i in pairs(ptable) do
		local targetped = GetPlayerPed(i)
		playid = GetPlayerServerId(i)
		if (Vdist(GetEntityCoords(targetped), pedcoords.x, pedcoords.y, pedcoords.z) < radius) then
			if contains(Possetable, playid) then
				print('its the same')
				break
			else
				TriggerServerEvent('bcc-posse:grabinfo', playid, radius)
			end
		end
	end
	Wait(750)
	return Possetable, #Possetable
end

function contains(table, val)
	for i = 1, #table do
		if table[i] == val then
			return true
		end
	end
	return false
end

RegisterNetEvent('bcc-posse:possefound')
AddEventHandler('bcc-posse:possefound', function()
	table.insert(Possetable, playid)
end)

RegisterNetEvent('bcc-posse:sendposseinvites')
AddEventHandler('bcc-posse:sendposseinvites', function(posseid, posseinvites, invite)
	isinvited = invite
	invitedpossename = posseinvites
	invitenumber = posseid
	possenumber = invitenumber
	print(possenumber)

end)

MenuData = {}
TriggerEvent("menuapi:getData", function(call)
	MenuData = call
end)
function PosseMenu() -- Base Menu Logic
	TriggerServerEvent('bcc-posse:grabinfo',source,Config.InviteDistance)

	MenuData.CloseAll()
	local elements = {}

	if isinvited then
		table.insert(elements, { label = "Create Posse", value = 'create' })
		table.insert(elements, { label = "Invite to posse", value = 'invite' })
		table.insert(elements, { label = "Accept Posse Invites", value = 'viewinvites' })
		table.insert(elements, { label = "View Members", value = 'view' })
		table.insert(elements, { label = "Leave Posse", value = 'leave' })
	else
		table.insert(elements, { label = "Create Posse", value = 'create' })
		table.insert(elements, { label = "Invite to posse", value = 'invite' })
		table.insert(elements, { label = "View Members", value = 'view' })
		table.insert(elements, { label = "Leave Posse", value = 'leave' })
	end

	MenuData.Open('default', GetCurrentResourceName(), 'menuapi',
		{
			title    = "Posse Menu",
			align    = 'left',
			elements = elements,
		},
		function(data, menu)
			if (data.current.value == 'create') then
				CreatePosseMenu()
			end
			if (data.current.value == 'view') then
				Wait(250)
				TriggerServerEvent('bcc-posse:posselist', possenumber)
			end
			if (data.current.value == 'leave') then
				Wait(100)
				TriggerServerEvent('bcc-posse:leaveposse')
				menu.close()
			end

			if (data.current.value == 'invite') then
				local closestPlayer, closestDistance = GetClosestPlayer()
				if closestPlayer ~= -1 and closestDistance <= 1.5 then
					TriggerServerEvent('bcc-posse:beeninvitedsv', GetPlayerServerId(closestPlayer))
				else
					VORPcore.NotifyBottomRight("Not close enough", 4000)
				end
			end

			if (data.current.value == 'viewinvites') then
				Wait(250)
				ViewPosseInvites()
			end
		end,
		function(data, menu)
			menu.close()
		end)
end

function CreatePosseMenu() -- Create Posse Menu logic
	MenuData.CloseAll()
	local button = "Confirm"
	local placeholder = "Posse Name"

	local elements = {
		{ label = "Posse Name: " .. possename, value = 'name' },
		{ label = "Confirm Posse Name",        value = 'confirm' },

	}
	MenuData.Open('default', GetCurrentResourceName(), 'menuapi',
		{
			title    = "Posse Menu",
			align    = 'left',
			elements = elements,
			lastmenu = "PosseMenu"
		},
		function(data, menu)
			if data.current == "backup" then
				_G[data.trigger]()
			end
			if (data.current.value == 'name') then
				TriggerEvent("vorpinputs:getInput", button, placeholder, function(result)
					if result ~= "" or result then -- making sure its not empty or nil
						possename = result
						CreatePosseMenu()
					else
						print("its empty?") -- notify
					end
				end)
			end

			if (data.current.value == 'confirm') then
				TriggerServerEvent('bcc-posse:createposse', possename)
				menu.close()
			end
		end,
		function(data, menu)
			menu.close()
		end)
end

function ViewPosseInvites() -- ViewInvite Logic
	MenuData.CloseAll()
	local elements = {
		{ label = invitenumber .. " : " .. invitedpossename, value = 'posse' },
		{ label = "Accept",                                 value = 'accept' },
		{ label = "Deny",                                   value = 'deny' },


	}

	MenuData.Open('default', GetCurrentResourceName(), 'menuapi',
		{
			title    = "Posse Menu",
			align    = 'left',
			elements = elements,
			lastmenu = "PosseMenu"
		},
		function(data, menu)
			if data.current == "backup" then
				_G[data.trigger]()
			end
			if data.current.value == "accept" then
				TriggerServerEvent('bcc-posse:acceptinvite', invitenumber)
				isinvited = false
				menu.close()
			end
			if data.current.value == "deny" then
				isinvited = false
				menu.close()
			end
		end,
		function(data, menu)
		end)
end

RegisterNetEvent('bcc-posse:ViewMembersMenu', function(result)
	-- View Member Logic
	MenuData.CloseAll()
	local elements, elementindex = {}, 1
	for key, v in pairs(result) do
		elements[elementindex] = {
			label = v.firstname .. " " .. v.lastname,
			value = "players"
		}
		elementindex = elementindex + 1
	end

	MenuData.Open('default', GetCurrentResourceName(), 'menuapi',
		{
			title    = "Posse Menu",
			align    = 'left',
			elements = elements,
			lastmenu = "PosseMenu"
		},
		function(data, menu)
			if data.current == "backup" then
				_G[data.trigger]()
			end
		end,
		function(data, menu)
			menu.close()
		end)
end)

function GetClosestPlayer()
	local players, closestDistance, closestPlayer = GetActivePlayers(), -1, -1
	local playerPed, playerId = PlayerPedId(), PlayerId()
	local coords, usePlayerPed = coords, false

	if coords then
		coords = vector3(coords.x, coords.y, coords.z)
	else
		usePlayerPed = true
		coords = GetEntityCoords(playerPed)
	end

	for i = 1, #players, 1 do
		local tgt = GetPlayerPed(players[i])

		if not usePlayerPed or (usePlayerPed and players[i] ~= playerId) then
			local targetCoords = GetEntityCoords(tgt)
			local distance = #(coords - targetCoords)

			if closestDistance == -1 or closestDistance > distance then
				closestPlayer = players[i]
				closestDistance = distance
			end
		end
	end
	return closestPlayer, closestDistance
end
