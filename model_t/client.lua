local modelt = nil 

------ spawn vehicle function ------
local function spawnmodelt(c, engine)
	Citizen.Wait(50)
    local pc = GetEntityCoords(PlayerPedId())
    if c then 
      pc = c
    end
    local model, model2, wheelModel = GetHashKey("buggy01"), GetHashKey("model_t"), GetHashKey("model_t_wheel") -- Change vehicle models here
    local attach = {-0.01, 1.85, 0.300, 0.0, 0.0, 0.0}
    RequestModel(model)
    RequestModel(model2)
    RequestModel(wheelModel)
    
    while not HasModelLoaded(model) or not HasModelLoaded(model2) or not HasModelLoaded(wheelModel) do
      Citizen.Wait(5)
    end
	
	-- Create vehicle based on hash key, set invisible and attach shell object
    local vehicle = CreateVehicle(model, pc.x + 2.0, pc.y, pc.z + 2.0, (pc.h or 1.0), 1, 1, 0)
    Citizen.Wait(150)
    FreezeEntityPosition(vehicle, 1)
    SetEntityVisible(vehicle, 0)
    Citizen.Wait(150)
    local obj = CreateObject(model2, pc.x, pc.y, pc.z, 1, 1, 1)
    Citizen.Wait(300)
    AttachEntityToEntity(obj, vehicle, 0, attach[1], attach[2], attach[3], attach[4], attach[5], attach[6], 0, 1, 1, 0, 0, 2)

   -- Initialization for rear wheels
    local rearWheels = {}
    local rearWheelOffsets = {
  { x = 0.82, y = 0.40, z = -0.28 },
  { x = -0.82, y = 0.40, z = -0.28 }
  }
  for _, offset in ipairs(rearWheelOffsets) do
  local x, y, z = table.unpack(GetEntityCoords(vehicle, false))
  local rearWheel = CreateObject(wheelModel, x + offset.x, y + offset.y, z + offset.z, 1, 1, 1)
  table.insert(rearWheels, rearWheel)
  local orientationAngle = (offset.x > 0) and 180.0 or 0.0  -- Flip if it's on the right side
  AttachEntityToEntity(rearWheel, vehicle, 0, offset.x, offset.y, offset.z, 0, 0, orientationAngle, 0, 1, 1, 0, 0, 2)
  end
  
   -- Initialization for front wheels
  local frontWheels = {}
  local frontWheelOffsets = {
  { x = 0.80, y = 3.53, z = -0.28 },
  { x = -0.82, y = 3.53, z = -0.28 }
  }
  for _, offset in ipairs(frontWheelOffsets) do
  local x, y, z = table.unpack(GetEntityCoords(vehicle, false))
  local frontWheel = CreateObject(wheelModel, x + offset.x, y + offset.y, z + offset.z, 1, 1, 1)
  table.insert(frontWheels, frontWheel)
  local orientationAngle = (offset.x > 0) and 180.0 or 0.0  -- Flip if it's on the right side
  AttachEntityToEntity(frontWheel, vehicle, 0, offset.x, offset.y, offset.z, 0, 0, orientationAngle, 0, 1, 1, 0, 0, 2)
  end

    -- Initialize rotation angle variable
  local currentRotationAngle = 0.0

    -- Initialize turning right and turning left variables
  local turningRight = false
  local turningLeft = false
  local currentTurnAngle = 0.0  -- The actual current turn angle
  local turnSmoothing = 5.0  -- The rate at which the turn angle changes (higher = faster)

    -- Update loop for turning front wheels based on keypress
  Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    
	  if modelt then
      modelt.inmodelt = IsPedInVehicle(PlayerPedId(), modelt.vehicle, 1)

      if modelt.inmodelt then
      if DoesEntityExist(vehicle) and frontWheels[1] and rearWheels[1] then	

      -- Check if "D" key is pressed or released
      if IsControlJustPressed(0, 0xB4E465B4) then
        turningLeft = true
      elseif IsControlJustReleased(0, 0xB4E465B4) then
        turningLeft = false
      end

      -- Check if "A" key is pressed or released
      if IsControlJustPressed(0, 0x7065027D) then
        turningRight = true
      elseif IsControlJustReleased(0, 0x7065027D) then
        turningRight = false
      end

      local vehicleSpeed = GetEntitySpeed(vehicle)  -- Get the speed of the vehicle
    -- Get the forward vector of the vehicle
   local forwardVector = GetEntityForwardVector(vehicle)

     -- Get the velocity vector of the vehicle
  local vx, vy, vz = table.unpack(GetEntityVelocity(vehicle))

     -- Calculate the dot product
  local dotProduct = forwardVector.x * vx + forwardVector.y * vy + forwardVector.z * vz

     -- Determine the direction multiplier based on the dot product
  local directionMultiplier = (dotProduct >= 0) and 1.0 or -1.0

    -- Modify the rotation speed increment based on the direction
  local rotSpeedIncrement = -3.0 * vehicleSpeed * directionMultiplier

      -- Decide the turn angle based on "D" and "A" keys
      local targetTurnAngle = 0.0
      if turningRight then
        targetTurnAngle = 30.0
      elseif turningLeft then
        targetTurnAngle = -30.0
      end
      
      -- Smoothly interpolate towards the target turn angle
      currentTurnAngle = currentTurnAngle + (targetTurnAngle - currentTurnAngle) / turnSmoothing

      currentRotationAngle = currentRotationAngle + rotSpeedIncrement  -- Increment the current rotation angle
      
      for i, frontWheel in ipairs(frontWheels) do
        local offset = frontWheelOffsets[i]

        -- Determine orientation angle based on the side of the vehicle
        local orientationAngle = (offset.x > 0) and 180.0 or 0.0  -- Flip if it's on the right side

        -- Invert rotation angle if the wheel is on the right side
        local finalRotationAngle = (offset.x > 0) and -currentRotationAngle or currentRotationAngle

      -- In the AttachEntityToEntity call, replace 'turnAngle' with 'currentTurnAngle'
      AttachEntityToEntity(frontWheel, vehicle, 0, offset.x, offset.y, offset.z, finalRotationAngle, 0.0, orientationAngle + currentTurnAngle, 0, 1, 1, 0, 0, 2)
      end

      for i, rearWheel in ipairs(rearWheels) do
        local offset = rearWheelOffsets[i]

        -- Determine orientation angle based on the side of the vehicle
        local orientationAngle = (offset.x > 0) and 180.0 or 0.0  -- Flip if it's on the right side

        -- Invert rotation angle if the wheel is on the right side
        local finalRotationAngle = (offset.x > 0) and -currentRotationAngle or currentRotationAngle

        AttachEntityToEntity(rearWheel, vehicle, 0, offset.x, offset.y, offset.z - 0.04, finalRotationAngle, 0.0, orientationAngle, 0, 1, 1, 0, 0, 2)
      end
      
      -- Reset the rotation angle if it gets too large (optional)
      if currentRotationAngle >= 360.0 then
        currentRotationAngle = 0.0
          end
        end
       end
     end
    end
  end)

  -- Create primary audio object
  local primaryAudio = CreateObject(GetHashKey("p_phonograph01x"), pc.x, pc.y, pc.z, true, true, true)
  AttachEntityToEntity(primaryAudio, vehicle, 0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
  SetEntityVisible(primaryAudio, false)

   -- Create secondary audio object
  local secondaryAudio = CreateObject(GetHashKey("p_phonograph01x"), pc.x, pc.y, pc.z, true, true, true)
  AttachEntityToEntity(secondaryAudio, vehicle, 0, 0.0, 0.5, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
  SetEntityVisible(secondaryAudio, false)

      Citizen.Wait(50)

      local a = {
        vehicle = vehicle, 
        object = obj,
        engine = false,    
        headlights = false,
        headlight_l = hobj2, 
        headlight_r = hobj3,
        headlight_b = hobj,
        inmodelt = false,
        curr_speed = 0,
        frontWheels = frontWheels,  
        rearWheels = rearWheels,    
        primaryAudio = primaryAudio, --start sound
        secondaryAudio = secondaryAudio, -- idle sound
        
      }
      
      Citizen.Wait(50)
       modelt = a
      
    FreezeEntityPosition(vehicle, 0)
    SetModelAsNoLongerNeeded(model)
    SetModelAsNoLongerNeeded(model2)
    SetModelAsNoLongerNeeded(wheelModel)
	Citizen.Wait(1)
	SetVehicleLights(vehicle, 1)
	
	     -- initialize lights and attach
	        local model3 = GetHashKey("p_steamerlight01x")
        RequestModel(model3)
        while not HasModelLoaded(model3) do
          Citizen.Wait(5)
        end
        hobj, hobj2, hobj3 = CreateObject(GetHashKey("p_stageshelllight_red01x"), pc.x, pc.y, pc.z - 3.0, 1, 1, 1), CreateObject(model3, pc.x, pc.y, pc.z - 2.0, 1, 1, 1), CreateObject(model3, pc.x, pc.y, pc.z, 1, 1, 1)
		        Citizen.Wait(100)
				
  local attaches = {
  [1] = {-0.5, -3.0, -11.2, -40.0, 0.0, (90.0 + 90) % 360, "Back"},
  [2] = {-0.5, 1.75, 0.08, -0.0, 0.0, (270.0 + 90) % 360, "Front Left"},
  [3] = {0.5, 1.75, 0.08, -0.0, 0.0, (270.0 + 90) % 360, "Front Right"},
  }

        Citizen.Wait(100)
        AttachEntityToEntity(hobj, obj, 0, attaches[1][1], attaches[1][2], attaches[1][3], attaches[1][4], attaches[1][5], attaches[1][6], 0, 0, 0, 0, 0, 2)
        AttachEntityToEntity(hobj2, obj, 0, attaches[2][1], attaches[2][2], attaches[2][3], attaches[2][4], attaches[2][5], attaches[2][6], 0, 0, 0, 0, 0, 2)
        AttachEntityToEntity(hobj3, obj, 0, attaches[3][1], attaches[3][2], attaches[3][3], attaches[3][4], attaches[3][5], attaches[3][6], 0, 0, 0, 0, 0, 2)
		SetEntityVisible(hobj, false)
		SetEntityVisible(hobj2, false)
		SetEntityVisible(hobj3, false)
		
		------- Modify speed here -----------
		Citizen.CreateThread(function()
		   while true do
		   Citizen.Wait(0)
		   if modelt then
		   modelt.inmodelt = IsPedInVehicle(PlayerPedId(), modelt.vehicle, 1)
		   
		   if modelt.inmodelt then
		    local vehicle = modelt.vehicle
			if DoesEntityExist(vehicle) then
			 local speed = GetEntitySpeed(vehicle)
			 local speedMph = speed * 2.23694 
			 if IsControlPressed(0, 0x8FFC75D6) and speedMph < Config.TopSpeed then
			 SetVehicleForwardSpeed(vehicle, speed + Config.AccelSpeed)
			 end
		end
		end
		end
	end
	end)
end
--------------------------------------------------------------------------------------------------------------------------------------------
-- Function to delete only the modelt.vehicle for basic locking

local function deletemodeltVehicle()
  if modelt and modelt.vehicle then
    DeleteEntity(modelt.vehicle)
  end
end

-- Register the "lock" command to trigger the function
RegisterCommand("lock", function()
  deletemodeltVehicle()
end, false)
--------------------------------------------------------------------------------------------------------------------------------------------
-- invisibility De-Sync manual fix for players

local function fixme()
    --  Get the player's current coordinates and state
    local player = PlayerPedId()
    local x, y, z = table.unpack(GetEntityCoords(player, false))
    local isInVehicle = IsPedInAnyVehicle(player, false)
    local vehicle = nil

    if isInVehicle then
        vehicle = GetVehiclePedIsIn(player, false)
        TaskLeaveVehicle(player, vehicle, 0)       
    end 
    
    Citizen.Wait(700)  -- Wait to ensure the dismount is complete
	ExecuteCommand(Config.DeleteCommand)
	Citizen.Wait(500)

    -- Teleport the player to the new coordinates
    SetEntityCoords(player, -2749.08, -5218.31, -9.63, 0.0, 0.0, 0.0, false)
    Citizen.Wait(300)  -- Wait to ensure the teleportation is complete

    -- Teleport the player back to their original coordinates
    SetEntityCoords(player, x, y, z, 0.0, 0.0, 0.0, false)
    Citizen.Wait(300)  -- Wait to ensure the teleportation is complete
    
    enterVehicleCounter = 0
    SetEntityVisible(player, 1)
end

RegisterCommand("fixme", function()
    fixme()
end, false)

--------------------------------------------------------------------------------------------------------------------------------------------
-- function and command that fixes invisibility De-Sync between players

local objectVisible = true  

local function toggleObjectVisibility()
  if modelt and modelt.object then
    -- Toggle visibility for the main modelt object
    objectVisible = not objectVisible  -- Toggle the boolean
    SetEntityVisible(modelt.object, objectVisible)

    -- Toggle visibility for the front wheels
    if modelt.frontWheels then 
      for _, wheel in ipairs(modelt.frontWheels) do  
        SetEntityVisible(wheel, objectVisible) 
      end
    end
    
    -- Toggle visibility for the back wheels
    if modelt.rearWheels then 
      for _, wheel in ipairs(modelt.rearWheels) do  
        SetEntityVisible(wheel, objectVisible)  
      end
    end
  end
end

RegisterCommand("fixmodelt", function()
  toggleObjectVisibility()
end, false)
--------------------------------------------------------------------------------------------------------------------------------------------
-- Workaround function for invisibility De-Sync between players upon server join

local hasRun = false  -- Variable to track if the function has run for a player

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)

    local vehicleCoords = GetEntityCoords(vehicle)  -- Replace 'vehicle' with your vehicle entity
    local players = GetActivePlayers()

    for i = 1, #players do
      local otherPlayerPed = GetPlayerPed(players[i])
      if otherPlayerPed ~= PlayerPedId() then  -- Exclude the local player
        local otherPlayerCoords = GetEntityCoords(otherPlayerPed)
        local distance = Vdist(vehicleCoords.x, vehicleCoords.y, vehicleCoords.z, otherPlayerCoords.x, otherPlayerCoords.y, otherPlayerCoords.z)

        if distance < 50.0 and not hasRun then		-- Change 50.0 to desired distance
		Citizen.Wait(9000)
          toggleObjectVisibility()  
		  Citizen.Wait(10)  

          toggleObjectVisibility()  -- Run the function the second time
	  
          hasRun = true  -- Set the flag to true
          Citizen.Wait(10000)  
          hasRun = false  -- Reset the flag
        end
      end
    end
  end
end)
--------------------------------------------------------------------------------------------------------------------------------------------
--- Still experiencing an invisibility issue when others drive so for now it blows everything up if they try

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    if modelt and modelt.vehicle then
      local vehicle = modelt.vehicle
      
      for i = 0, 32 do
        if NetworkIsPlayerActive(i) then
          local otherPed = GetPlayerPed(i)
          
          if otherPed ~= PlayerPedId() then
            if IsPedGettingIntoAVehicle(otherPed) then
              local foundVehicle = GetVehiclePedIsEntering(otherPed)
              
              if foundVehicle == vehicle then
                print("PedStealing.")
                
                local seat = GetSeatPedIsTryingToEnter(otherPed)
                
                if seat == -1 then
				ClearPedTasksImmediately(otherPed)

                   -- Trigger explosions
                 local x, y, z = table.unpack(GetEntityCoords(otherPed, false))
                  AddExplosion(x, y, z, 26, 1.0, true, false, 1.0)  -- Replace 26 with the actual integer value for EXP_TAG_DYNAMITE
                  Citizen.Wait(500)  -- Half a second delay
                  AddExplosion(x, y, z, 3, 1.0, true, false, 1.0)  -- Replace 3 with the actual integer value for EXP_TAG_MOLOTOV
                  Citizen.Wait(500)  -- Half a second delay
                  AddExplosion(x, y, z, 1, 1.0, true, false, 1.0)  -- Replace 1 with the actual integer value for EXP_TAG_GRENADE
                else
                  TaskEnterVehicle(otherPed, vehicle, -1, seat, 1.0, 1, 0)
                end
              end
            end
          end
        end
      end
    end
  end
