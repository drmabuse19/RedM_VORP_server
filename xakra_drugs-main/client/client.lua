local peds = {}

--########################### LOAD MODEL ###########################
function LoadModel(model)
    local modelHash = GetHashKey(model)
    RequestModel(modelHash)
    while not HasModelLoaded(modelHash) do
        Citizen.Wait(100)
    end
end

--########################### ANIM ###########################
function Anim(actor, dict, body, duration, flags, introtiming, exittiming)
	RequestAnimDict(dict)
	local dur = duration or -1
	local flag = flags or 1
	local intro = tonumber(introtiming) or 1.0
	local exit = tonumber(exittiming) or 1.0

	while not HasAnimDictLoaded(dict)  do
		RequestAnimDict(dict)
		Citizen.Wait(300)
	end
	TaskPlayAnim(actor, dict, body, intro, exit, dur, flag, 1, false, false, false, 0, true)
end

--########################### JOINT ###########################
local joints = 0

Citizen.CreateThread(function()         
    while true do
		if joints > 0 then
			Wait(Config.JointTimeLimit)
			joints = 0
		end
		Citizen.Wait(1000)
	end
end)

RegisterNetEvent('xakra_drugs:JointAnim')
AddEventHandler('xakra_drugs:JointAnim', function()
	local cigarette = CreateObject(GetHashKey('p_cigarette_dynamic_01x'), GetEntityCoords(PlayerPedId()), true, true, true)
    local righthand = GetEntityBoneIndexByName(PlayerPedId(), "SKEL_R_Finger13")
    local mouth = GetEntityBoneIndexByName(PlayerPedId(), "skel_head")
	
    AttachEntityToEntity(cigarette, PlayerPedId(), mouth, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, true, true, false, true, 1, true)
    Anim(PlayerPedId(), "amb_rest@world_human_smoking@male_c@stand_enter","enter_back_rf",9400,0)
    Wait(1000)
    AttachEntityToEntity(cigarette, PlayerPedId(), righthand, 0.03, -0.01, 0.0, 0.0, 90.0, 0.0, true, true, false, true, 1, true)
    Wait(1000)
    AttachEntityToEntity(cigarette, PlayerPedId(), mouth, -0.017, 0.1, -0.01, 0.0, 90.0, -90.0, true, true, false, true, 1, true)
    Wait(3000)
    AttachEntityToEntity(cigarette, PlayerPedId(), righthand, 0.017, -0.01, -0.01, 0.0, 120.0, 10.0, true, true, false, true, 1, true)
    Wait(1000)
    Anim(PlayerPedId(), "amb_rest@world_human_smoking@male_c@base","base",-1,30)
    RemoveAnimDict("amb_rest@world_human_smoking@male_c@stand_enter")
    Wait(2000)
	ClearPedTasks(PlayerPedId())
	Anim(PlayerPedId(), "amb_rest@world_human_smoking@male_a@stand_exit", "exit_back", -1, 1)
	Wait(2800)
	DetachEntity(cigarette, true, true)
	SetEntityVelocity(cigarette, 0.0,0.0,-1.0)
	Wait(1500)
	ClearPedTasks(PlayerPedId())

	if joints < Config.JointLimit then
		joints = joints + 1

		Citizen.InvokeNative(0x406CCF555B04FAD3, PlayerPedId(), true, 0.5) -- SetPedDrunkness
		AnimpostfxPlay('PlayerDrugsPoisonWell')
		
		Citizen.InvokeNative(0xC6258F41D86676E0, PlayerPedId(), 0, 100)	-- SetAttributeCoreValue
		Citizen.InvokeNative(0x4AF5A4C7B9157D14, PlayerPedId(), 0, 1000.0, true)	-- EnableAttributeCoreOverpower

		Wait(Config.JointEffect)
		AnimpostfxPlay('CamTransitionBlinkSlow')
		AnimpostfxStop('PlayerDrugsPoisonWell')
		Citizen.InvokeNative(0x406CCF555B04FAD3, PlayerPedId(), false, 0.0)	-- SetPedDrunkness
	else
		Wait(5000)
		local time = Config.JointEffect + 10000
		AnimpostfxPlay('playerdrugshalluc01')
		SetPedToRagdoll(PlayerPedId(), 1000, 1000, 0, 0, 0, 0) 
		while time > 0 do 
			time = time - 500
			ResetPedRagdollTimer(PlayerPedId())
			Wait(500)
		end
		Wait(time)
		AnimpostfxPlay('PlayerWakeUpDrunk')
		AnimpostfxStop('playerdrugshalluc01')
	end
end)

