local inRobbery = false
local canBeRob = true
local canBeRobTime = 0
local bountyid
local Weapons = {
    0x772C8DD6, 0x169F59F7, 0xDB21AC8C, 0x6DFA071B,
    0xF5175BA1, 0xD2718D48, 0x797FBF5, 0x772C8DD6,
    0x7BBD1FF6, 0x63F46DE6, 0xA84762EC, 0xDDF7BC1E,
    0x20D13FF, 0x1765A8F8, 0x657065D6, 0x8580C63E,
    0x95B24592, 0x31B7B9FE, 0x88A855C, 0x1C02870C,
    0x28950C71, 0x6DFA071B
  }
local horseModels = {"a_c_horse_andalusian_darkbay","a_c_horse_arabian_grey","a_c_horse_belgian_blondchestnut","a_c_horse_breton_sealbrown"}
local banditsModel = {"G_M_M_UniBanditos_01","A_M_M_GRIFANCYDRIVERS_01","A_M_M_NEAROUGHTRAVELLERS_01","A_M_M_RANCHERTRAVELERS_COOL_01","A_M_M_RANCHERTRAVELERS_WARM_01"}
local npcs = {}
local horses = {}


AddEventHandler("onResourceStop",function(resourceName)
        for v,k in pairs(npcs) do
            DeleteEntity(k)
        end
        npcs = {}
end)





/* Functions */

function banditsStart(bandits)
    for v,k in pairs(npcs) do
        DeleteEntity(k)
    end
    npcs = {}
    inRobbery = true
    for v,k in pairs(bandits) do
        local horsemodel = GetHashKey(horseModels[math.random(1,#horseModels)])
        local banditmodel = GetHashKey(banditsModel[math.random(1,#banditsModel)])
        local rWeapon = Weapons[math.random(1,#Weapons)]
        RequestModel(banditmodel)
        if not HasModelLoaded(banditmodel) then RequestModel(banditmodel) end
        while not HasModelLoaded(banditmodel) do Wait(1) end
        Citizen.Wait(100)

        npcs[v] = CreatePed(banditmodel, k, true, true, true, true)
        Citizen.InvokeNative(0x283978A15512B2FE, npcs[v], true)
        Citizen.InvokeNative(0x23f74c2fda6e7c61, 953018525, npcs[v])
        GiveWeaponToPed(npcs[v], rWeapon, 50, true, true, 1, false, 0.5, 1.0, 1.0, true, 0, 0)
        SetCurrentPedWeapon(npcs[v], rWeapon, true)
        


        RequestModel(horsemodel)
        if not HasModelLoaded(horsemodel) then RequestModel(horsemodel) end
        while not HasModelLoaded(horsemodel) do Wait(1) end
        Citizen.Wait(100)

        local horse = CreatePed(horsemodel, k, true, true, true, true)
        Citizen.InvokeNative(0x283978A15512B2FE, horse, true)

        
        Citizen.InvokeNative(0x028F76B6E78246EB, npcs[v],horse,-1)


        TaskCombatPed(npcs[v], PlayerPedId())

        
    end
    Wait(2000)
    Citizen.CreateThread(function()
        while true do
            local alldeath = true
            Citizen.Wait(1000)

            if inRobbery == true then
                for v,k in pairs(npcs) do
                    if IsPedDeadOrDying(k,true) then
                        -- Dead 
                    else 
                        alldeath = false
                    end
                end
                if alldeath == true then
                    for v,k in pairs(npcs) do
                        DeleteEntity(k)
                    end
                    npcs = {}
                    inRobbery = false
	            exports['qbr-core']:Notify(9, 'All the bandits are down.', 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
                    break
                end
            end
        end
    end)
    exports['qbr-core']:Notify(9, 'You were ambushed!', 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
end



/*Loops*/


Citizen.CreateThread(function()
	while true do
	Citizen.Wait(1000)
        local BigDistance = nil
        if canBeRob == true then
            local chance = math.random(1,100)
            local coords = GetEntityCoords(PlayerPedId())
            for v,k in pairs(Config.Bandits) do
                local dis = GetDistanceBetweenCoords(coords.x,coords.y,coords.z,k.startPos.x,k.startPos.y,k.startPos.z)
                if dis < 30.0 then
                    if chance <= Config.BanditsChance then
                        banditsStart(k.bandits)
                        canBeRob = false
                        canBeRobTime = Config.nonRobTime
                    else
                        canBeRob = false
                        canBeRobTime = Config.nonRobTime
                    end
                elseif dis < 100.0 then
		  	Wait(1000)
			BigDistance = false			
		else
			if BigDistance == false then
			   BigDistance = true
			end
		end
            end
	    if BigDistance == true then
		Wait(5000)			
	    end
        end

        if inRobbery == true then
            local runAway = false
            if IsPedDeadOrDying(PlayerPedId(),true) then
                exports['qbr-core']:Notify(9, 'You ve been robbed.', 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
                for v,k in pairs(npcs) do
                    DeleteEntity(k)
                end
                npcs = {}
                TriggerServerEvent("pls_bandits:server:robbed")
                inRobbery = false
            end

            local coords = GetEntityCoords(PlayerPedId())
            for v,k in pairs(npcs) do
                local npccoords = GetEntityCoords(k) 
                local dis = GetDistanceBetweenCoords(coords.x,coords.y,coords.z,npccoords.x,npccoords.y,npccoords.z)
                if dis > Config.runAwayDis  then
                    runAway = true
                end
            end
            if runAway == true then
                for v,k in pairs(npcs) do
                    DeleteEntity(k)
                end
                npcs = {}
                inRobbery = false
		exports['qbr-core']:Notify(9, 'You managed to escape', 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
            end
        end
    end
end)


Citizen.CreateThread(function()
	while true do
	Citizen.Wait(Config.nonRobTime*1000)
        if canBeRob == false then
            if canBeRobTime == 0 then
                canBeRob = true
            else
                canBeRobTime = canBeRobTime-1
            end
        end
    end
end)