end)

--------------------------------------------------------------------------------------------------------------------------------------------
--- ANIMATION TO ENTER DRIVER SEAT PROPER USING CLONE

local clonePed = nil

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(1)
    local player = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(player, false)

    -- Check if modelt.vehicle exists and matches the vehicle the player is in
    if modelt and modelt.vehicle and DoesEntityExist(vehicle) and vehicle == modelt.vehicle and not DoesEntityExist(clonePed) then
      Citizen.CreateThread(function()
        Citizen.Wait(2)
        SetEntityVisible(player, false, false)
      end)

      -- Create a clone of the player a few feet behind the vehicle
      local cloneCoords = GetOffsetFromEntityInWorldCoords(vehicle, 0.0, -2.0, 0.0)
      clonePed = ClonePed(player, GetEntityHeading(player), false, true)
      SetEntityCoordsNoOffset(clonePed, cloneCoords.x, cloneCoords.y, cloneCoords.z, true, true, true)
      
      -- Start the scenario for the cloned ped
      RequestAnimDict("script_re@check_point@small_cart")
      while not HasAnimDictLoaded("script_re@check_point@small_cart") do
        Citizen.Wait(100)
      end

      -- Play the animation
      TaskPlayAnim(
        clonePed, 
        "script_re@check_point@small_cart", 
        "int_loop_driver", 
        8.0, -- blendInSpeed
        1.0, -- blendOutSpeed
        -1, -- duration
        1, -- flag (loop)
        0.1, -- playbackRate
        0, -- lockX
        0, -- lockY
        0  -- lockZ
      )

      -- Adjust the attachment parameters
      local xOffset = -0.30
      local yOffset = 1.35
      local zOffset = 0.65
      local xRotation = 20.0
      local yRotation = 20.0
      local zRotation = 0.0
      AttachEntityToEntity(clonePed, vehicle, 0, xOffset, yOffset, zOffset, xRotation, yRotation, zRotation, false, false, false, false, 2, true)
      SetEntityVisible(clonePed, false, false)

      -- Start another thread to handle clone visibility with a delay
      Citizen.CreateThread(function()
          Citizen.Wait(700)
          SetEntityVisible(clonePed, true, false)
      end)

    elseif (not modelt or not modelt.vehicle or not DoesEntityExist(vehicle) or vehicle ~= modelt.vehicle) and DoesEntityExist(clonePed) then
      -- Make the player visible again
      SetEntityVisible(player, true, false)

      -- Delete the clone
      DeleteEntity(clonePed)
      clonePed = nil
    end
  end
