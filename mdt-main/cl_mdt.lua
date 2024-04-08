local isVisible = false
local prop = nil
local JournalOuvert = false

TriggerServerEvent("mdt:getOffensesAndOfficer")

function SortirJournal()
    local ped = PlayerPedId()
	AnimationJ(ped, "mech_inspection@mini_map@satchel", "enter")
end

function RangerJournal()
    local ped = PlayerPedId()
	AnimationJ(ped, "mech_inspection@two_fold_map@satchel", "exit_satchel")
end

function AnimationJ(ped, dict, name)
    if not DoesAnimDictExist(dict) then
      return
    end
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
    Citizen.Wait(0)
    end
    TaskPlayAnim(ped, dict, name, -1.0, -0.5, 2000, 1, 0, true, 0, false, 0, false)
    RemoveAnimDict(dict)
end

RegisterNetEvent("mdt:toggleVisibilty")
AddEventHandler("mdt:toggleVisibilty", function(reports, warrants, officer, job, grade)
    local playerPed = PlayerPedId()
    if not isVisible then
        SetCurrentPedWeapon(playerPed, GetHashKey('WEAPON_UNARMED'), true) -- unarm player
        JournalOuvert = true
        SortirJournal()
        Wait(2000)
        local player = PlayerPedId()
        local coords = GetEntityCoords(player) 
        local props = CreateObject(GetHashKey("p_cs_newspaper_02x_noanim"), coords.x, coords.y, coords.z, 1, 0, 1)
        prop = props
        SetEntityAsMissionEntity(prop,true,true)
        RequestAnimDict("mech_carry_box")
        while not HasAnimDictLoaded("mech_carry_box") do
        Citizen.Wait(100)
        end
        Citizen.InvokeNative(0xEA47FE3719165B94, player,"mech_carry_box", "idle", 1.0, 8.0, -1, 31, 0, 0, 0, 0)
        Citizen.InvokeNative(0x6B9BBD38AB0796DF, prop,player,GetEntityBoneIndexByName(player,"SKEL_L_Finger12"), 0.20, 0.00, -0.05, 180.0, 190.0, 0.0, true, true, false, true, 1, true)	
    else
        local playerPed = PlayerPedId()
        FreezeEntityPosition(PlayerPedId(), false)
        JournalOuvert = false

        RangerJournal()
        Wait(2000)
        
        ClearPedSecondaryTask(GetPlayerPed(PlayerId()))
        DetachEntity(prop,false,true)
        ClearPedTasks(player)
        DeleteObject(prop)	

    end
    if #warrants == 0 then warrants = false end
    if #reports == 0 then reports = false end
    SendNUIMessage({
        type = "recentReportsAndWarrantsLoaded",
        reports = reports,
        warrants = warrants,
        officer = officer,
        department = job,
        rank = grade
    })
    ToggleGUI()
end)

RegisterNUICallback("close", function(data, cb)

    FreezeEntityPosition(PlayerPedId(), false)
    JournalOuvert = false

    RangerJournal()
    Wait(2000)
    
    ClearPedSecondaryTask(GetPlayerPed(PlayerId()))
    DetachEntity(prop,false,true)
    ClearPedTasks(player)
    DeleteObject(prop)	

    ToggleGUI(false)
    cb('ok')
end)

RegisterNUICallback("performOffenderSearch", function(data, cb)
    TriggerServerEvent("mdt:performOffenderSearch", data.query)
print(data.query)
    TriggerServerEvent("mdt:getOffensesAndOfficer")
    cb('ok')
end)

RegisterNUICallback("viewOffender", function(data, cb)
    TriggerServerEvent("mdt:getOffenderDetails", data.offender)
    cb('ok')
end)

RegisterNUICallback("saveOffenderChanges", function(data, cb)
    TriggerServerEvent("mdt:saveOffenderChanges", data.id, data.changes, data.identifier)
    cb('ok')
end)