--########################### OPIUM ###########################
RegisterNetEvent('xakra_drugs:Opium')
AddEventHandler('xakra_drugs:Opium', function()
	local pipe = CreateObject(GetHashKey('P_PIPE01X'), GetEntityCoords(PlayerPedId()), true, true, true)
    local righthand = GetEntityBoneIndexByName(PlayerPedId(), "SKEL_R_Finger13")
    AttachEntityToEntity(pipe, PlayerPedId(), righthand, 0.005, -0.045, 0.0, -170.0, 10.0, -15.0, true, true, false, true, 1, true)
    Anim(PlayerPedId(),"amb_wander@code_human_smoking_wander@male_b@trans","nopipe_trans_pipe",-1,30)
    Wait(8000)
	Anim(PlayerPedId(), "amb_wander@code_human_smoking_wander@male_b@trans", "pipe_trans_nopipe", -1, 30)
	Wait(500)
	DeleteEntity(pipe)
	ClearPedTasks(PlayerPedId())

	AnimpostfxPlay('PlayerWakeUpDrunk')
	AnimpostfxPlay('playerdrugshalluc01')
	Citizen.InvokeNative(0x406CCF555B04FAD3, PlayerPedId(), true, 1.0) -- SetPedDrunkness

	Citizen.InvokeNative(0xC6258F41D86676E0, PlayerPedId(), 0, 100)	-- SetAttributeCoreValue
	Citizen.InvokeNative(0x4AF5A4C7B9157D14, PlayerPedId(), 0, 1000.0, true)	-- EnableAttributeCoreOverpower

	for i = 0, Config.OpiumpQuantityPeds do
		local model = Config.OpiumpPeds[math.random(#Config.OpiumpPeds)]
		CreateOpiumPed(model)
	end

	Wait(Config.OpiumEffect)

	for _, ped in pairs(peds) do
		DeleteEntity(ped)
	end

	AnimpostfxPlay('PlayerWakeUpDrunk')
	AnimpostfxStop('playerdrugshalluc01')
	Citizen.InvokeNative(0x406CCF555B04FAD3, PlayerPedId(), false, 0.0) -- SetPedDrunkness
end)

function CreateOpiumPed(model)

    local pcoords = GetEntityCoords(PlayerPedId())

	local x = pcoords.x + math.random(-20, 20)
	local y = pcoords.y + math.random(-20, 20)
	local _,z = GetGroundZAndNormalFor_3dCoord(x, y, pcoords.z + 999)
	local coords = vector4(x, y, z, math.random(360) + 0.0)

	LoadModel(model)
    local ped = CreatePed(model, coords, false, false, true, true)        
    Citizen.InvokeNative(0x283978A15512B2FE, ped, true)  -- SetRandomOutfitVariation
	table.insert(peds, ped)
    SetModelAsNoLongerNeeded(model)
	SetPedScale(ped, 5.0)
end

--########################### MUSHROOM ###########################
local cam, mushroom
local SkyEffects = {
	"skytl_0000_01clear",
	"skytl_0000_03clouds",
	"skytl_0000_04storm",
	"skytl_0300_01clear",
	"skytl_0300_03clouds",
	"skytl_0300_04storm",
	"skytl_0600_01clear",
	"skytl_0600_03clouds",
	"skytl_0600_04storm",
	"skytl_0900_01clear",
	"skytl_0900_03clouds",
	"skytl_0900_04storm",
	"skytl_1200_01clear",
	"skytl_1200_03clouds",
	"skytl_1200_04storm",
	"skytl_1500_01clear",
	"skytl_1500_03clouds",
	"skytl_1500_04storm",
	"skytl_1800_01clear",
	"skytl_1800_03clouds",
	"skytl_1800_04storm",
	"skytl_2100_01clear",
	"skytl_2100_03clouds",
	"skytl_2100_04storm",
	"SkyTL_0000_01Clear_nofade",
	"SkyTL_0000_03Clouds_nofade",
	"SkyTL_0000_04Storm_nofade",
	"SkyTL_0300_01Clear_nofade",
	"SkyTL_0300_03Clouds_nofade",
	"SkyTL_0300_04Storm_nofade",
	"SkyTL_0600_01Clear_nofade",
	"SkyTL_0600_03Clouds_nofade",
	"SkyTL_0600_04Storm_nofade",
	"SkyTL_0900_01Clear_nofade",
	"SkyTL_0900_03Clouds_nofade",
	"SkyTL_0900_04Storm_nofade",
	"SkyTL_1200_01Clear_nofade",
	"SkyTL_1200_03Clouds_nofade",
	"SkyTL_1200_04Storm_nofade",
	"SkyTL_1500_01Clear_nofade",
	"SkyTL_1500_03Clouds_nofade",
	"SkyTL_1500_04Storm_nofade",
	"SkyTL_1800_01Clear_nofade",
	"SkyTL_1800_03Clouds_nofade",
	"SkyTL_1800_04Storm_nofade",
	"SkyTL_2100_01Clear_nofade",
	"SkyTL_2100_03Clouds_nofade",
	"SkyTL_2100_04Storm_nofade",
}

RegisterNetEvent('xakra_drugs:Mushroom')
AddEventHandler('xakra_drugs:Mushroom', function()
	mushroom = CreateObject(GetHashKey('s_amedmush'), GetEntityCoords(PlayerPedId()), true, true, true)
    local righthand = GetEntityBoneIndexByName(PlayerPedId(), "SKEL_R_Finger13")
    AttachEntityToEntity(mushroom, PlayerPedId(), righthand, 0.005, -0.045, 0.0, -170.0, 10.0, -15.0, true, true, false, true, 1, true)
	Anim(PlayerPedId(), "mech_inventory@eating@multi_bite@wedge_a4-2_b0-75_w8_h9-4_eat_cheese", "quick_right_hand", -1, 30)
	Wait(3000)
	
	DeleteEntity(mushroom)
	ClearPedTasks(PlayerPedId())
	Citizen.InvokeNative(0x406CCF555B04FAD3, PlayerPedId(), true, 1.0)	-- SetPedDrunkness
	AnimpostfxPlay('PlayerRPGCore')
	Wait(10000)

	Citizen.InvokeNative(0x449995EA846D3FC2, -90.0)	-- SetGameplayCamInitialPitch
	Anim(PlayerPedId(), "veh_train@trolly@exterior@rl@exit@to@land@normal@get_out_start@male","dead_fall_out", -1, 2)
	Wait(10000)

	Citizen.InvokeNative(0x449995EA846D3FC2, -90.0)	-- SetGameplayCamInitialPitch
	Wait(500)
	local pcoords = GetEntityCoords(PlayerPedId())
	local coords = vector3(pcoords.x, pcoords.y, pcoords.z + 100)
	cam = CreateCamWithParams('DEFAULT_SCRIPTED_CAMERA', coords, -90.0, 0.0, 0.0, 60.00, false, 0)
	SetCamActive(cam, true)
	RenderScriptCams(true, true, 15000, 1, 0)
	Wait(20000)

	AnimpostfxPlay('PlayerWakeUpInterrogation')
	Wait(2000)

	local animpostfx = SkyEffects[math.random(#SkyEffects)]
	AnimpostfxPlay(animpostfx)
	Wait(20000)

	AnimpostfxPlay('PlayerWakeUpInterrogation')
	AnimpostfxStop(animpostfx)
	Wait(10000)

	for i = 0, Config.MushroomQuantityPeds do
		local model = Config.MushroomPeds[math.random(#Config.MushroomPeds)]
		CreateMushroomPed(model, coords)
	end

	if DoesCamExist(cam) then
		RenderScriptCams(false, true, 10000, 1, 0)
		DestroyCam(cam, true)
	end
	Wait(15000)

	ClearPedTasks(PlayerPedId())
	Anim(PlayerPedId(), "script_proc@robberies@shop@rhodes@gunsmith@outside_reshoot","kneel_get_up_plr", -1, 2)
	Wait(2000)

	ClearPedTasks(PlayerPedId())
	Wait(5000)

	for _, ped in pairs(peds) do
		DeleteEntity(ped)
	end
	AnimpostfxPlay('PlayerWakeUpInterrogation')
	Citizen.InvokeNative(0x406CCF555B04FAD3, PlayerPedId(), false, 0.0)	-- SetPedDrunkness
	AnimpostfxStop('PlayerRPGCore')
end)

function CreateMushroomPed(model, coords)

	local x = coords.x + math.random(-10, 10)
	local y = coords.y + math.random(-10, 10)

	local sky_coords = vector4(x, y, coords.z + 2.0, math.random(360) + 0.0)

	LoadModel(model)
    local ped = CreatePed(model, sky_coords, false, false, true, true)        
    Citizen.InvokeNative(0x283978A15512B2FE, ped, true)  -- SetRandomOutfitVariation
	table.insert(peds, ped)
    SetModelAsNoLongerNeeded(model)
	SetPedScale(ped, 2.0)
end


--########################### STOP RESOURCE ###########################
AddEventHandler('onResourceStop', function (resourceName)
	AnimpostfxStop('PlayerDrugsPoisonWell')
	AnimpostfxStop('playerdrugshalluc01')

	Citizen.InvokeNative(0x406CCF555B04FAD3, PlayerPedId(), false, 0.0)	-- SetPedDrunkness

	for _, ped in pairs(peds) do
		DeleteEntity(ped)
	end

	ClearPedTasks(PlayerPedId())

	DeleteEntity(mushroom)

	AnimpostfxStop('PlayerRPGCore')

	if DoesCamExist(cam) then
		DestroyCam(cam, true)
	end

	Citizen.InvokeNative(0x4FD80C3DD84B817B, PlayerPedId())	-- ClearPedDesiredLocoForModel
	Citizen.InvokeNative(0x58F7DB5BD8FA2288, PlayerPedId())	-- ClearPedDesiredLocoMotionType

	for _, animpostfx in pairs(SkyEffects) do
		AnimpostfxStop(animpostfx)
	end
end)