end)

--------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand(Config.Command, function(_, args)
  if Config.SpawnCommand then 
    spawnmodelt(c, engine)
  end
end)
--------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand(Config.ResetCommand, function(_, args)
  if modelt then 
    local dist = #(GetEntityCoords(PlayerPedId()) - GetEntityCoords(modelt.vehicle))
    if dist < 4.0 then 
      SetEntityRotation(modelt.vehicle, 0.0, 0.0, 0.0, 2, 1)
    end
	end
end)
--------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand(Config.DeleteCommand, function(_, args)
    if modelt then 
        -- Delete the vehicle and its associated parts
        DeleteEntity(modelt.vehicle)
        DeleteEntity(modelt.headlight_l)
        DeleteEntity(modelt.headlight_r)
        DeleteEntity(modelt.headlight_b)
        DeleteEntity(modelt.object)
		DeleteEntity(modelt.headlight_b)
		DeleteEntity(modelt.headlight_l)
		DeleteEntity(modelt.headlight_r)
			  DeleteEntity(hobj)
	  DeleteEntity(hobj2)
	  DeleteEntity(hobj3)
	     --TriggerServerEvent('stopEngineAudio', primaryAudioNetId, secondaryAudioNetId)		
        if modelt.primaryAudio then
          DeleteEntity(modelt.primaryAudio)
        end
        if modelt.secondaryAudio then
          DeleteEntity(modelt.secondaryAudio)
        end       
        -- Delete the front wheels
        if modelt.frontWheels then
          for _, frontWheel in ipairs(modelt.frontWheels) do
            DeleteEntity(frontWheel)
          end
        end
        -- Delete the rear wheels
        if modelt.rearWheels then
          for _, rearWheel in ipairs(modelt.rearWheels) do
            DeleteEntity(rearWheel)
          end
        end   
        -- Clear the modelt data
        modelt = nil
      end
    end)