RegisterNUICallback("submitNewReport", function(data, cb)
    TriggerServerEvent("mdt:submitNewReport", data)
    cb('ok')
end)

RegisterNUICallback("performReportSearch", function(data, cb)
    TriggerServerEvent("mdt:performReportSearch", data.query)
    cb('ok')
end)

RegisterNUICallback("getOffender", function(data, cb)
    TriggerServerEvent("mdt:getOffenderDetailsById", data.char_id)
    cb('ok')
end)

RegisterNUICallback("deleteReport", function(data, cb)
    TriggerServerEvent("mdt:deleteReport", data.id)
    cb('ok')
end)

RegisterNUICallback("saveReportChanges", function(data, cb)
    TriggerServerEvent("mdt:saveReportChanges", data)
    cb('ok')
end)

RegisterNUICallback("getWarrants", function(data, cb)
    TriggerServerEvent("mdt:getWarrants")
end)

RegisterNUICallback("submitNewWarrant", function(data, cb)
    TriggerServerEvent("mdt:submitNewWarrant", data)
    cb('ok')
end)

RegisterNUICallback("deleteWarrant", function(data, cb)
    TriggerServerEvent("mdt:deleteWarrant", data.id)
    cb('ok')
end)

RegisterNUICallback("deleteWarrant", function(data, cb)
    TriggerServerEvent("mdt:deleteWarrant", data.id)
    cb('ok')
end)

RegisterNUICallback("getReport", function(data, cb)
    TriggerServerEvent("mdt:getReportDetailsById", data.id)
    cb('ok')
end)

RegisterNetEvent("mdt:returnOffenderSearchResults")
AddEventHandler("mdt:returnOffenderSearchResults", function(results)
    SendNUIMessage({
        type = "returnedPersonMatches",
        matches = results
    })
end)

RegisterNetEvent("mdt:closeModal")
AddEventHandler("mdt:closeModal", function()
    SendNUIMessage({
        type = "closeModal"
    })
end)

RegisterNetEvent("mdt:returnOffenderDetails")
AddEventHandler("mdt:returnOffenderDetails", function(data)
    SendNUIMessage({
        type = "returnedOffenderDetails",
        details = data
    })
end)

RegisterNetEvent("mdt:returnOffensesAndOfficer")
AddEventHandler("mdt:returnOffensesAndOfficer", function(data, name)
    SendNUIMessage({
        type = "offensesAndOfficerLoaded",
        offenses = data,
        name = name
    })
end)

RegisterNetEvent("mdt:returnReportSearchResults")
AddEventHandler("mdt:returnReportSearchResults", function(results)
    SendNUIMessage({
        type = "returnedReportMatches",
        matches = results
    })
end)

RegisterNetEvent("mdt:returnWarrants")
AddEventHandler("mdt:returnWarrants", function(data)
    SendNUIMessage({
        type = "returnedWarrants",
        warrants = data
    })
end)

RegisterNetEvent("mdt:completedWarrantAction")
AddEventHandler("mdt:completedWarrantAction", function(data)
    SendNUIMessage({
        type = "completedWarrantAction"
    })
end)

RegisterNetEvent("mdt:returnReportDetails")
AddEventHandler("mdt:returnReportDetails", function(data)
    SendNUIMessage({
        type = "returnedReportDetails",
        details = data
    })
end)

RegisterNetEvent("mdt:sendNUIMessage")
AddEventHandler("mdt:sendNUIMessage", function(messageTable)
    SendNUIMessage(messageTable)
end)

RegisterNetEvent("mdt:sendNotification")
AddEventHandler("mdt:sendNotification", function(message)
    SendNUIMessage({
        type = "sendNotification",
        message = message
    })
end)

function ToggleGUI(explicit_status)
  if explicit_status ~= nil then
    isVisible = explicit_status
  else
    isVisible = not isVisible
  end
  SetNuiFocus(isVisible, isVisible)
  SendNUIMessage({
    type = "enable",
    isVisible = isVisible
  })
end
