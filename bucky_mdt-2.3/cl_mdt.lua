local isVisible = false
local prop = nil
local JournalOuvert = false

function DrawTxt(str, x, y, w, h, enableShadow, col1, col2, col3, a, centre)
    local str = CreateVarString(10, "LITERAL_STRING", str)
    SetTextScale(w, h)
    SetTextColor(math.floor(col1), math.floor(col2), math.floor(col3), math.floor(a))
    SetTextCentre(centre)
    SetTextFontForCurrentCommand(15) 
    if enableShadow then SetTextDropshadow(1, 0, 0, 0, 255) end
    DisplayText(str, x, y)
end
    Citizen.CreateThread(function()   
        if Config.UseOffice == true then 
        while true do 
            Citizen.Wait(1)
            local coords = GetEntityCoords(PlayerPedId())
            for k,v in pairs(Config.Office) do
                if GetDistanceBetweenCoords(coords.x, coords.y, coords.z, v.coords[1], v.coords[2], v.coords[3], false) < 1.0  then
                DrawTxt(Config.Open['text'], 0.50, 0.95, 0.7, 0.5, true, 223, 44, 53, 255, true)
                if IsControlJustPressed(0, Config.Open['key']) then
                    ExecuteCommand(""..Config.Command.."")                
                end    
            end
        end
    end
        end
    end)

TriggerServerEvent("bucky_mdt:getOffensesAndOfficer")

RegisterNetEvent("bucky_mdt:toggleVisibilty")
AddEventHandler("bucky_mdt:toggleVisibilty", function(reports, warrants, officer, job, grade, note)
    local playerPed = PlayerPedId()
    if not isVisible then
        SetCurrentPedWeapon(playerPed, GetHashKey('WEAPON_UNARMED'), true) -- unarm player
        Wait(1000)
        Citizen.InvokeNative(0x524B54361229154F, PlayerPedId(), GetHashKey("world_human_write_notebook"), 9999999999,true,false, false, false)
    else
        FreezeEntityPosition(PlayerPedId(), false)
        Wait(1000)
        ClearPedSecondaryTask(PlayerPedId())
        ClearPedTasks(PlayerPedId())        
    end
    if #warrants == 0 then warrants = false end
    if #reports == 0 then reports = false end
    if #note == 0 then note = false end
    SendNUIMessage({
        type = "recentReportsAndWarrantsLoaded",
        reports = reports,
        warrants = warrants,
        officer = officer,
        department = job,
        rank = grade,
        note = note,
    })
    ToggleGUI()
end)

RegisterNUICallback("close", function(data, cb)
    FreezeEntityPosition(PlayerPedId(), false)
	ClearPedSecondaryTask(PlayerPedId())
	ClearPedTasks(PlayerPedId())
	SetCurrentPedWeapon(PlayerPedId(), 0xA2719263, true)
    ToggleGUI(false)
    cb('ok')
end)

RegisterNUICallback("performOffenderSearch", function(data, cb)
    TriggerServerEvent("bucky_mdt:performOffenderSearch", data.query)
    TriggerServerEvent("bucky_mdt:getOffensesAndOfficer")
    cb('ok')
end)

RegisterNUICallback("viewOffender", function(data, cb)
    TriggerServerEvent("bucky_mdt:getOffenderDetails", data.offender)
    cb('ok')
end)

RegisterNUICallback("saveOffenderChanges", function(data, cb)
    TriggerServerEvent("bucky_mdt:saveOffenderChanges", data.id, data.changes, data.identifier)
    cb('ok')
end)

RegisterNUICallback("submitNewReport", function(data, cb)
    TriggerServerEvent("bucky_mdt:submitNewReport", data)
    cb('ok')
end)

RegisterNUICallback("submitNote", function(data, cb)
    TriggerServerEvent("bucky_mdt:submitNote", data)
    cb('ok')
end)

RegisterNUICallback("performReportSearch", function(data, cb)
    TriggerServerEvent("bucky_mdt:performReportSearch", data.query)
    cb('ok')
end)

