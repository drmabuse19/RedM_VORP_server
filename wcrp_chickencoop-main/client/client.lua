local keys = { ['G'] = 0x760A9C6F, ['S'] = 0xD27782E3, ['W'] = 0x8FD015D8, ['H'] = 0x24978A28, ['G'] = 0x5415BE48, ["ENTER"] = 0xC7B5340A, ['E'] = 0xDFF812F9,["BACKSPACE"] = 0x156F7119 }

--menu

Citizen.CreateThread(function()
	while true do
        Citizen.Wait(1)
        local sleep = true
		local coords = GetEntityCoords(PlayerPedId())
    if (Vdist(coords.x, coords.y, coords.z, -1583.41, -1393.52, 82.02) < 2.0) then
        sleep = false
            DrawTxt("Trykk [~e~G~q~] for a sammle egg.", 0.50, 0.85, 0.7, 0.7, true, 255, 255, 255, 255, true)
            if IsControlJustReleased(0, 0x760A9C6F) then -- g
                --TriggerEvent("gathering:eggs")
                TriggerServerEvent("wcrpgathering:eggs")
                --print('openedwarmenu')

            end
        end
    end
    if sleep then
        Citizen.Wait(1000)
    end
end)

Citizen.CreateThread(function()
	while true do
        Citizen.Wait(1)
        local sleep = true
		local coords = GetEntityCoords(PlayerPedId())
    if (Vdist(coords.x, coords.y, coords.z, -248.13, 673.79, 114.14) < 2.0) then
        sleep = false
            DrawTxt("Trykk [~e~G~q~] for a sammle egg.", 0.50, 0.85, 0.7, 0.7, true, 255, 255, 255, 255, true)
            if IsControlJustReleased(0, 0x760A9C6F) then -- g
                --TriggerEvent("gathering:eggs")
                TriggerServerEvent("wcrpgathering:eggs")
                --print('openedwarmenu')

            end
        end
    end
    if sleep then
        Citizen.Wait(1000)
    end
end)


--Citizen.CreateThread(function()
--	while true do
--		Citizen.Wait(1)
--		local coords = GetEntityCoords(PlayerPedId())
--    if (Vdist(coords.x, coords.y, coords.z, -2396.51, -2378.06, 61.23) < 2.0) then
--            DrawTxt("Trykk [~e~G~q~] to Smelt.", 0.50, 0.85, 0.7, 0.7, true, 255, 255, 255, 255, true)
--            if IsControlJustReleased(0, 0x760A9C6F) then -- g
--                TriggerEvent("gathering:open")
--                print('openedwarmenu')
--
--            end
--        end
--    end
--end)

Citizen.CreateThread(function()
    WarMenu.CreateMenu('gathering', "Egg Gatherin")
    WarMenu.SetSubTitle('gathering', 'Smithing')
    WarMenu.CreateSubMenu('gathering2', 'gathering', 'Gathering')
  

    while true do
        local ped = GetPlayerPed(-1)
        local coords = GetEntityCoords(PlayerPedId())

        if WarMenu.IsMenuOpened('gathering') then
            if WarMenu.MenuButton('Gathering', 'gathering2') then
            end
            WarMenu.Display()
        elseif WarMenu.IsMenuOpened('gathering2') then
            if WarMenu.Button('Gather Eggs') then
                    TriggerServerEvent("wcrpgathering:eggs")
                    --WarMenu.CloseMenu()
            --elseif WarMenu.Button('Item2') then
            --        TriggerServerEvent("wc_craftitem:Item2")
            --        --WarMenu.CloseMenu()
            --elseif WarMenu.Button('Item3') then
            --        TriggerServerEvent("wc_craftitem:Item3")
            --        --WarMenu.CloseMenu()
            --elseif WarMenu.Button('Item4') then
            --        TriggerServerEvent("wc_craftitem:Item4")
            --        --WarMenu.CloseMenu()
            --elseif WarMenu.Button('Item5') then
            --        TriggerServerEvent("wc_craftitem:Item5")
            --        --WarMenu.CloseMenu()
            --elseif WarMenu.Button('Item6') then
            --        TriggerServerEvent("wc_craftitem:Item6")
            --        --WarMenu.CloseMenu()
            --elseif WarMenu.Button('Item7') then
            --        TriggerServerEvent("wc_craftitem:Item7")
            --        --WarMenu.CloseMenu()
            --elseif WarMenu.Button('Item8') then
            --        TriggerServerEvent("wc_craftitem:Item8")
                    --WarMenu.CloseMenu()
                end
   
            WarMenu.Display()
		
        end
        Citizen.Wait(0)
    end
end)