--------------------------------------------------------------------------------------------------------------------------------------------
--- Engine start and stop function on key press - config default is ALT

Citizen.CreateThread(function()
    Citizen.Wait(1000)
    while true do
        Citizen.Wait(10)
        
        if modelt then  
            if modelt.inmodelt then  

                local vehicleEntity = GetVehiclePedIsIn(PlayerPedId())
				
                
                -- Get the Network IDs for the primary and secondary audio objects
                 primaryAudioNetId = NetworkGetNetworkIdFromEntity(modelt.primaryAudio)
                 secondaryAudioNetId = NetworkGetNetworkIdFromEntity(modelt.secondaryAudio)
                
                 if IsControlPressed(0, Config.Engine) or (IsPedGettingIntoAVehicle(PlayerPedId()) and not modelt.engine) then
                 if not modelt.engine then  -- If the engine is not on                    if not modelt.engine then  -- If the engine is not on
                        print("engine on")                       
                        -- Notify the server to start the start-up sound on the primary audio object
                        --TriggerServerEvent('startEngineAudio', primaryAudioNetId)                        
                        -- Enable the modelt engine
                        SetVehicleEngineOn(vehicleEntity, 1, 1)
                        -- Citizen.Wait for the start-up sound to finish (assuming it's around 4 seconds long)
                        Citizen.Wait(3800)                        
                        -- Notify the server to start the idle sound on the secondary audio object
                        --TriggerServerEvent('startIdleAudio', secondaryAudioNetId)						
						Citizen.Wait(1900)
						--TriggerServerEvent('stopEngineAudio', primaryAudioNetId)
						-- lights						
								SetEntityVisible(hobj, true)
		                    SetEntityVisible(hobj2, true)
		                 SetEntityVisible(hobj3, true)
						 
                    else  -- If the engine is already on
                        print("engine off")                       
                        -- Notify the server to stop the sounds
                        --TriggerServerEvent('stopEngineAudio', primaryAudioNetId, secondaryAudioNetId)
                        -- Disable the modelt engine
                        SetVehicleEngineOn(vehicleEntity, 0, 0)						
						--- lights off
								SetEntityVisible(hobj, false)
		                SetEntityVisible(hobj2, false)
		                SetEntityVisible(hobj3, false)
		                 --TriggerServerEvent('startStopAudio', primaryAudioNetId)
		                Citizen.Wait(2000)
		                --TriggerServerEvent('stopEngineAudio', primaryAudioNetId, secondaryAudioNetId)
                    end               
                    -- Toggle the engine state
                    modelt.engine = not modelt.engine					                   
                    Citizen.Wait(1200)
                end
            end
        else
            Citizen.Wait(1000)
        end
    end
end)
--------------------------------------------------------------------------------------------------------------------------------------------
-- function checking and disabling the engine when vehicle cannot be  driven

Citizen.CreateThread(function()
    while true do  
        Citizen.Wait(2000)         
        if modelt then  
            local vehicleEntity = modelt.vehicle  
            -- Check if the vehicle is drivable
            local isDriveable = IsVehicleDriveable(vehicleEntity, false, false)
            -- Check if the engine health is too low or if the vehicle is not drivable
            if not isDriveable and modelt.engine then
                print("Vehicle is not driveable or engine is destroyed, turning off.")

                -- Notify the server to stop the sounds
                TriggerServerEvent('stopEngineAudio', primaryAudioNetId, secondaryAudioNetId)

                -- Disable the modelt engine
                SetVehicleEngineOn(vehicleEntity, 0, 0)

                -- Turn off lights
                SetEntityVisible(hobj, false)
                SetEntityVisible(hobj2, false)
                SetEntityVisible(hobj3, false)
				Citizen.Wait(200)

                -- Notify server to stop other sounds if any
                TriggerServerEvent('startStopAudio', primaryAudioNetId)
                Citizen.Wait(2000)
                TriggerServerEvent('stopEngineAudio', primaryAudioNetId, secondaryAudioNetId)

                -- Update engine state
                modelt.engine = false
            end
        end
    end
end)
--------------------------------------------------------------------------------------------------------------------------------------------
-- Audio functions using PMMS - REMOVED - CAN BE RE-ENABLED

--[[ local isRevAudioPlaying = false
local isAccelAudioPlaying = false

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10)  
        if modelt and modelt.inmodelt and modelt.engine then  

            -- Handle rev audio
            if IsControlJustReleased(0, 0xE30CD707) then  -- 'r' is pressed
                if not isRevAudioPlaying then  -- Check the flag before starting the audio
                    isRevAudioPlaying = true
                    TriggerServerEvent('startRevAudio', primaryAudioNetId)
                    Citizen.Wait(3000)
                    TriggerServerEvent('stopEngineAudio', primaryAudioNetId)
                    isRevAudioPlaying = false  -- Reset the flag
                end
            end

            -- Handle accel audio
            if IsControlPressed(0, 0x8FFC75D6) then  -- 'Shift' is pressed
                if not isAccelAudioPlaying then  -- Check the flag before starting the audio
                    isAccelAudioPlaying = true
                    TriggerServerEvent('startAccelAudio', primaryAudioNetId)
                end
            elseif IsControlJustReleased(0, 0x8FFC75D6) then  -- 'Shift' is released
                TriggerServerEvent('stopEngineAudio', primaryAudioNetId)
                isAccelAudioPlaying = false  -- Reset the flag
				Citizen.Wait(420)
				TriggerServerEvent('startDecelAudio', primaryAudioNetId)
				Citizen.Wait(1600)
				TriggerServerEvent('stopEngineAudio', primaryAudioNetId)
            end

            -- Stop engine audio if neither 'W' nor 'Shift' are pressed
            if not IsControlPressed(0, 0x8FD015D8) and not IsControlPressed(0, 0x8FFC75D6) then
                if isRevAudioPlaying or isAccelAudioPlaying then  -- Check if either audio is currently playing
                    TriggerServerEvent('stopEngineAudio', primaryAudioNetId)
                    isRevAudioPlaying = false  -- Reset the flag
                    isAccelAudioPlaying = false  
                end
            end
        end  
        Citizen.Wait(10)  
    end
end)  ]]--
----------------------- Speedometer and Engine Key sprite function 