RegisterNUICallback("getOffender", function(data, cb)
    TriggerServerEvent("bucky_mdt:getOffenderDetailsById", data.char_id)
    cb('ok')
end)

RegisterNUICallback("deleteReport", function(data, cb)
    TriggerServerEvent("bucky_mdt:deleteReport", data.id)
    cb('ok')
end)

RegisterNUICallback("deleteNote", function(data, cb)
    TriggerServerEvent("bucky_mdt:deleteNote", data.id)
    cb('ok')
end)

RegisterNUICallback("saveReportChanges", function(data, cb)
    TriggerServerEvent("bucky_mdt:saveReportChanges", data)
    cb('ok')
end)

RegisterNUICallback("getWarrants", function(data, cb)
    TriggerServerEvent("bucky_mdt:getWarrants")
end)

RegisterNUICallback("submitNewWarrant", function(data, cb)
    TriggerServerEvent("bucky_mdt:submitNewWarrant", data)
    cb('ok')
end)

RegisterNUICallback("deleteWarrant", function(data, cb)
    TriggerServerEvent("bucky_mdt:deleteWarrant", data.id)
    cb('ok')
end)

RegisterNUICallback("deleteWarrant", function(data, cb)
    TriggerServerEvent("bucky_mdt:deleteWarrant", data.id)
    cb('ok')
end)

RegisterNUICallback("getReport", function(data, cb)
    TriggerServerEvent("bucky_mdt:getReportDetailsById", data.id)
    cb('ok')
end)

RegisterNUICallback("getNotes", function(data, cb)
    TriggerServerEvent("bucky_mdt:getNoteDetailsById", data.id)
    cb('ok')
end)

RegisterNetEvent("bucky_mdt:returnOffenderSearchResults")
AddEventHandler("bucky_mdt:returnOffenderSearchResults", function(results)
    SendNUIMessage({
        type = "returnedPersonMatches",
        matches = results
    })
end)

RegisterNetEvent("bucky_mdt:closeModal")
AddEventHandler("bucky_mdt:closeModal", function()
    SendNUIMessage({
        type = "closeModal"
    })
end)

RegisterNetEvent("bucky_mdt:returnOffenderDetails")
AddEventHandler("bucky_mdt:returnOffenderDetails", function(data)
    SendNUIMessage({
        type = "returnedOffenderDetails",
        details = data
    })
end)

RegisterNetEvent("bucky_mdt:returnOffensesAndOfficer")
AddEventHandler("bucky_mdt:returnOffensesAndOfficer", function(data, name)
    SendNUIMessage({
        type = "offensesAndOfficerLoaded",
        offenses = data,
        name = name
    })
end)

RegisterNetEvent("bucky_mdt:returnReportSearchResults")
AddEventHandler("bucky_mdt:returnReportSearchResults", function(results)
    SendNUIMessage({
        type = "returnedReportMatches",
        matches = results
    })
end)

RegisterNetEvent("bucky_mdt:returnWarrants")
AddEventHandler("bucky_mdt:returnWarrants", function(data)
    SendNUIMessage({
        type = "returnedWarrants",
        warrants = data
    })
end)

RegisterNetEvent("bucky_mdt:completedWarrantAction")
AddEventHandler("bucky_mdt:completedWarrantAction", function(data)
    SendNUIMessage({
        type = "completedWarrantAction"
    })
end)

RegisterNetEvent("bucky_mdt:returnReportDetails")
AddEventHandler("bucky_mdt:returnReportDetails", function(data)
    SendNUIMessage({
        type = "returnedReportDetails",
        details = data
    })
end)

RegisterNetEvent("bucky_mdt:returnNoteDetails")
AddEventHandler("bucky_mdt:returnNoteDetails", function(data)
    SendNUIMessage({
        type = "returnedNoteDetails",
        details = data
    })
end)

RegisterNetEvent("bucky_mdt:sendNUIMessage")
AddEventHandler("bucky_mdt:sendNUIMessage", function(messageTable)
    SendNUIMessage(messageTable)
end)

RegisterNetEvent("bucky_mdt:sendNotification")
AddEventHandler("bucky_mdt:sendNotification", function(message)
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
