local VORPcore = exports.vorp_core:GetCore()

local bulletinBoardPrompt
local bulletinBoardGroup = GetRandomIntInRange(0, 0xffffff)

local state = false
local Blips = {}
local Props = {}


------------------------------------
local function CreateBlip(coords)
    local blip = Citizen.InvokeNative(0x554D9D53F696D002, 1664425300, coords.x, coords.y, coords.z)
    SetBlipSprite(blip, joaat(Config.bliphash))
    Citizen.InvokeNative(0x9CB1A1623062F402, blip, _U('Name'))
    
    Blips[#Blips+1] = blip
end

local function CreateProps(coords)
    local propsHash = joaat(Config.prophash)

    if not HasModelLoaded(propsHash) then
		RequestModel(propsHash, false)
	end

    while not HasModelLoaded(propsHash) do
		Wait(1)
	end

    local props = CreateObject(Config.prophash, coords.x, coords.y, coords.z, false, true, false)

    while not DoesEntityExist(props) do
		Wait(20)
	end

    SetEntityHeading(props, coords[4])
    SetEntityAsMissionEntity(props, true, true)
    FreezeEntityPosition(props, true)
	SetModelAsNoLongerNeeded(propsHash)

    Props[#Props+1] = props
end

local function OpenBulletinBoardMenu(id)
    local myJobs =  VORPcore.Callback.TriggerAwait('ks_multijob:callback:getMyJobs')

    state = not state
    SetNuiFocus(state, state)
    SendNUIMessage({
        type = 'board',
        visible = state,
        jobList = Config.bulletinBoard[id].jobList,
        myJobs = myJobs,
        maxJobsCount = Config.maxJobsCount
    })
end

local function OpenMyJobsMenu()
    local myJobs =  VORPcore.Callback.TriggerAwait('ks_multijob:callback:getMyJobs')

    state = not state
    SetNuiFocus(state, state)
    SendNUIMessage({
        type = 'menu',
        visible = state,
        myJobs = myJobs,
        maxJobsCount = Config.maxJobsCount
    })
end


------------------------------------
Citizen.CreateThread(function()
    local str = (_U('Open'))
    bulletinBoardPrompt = PromptRegisterBegin()
    PromptSetControlAction(bulletinBoardPrompt, Config.key)
    str = CreateVarString(10, 'LITERAL_STRING', str)
    PromptSetText(bulletinBoardPrompt, str)
    PromptSetEnabled(bulletinBoardPrompt, 1)
    PromptSetVisible(bulletinBoardPrompt, 1)
    PromptSetHoldMode(bulletinBoardPrompt, 100)
    PromptSetGroup(bulletinBoardPrompt, bulletinBoardGroup)
    PromptRegisterEnd(bulletinBoardPrompt)
end)

Citizen.CreateThread(function()
    local label  = CreateVarString(10, 'LITERAL_STRING', _U('Name'))

    Wait(1000)
    while true do
        local ped = PlayerPedId()
        local pCoords = GetEntityCoords(ped)
        local t = 500

        for k, v in pairs(Config.bulletinBoard) do
            local dCoords = v.coords
            local coords = vector3(dCoords.x, dCoords.y, dCoords.z)
            local dist = #(pCoords - coords)

            if dist < 2 then
                t = 4
                PromptSetActiveGroupThisFrame(bulletinBoardGroup, label)
                if PromptHasHoldModeCompleted(bulletinBoardPrompt) then
                    Wait(10)
                    OpenBulletinBoardMenu(k)
                    Wait(10)
                end
            end
        end
        Citizen.Wait(t)
    end
end)


------------------------------------
RegisterNetEvent("vorp:SelectedCharacter", function(charid)
    for i, v in pairs(Config.bulletinBoard) do
        CreateBlip(v.coords)
        CreateProps(v.coords)
    end
end)

AddEventHandler('onResourceStop', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then return end

    if Blips then
        for k, v in pairs(Blips) do
            RemoveBlip(v)
        end
    end
    if Props then
        for k, v in pairs(Props) do
            DeleteEntity(v)
        end
    end
end)

AddEventHandler('onClientResourceStart', function (resourceName)
    if(GetCurrentResourceName() ~= resourceName) then return end

    if LocalPlayer.state.Character then
        for i, v in pairs(Config.bulletinBoard) do
            CreateBlip(v.coords)
            CreateProps(v.coords)
        end
    end
end)


------------------------------------
RegisterNUICallback('updatestate', function(args, nuicb)
    state = args.state
    SetNuiFocus(state, state)

    nuicb('ok')
end)

RegisterNUICallback('languageCB', function(args, nuicb)
    local language = args.language
    if language then
        local lang = {
            defaultLang = Config.defaultLang,
            lang = Interface,
        }
        nuicb(lang)
    end
end)

RegisterNUICallback('addJob', function(args, nuicb)
    local job = args.job

    TriggerServerEvent("ks_multijob:client:addJob", job)
    nuicb('ok')
end)

RegisterNUICallback('addJobError', function(args, nuicb)
    local error = args.error

    if error then
        VORPcore.NotifyRightTip(_U('Notif_MaxJobs'),4000)
    end

    nuicb('ok')
end)

RegisterNUICallback('selectJob', function(args, nuicb)
    local job = args.job

    TriggerServerEvent("ks_multijob:client:updateSelectedJob", job)
    nuicb('ok')
end)

RegisterNUICallback('deleteJob', function(args, nuicb)
    local jobName = args.jobName

    TriggerServerEvent("ks_multijob:client:deleteJob", jobName)
    nuicb('ok')
end)


------------------------------------
RegisterCommand(_U('MyJobs_Command'), function(source, args, rawCommand)
    OpenMyJobsMenu()
end, false)

TriggerEvent("chat:addSuggestion", "/".._U("MyJobs_Command"), _U("MyJobs_Suggest"))
