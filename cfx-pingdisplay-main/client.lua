local curPing 	= 0
local limit 	= GetConvarInt('pingkick', 150)
local display 	= true

local function IsPingOverLimit() return curPing >= limit and true or false end

local function DrawTextOnScreen(text, x, y)
	if IsPingOverLimit() == false then
		SetTextColour(255, 255, 255, 255)
	else
		SetTextColour(255, 0, 0, 255)
	end

	SetTextFont(4)
	SetTextScale(0, 0.3)
	SetTextDropShadow(1, 0, 0, 0, 255)
	SetTextOutline()
	BeginTextCommandDisplayText("STRING")
	AddTextComponentSubstringPlayerName(text)
	EndTextCommandDisplayText(x, y)
end

local function Toggle(toggle)
	display = toggle == nil and not display or toggle

	TriggerEvent('chat:addMessage', 'Ping ' .. (display and 'Visible' or 'Hidden'))
end

RegisterNetEvent('ping:receive', function(ping) curPing = ping end)

Citizen.CreateThread(function() -- Get ping from server every 5s
	while true do
		if display then	TriggerServerEvent('ping:request') end
		Citizen.Wait(5000)
	end
end)

Citizen.CreateThread(function() -- Update Ping on Screen
	while true do
		if display then	DrawTextOnScreen(curPing .. 'ms' .. (IsPingOverLimit() and (' (Max: %dms)'):format(limit) or ''), 0.0009, 0.9798) end
		Citizen.Wait(5)
	end
end)

RegisterNetEvent('ping:toggle', Toggle)

RegisterCommand('ping', function() Toggle() end)