--RegisterCommand("cookfood", function(source, args, rawCommand) -- craft COMMAND
AddEventHandler('gathering:eggs', function()
local _source = source
		if cauldron ~= 0 then
            SetEntityAsMissionEntity(cauldron)
            DeleteObject(cauldron)
            cauldron = 0
            end
            local playerPed = PlayerPedId()
			Citizen.Wait(0)
            ClearPedTasksImmediately(PlayerPedId())
			WarMenu.OpenMenu('gathering')
            TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_HAMMER_TABLE'), -1, true, false, false, false)
       
            local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 2.0, -1.55))
            --local prop = CreateObject(GetHashKey("p_cs_note01x"), x, y, z, true, false, true)
            SetEntityHeading(prop, GetEntityHeading(PlayerPedId()))
            PlaceObjectOnGroundProperly(prop)
            cauldron = prop

--end, false)
end)

Citizen.CreateThread(function()
    while true do
	local playerPed = PlayerPedId()
        Citizen.Wait(0)
		
        if whenKeyJustPressed(keys['BACKSPACE']) then
            if cauldron ~= 0 then
            SetEntityAsMissionEntity(cauldron)
            DeleteObject(cauldron)
			ClearPedTasksImmediately(PlayerPedId())
            cauldron = 0
            end
     end
	end
end)


--- Settings ProgressBars ---

--- Flesh --- 



RegisterNetEvent('wcrpgathering:eggs')
AddEventHandler('wcrpgathering:eggs', function()

    local playerPed = PlayerPedId()
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_CROUCH_INSPECT'), 27000, true, false, false, false)
    exports['progressBars']:startUI(27000, "Gathering...")
    Citizen.Wait(27000)
    ClearPedTasksImmediately(PlayerPedId())

end)

function whenKeyJustPressed(key)
    if Citizen.InvokeNative(0x580417101DDB492F, 0, key) then
        return true
    else
        return false
    end
end

--RegisterNetEvent("smelting:time")
--AddEventHandler("smelting:time", function()

   -- local playerPed = PlayerPedId()
    --exports['progressBars']:startUI(27000, "Still Smelting...")


--end)

RegisterNetEvent("wc_craftitem:prompt")
AddEventHandler("wc_craftitem:prompt", function(msg)
    SetTextScale(0.5, 0.5)
    local str = Citizen.InvokeNative(0xFA925AC00EB830B9, 10, "LITERAL_STRING", msg, Citizen.ResultAsLong())
    Citizen.InvokeNative(0xFA233F8FE190514C, str)
    Citizen.InvokeNative(0xE9990552DEC71600)
end)

function DrawTxt(str, x, y, w, h, enableShadow, col1, col2, col3, a, centre)
    local str = CreateVarString(10, "LITERAL_STRING", str, Citizen.ResultAsLong())
   SetTextScale(w, h)
   SetTextColor(math.floor(col1), math.floor(col2), math.floor(col3), math.floor(a))
   SetTextCentre(centre)
   if enableShadow then SetTextDropshadow(1, 0, 0, 0, 255) end
   Citizen.InvokeNative(0xADA9255D, 10);
   DisplayText(str, x, y)
end

--Citizen.CreateThread(function()
  --  for k,v in pairs(Config.Pharmacies) do
  --      local blip = N_0x554d9d53f696d002(1664425300, v)
     --   SetBlipSprite(blip, Config.BlipSprite, 1)
    --    SetBlipScale(blip, Config.BlipScale)
    --   Citizen.InvokeNative(0x9CB1A1623062F402, blip, Config.BlipName)
  --  end
--end)

