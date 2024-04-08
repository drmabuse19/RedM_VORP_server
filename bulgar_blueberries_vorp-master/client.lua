local EatPrompt
local active = false
local eat = false
local amount = 0 
local cooldown = 0 
local oldBush

local BlueBerrygroup = GetRandomIntInRange(0, 0xffffff)

function EatBlueberry()
    Citizen.CreateThread(function()
        local str = 'Eat Blueberries'
        local wait = 0
		EatPrompt = Citizen.InvokeNative(0x04F97DE45A519419)
        PromptSetControlAction(EatPrompt, 0xC7B5340A)
        str = CreateVarString(10, 'LITERAL_STRING', str)
        PromptSetText(EatPrompt, str)
        PromptSetEnabled(EatPrompt, true)
        PromptSetVisible(EatPrompt, true)
        PromptSetHoldMode(EatPrompt, true)
        PromptSetGroup(EatPrompt, BlueBerrygroup)
        PromptRegisterEnd(EatPrompt)
    end)
end

Citizen.CreateThread(function()
Wait(2000)
EatBlueberry()
	while true do
		Wait(10)
		local player = PlayerPedId()
		local excludeEntity = player
		local coords = GetEntityCoords(player)
		local shapeTest = StartShapeTestBox(coords.x, coords.y, coords.z, 1.0, 1.0, 2.0, 0.0, 0.0, 0.0, true, 256, excludeEntity)
        local rtnVal, hit, endCoords, surfaceNormal, entityHit = GetShapeTestResult(shapeTest)
        excludeEntity = entityHit
		local model_hash = GetEntityModel(entityHit)
		
		-- rdr_bush_lrg_aa_sim
		-- rdr_bush_ficus_aa_sim

		if (model_hash == 477619010 or model_hash == 85102137) and not eat and cooldown < 1 and oldBush ~= entityHit and not IsPedOnMount(player) and not IsPedInAnyVehicle(player) then		
			if active == false then
				local BlueBerryGroupName  = CreateVarString(10, 'LITERAL_STRING', "Blueberries")
                PromptSetActiveGroupThisFrame(BlueBerrygroup, BlueBerryGroupName)      
            end
			if PromptHasHoldModeCompleted(EatPrompt) then
				eat = true
				oldBush = entityHit
				goEat()
				active = false
				amount = amount +1

				if amount == 2 then
					TriggerEvent("vorp:TipRight", "Do not eat blueberries too often, you can poison yourself!", 5000)
				elseif amount == 3 then
					TriggerEvent("vorp:TipRight", "Do not eat blueberries too often, you can poison yourself!", 5000)

				elseif amount > 4 then
					local chance =  math.random(1,20)
					Wait(2300)
					if chance > 10 then
						startPoisone()	
						TriggerEvent("vorp:TipRight", "You feel bad!", 8000)
					end
					startCooldown()
				end
				active = false
			end
		else
			Citizen.Wait(500)
		end
	end
end)

function goEat()
	Citizen.CreateThread(function()
		local playerPed2 = PlayerPedId()
		local hp = GetEntityHealth(playerPed2)

		RequestAnimDict("mech_pickup@plant@berries")
		while not HasAnimDictLoaded("mech_pickup@plant@berries") do
			Wait(100)
		end

		TaskPlayAnim(playerPed2, "mech_pickup@plant@berries", "enter_lf", 8.0, -0.5, -1, 0, 0, true, 0, false, 0, false)
		Wait(800)
		TaskPlayAnim(playerPed2, "mech_pickup@plant@berries", "base", 8.0, -0.5, -1, 0, 0, true, 0, false, 0, false)
		Wait(2300)	
		TaskPlayAnim(playerPed2, "mech_pickup@plant@berries", "exit_eat", 8.0, -0.5, -1, 0, 0, true, 0, false, 0, false)	
		Wait(2500)
		ClearPedTasksImmediately(playerPed2)	
		TriggerEvent("vorpmetabolism:changeValue", "Hunger", 25)
		eat = false
	end)
end

Citizen.CreateThread(function()
	while true do
		Wait(60000)
		if amount > 0 then
			amount = amount - 1						
		end
	end
end)

function startCooldown()
	cooldown = 10000
    if cooldown > 0 then
        Citizen.CreateThread(function()
            while cooldown > 0 do
                Wait(0)
                cooldown = cooldown - 1
            end
        end)
    end
end

function startPoisone()
local ojojo = 10
    if ojojo > 0 then
        Citizen.CreateThread(function()
            while ojojo > 0 do
				Wait(5000)
			   	local playerPed2 = PlayerPedId()
				local hp = GetEntityHealth(playerPed2)

				SetEntityHealth(playerPed2,hp-3)
				-- TriggerEvent("vorpmetabolism:changeValue", "Hunger", -100)
                ojojo = ojojo - 1
            end
        end)
    end
end