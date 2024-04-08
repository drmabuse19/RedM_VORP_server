TriggerEvent("menuapi:getData",function(call)
    MenuData = call
end)

local job

-- Saloons
Citizen.CreateThread(function()
    while true do
        local ped = GetPlayerPed()
        local coords = GetEntityCoords(PlayerPedId())
        local sleep = true

        for k,v in pairs(ConfigSl.SaloonLocs) do
            if GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) <= 2 then
                sleep = false
                TriggerEvent("enter:vsaloon")
                if whenKeyJustPressed(keys["B"]) then
                    TriggerServerEvent("hard_jobs:checkjobsaloon")
                end
            end
        end

        Citizen.Wait(5)

        if sleep then
            Wait(1000)
        end
    end
end)

function openSaloonmenu()
	MenuData.CloseAll()
	local elements = {
		{label = "Whiskey", value = 'whiskey' , desc = "Kjop Whiskey for 4 Nok"},
		{label = "Rum", value = 'rum' , desc = "Kjop Rum for 4 Nok"},
		{label = "Bourbon", value = 'bourbon' , desc = "Kjop Bourbon for 4 Nok"},
		{label = "Gin", value = 'gin' , desc = "Kjop Gin for 4 Nok"},
		{label = "Peanuts", value = 'peanuts' , desc = "Kjop Peanuts for 5 Nok"},
	}
   MenuData.Open('default', GetCurrentResourceName(), 'menuapi',
	{
		title    = "Saloon hylle",
		subtext    = "Kjop drikke",
		align    = 'left',
		elements = elements,
	},
	function(data, menu)
		if  (data.current.value == 'whiskey') then 
			TriggerServerEvent("hard_saloon:giveSaloonWhiskey")
            TriggerEvent("vorp:TipRight", "You Bought 1 Whiskey", 2000)

        elseif  (data.current.value == 'rum') then 
            TriggerServerEvent("hard_saloon:giveSaloonRum")
            TriggerEvent("vorp:TipRight", "You Bought 1 Rum", 2000)

        elseif  (data.current.value == 'bourbon') then 
            TriggerServerEvent("hard_saloon:giveSaloonBourbon")
            TriggerEvent("vorp:TipRight", "You Bought 1 Bourbon", 2000)

        elseif  (data.current.value == 'gin') then 
            TriggerServerEvent("hard_saloon:giveSaloonGin")
            TriggerEvent("vorp:TipRight", "You Bought 1 Gin", 2000)

        elseif  (data.current.value == 'peanuts') then 
            TriggerServerEvent("hard_saloon:giveSaloonGin")
            TriggerEvent("vorp:TipRight", "hard_saloon:giveSaloonPeanuts", 2000)

		end
	end,
	function(data, menu)
		menu.close()
	end)
end

RegisterNetEvent("enter:vsaloon")
AddEventHandler("enter:vsaloon", function()
    SetTextScale(0.3, 0.3)
    --SetTextFontForCurrentCommand(1)
    local msg = "Trykk B for salon hylle"
    local str = Citizen.InvokeNative(0xFA925AC00EB830B9, 10, "LITERAL_STRING", msg, Citizen.ResultAsLong())

    Citizen.InvokeNative(0xFA233F8FE190514C, str)
    Citizen.InvokeNative(0xE9990552DEC71600)
end)

RegisterNetEvent("hard_vsaloon:open")
AddEventHandler("hard_vsaloon:open", function()
    openSaloonmenu()
end)

function whenKeyJustPressed(key)
    if Citizen.InvokeNative(0x580417101DDB492F, 0, key) then
        return true
    else
        return false
    end
end

Citizen.CreateThread(function()
    for k, v in pairs(ConfigSl.SaloonLocs) do
        local blip = N_0x554d9d53f696d002(1664425300, v.Pos.x, v.Pos.y, v.Pos.z)
        SetBlipSprite(blip, 1879260108, 1)
        Citizen.InvokeNative(0x9CB1A1623062F402, blip, "Saloon")
    end
end)