Citizen.CreateThread(function()
  local color1, color2 = {126,0,0, 200}, {126,0,0, 200}
  while true do
    Citizen.Wait(5)
    if modelt then     
      if modelt.inmodelt then
        local speedMetersPerSecond = GetEntitySpeed(modelt.vehicle)
        local speedMPH = speedMetersPerSecond * 2.23694
        local curr_speed = string.format("%.1f", speedMPH) -- formatted speed       
        if modelt and modelt.engine then
          color2 = {0,126,0, 200}
        else
          color2 = {126,0,0, 200}
        end
        if modelt and modelt.headlights then
          color1 = {0,126,0, 200}
        else
          color1 = {126,0,0, 200}
        end

        -- Text drawing logic
        SetTextColor(126,0,0, 215)
        SetTextScale(0.35,0.35)
        SetTextFontForCurrentCommand(0)
        SetTextCentre(1)
        local str = CreateVarString(10, "LITERAL_STRING", curr_speed.."mph", Citizen.ResultAsLong())
        DisplayText(str,0.46,0.9)
        DrawSprite("hud_textures", "gang_savings", 0.53, 0.91, 0.04, 0.04, 0.1, color2[1], color2[2], color2[3], color2[4], 0)
      end
    else
      Citizen.Wait(800)
    end
  end
end)
--------------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler('onResourceStop', function(resourceName)
	if (GetCurrentResourceName() ~= resourceName) then
	  return
	end
    if modelt then 
        -- Delete the vehicle and its associated parts
        DeleteEntity(modelt.vehicle)
        DeleteEntity(modelt.headlight_l)
        DeleteEntity(modelt.headlight_r)
        DeleteEntity(modelt.headlight_b)
        DeleteEntity(modelt.object)
		DeleteEntity(modelt.headlight_b)
		DeleteEntity(modelt.headlight_l)
		DeleteEntity(modelt.headlight_r)
			  DeleteEntity(hobj)
	  DeleteEntity(hobj2)
	  DeleteEntity(hobj3)
	  
	    -- TriggerServerEvent('stopEngineAudio', primaryAudioNetId, secondaryAudioNetId)		
        if modelt.primaryAudio then
          DeleteEntity(modelt.primaryAudio)
        end
        if modelt.secondaryAudio then
          DeleteEntity(modelt.secondaryAudio)
        end       
        -- Delete the front wheels
        if modelt.frontWheels then
          for _, frontWheel in ipairs(modelt.frontWheels) do
            DeleteEntity(frontWheel)
          end
        end
        -- Delete the rear wheels
        if modelt.rearWheels then
          for _, rearWheel in ipairs(modelt.rearWheels) do
            DeleteEntity(rearWheel)
          end
        end   
        -- Clear the modelt data
        modelt = nil
      end
    end)
