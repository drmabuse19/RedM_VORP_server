local vorpShowUI = true
local ShowUI = true

function CoreAction.Utils.ToggleVorpUI()
    vorpShowUI = not vorpShowUI
    TriggerEvent("vorp:showUi", vorpShowUI)
end

function CoreAction.Utils.ToggleAllUI()
    ShowUI = not ShowUI
    ExecuteCommand("togglechat")
    DisplayRadar(ShowUI)
    TriggerEvent("syn_displayrange", ShowUI)
    TriggerEvent("vorp:showUi", ShowUI)
end

RegisterNetEvent('vorp:updateUi', function(stringJson)
    SendNUIMessage(json.decode(stringJson))
end)

RegisterNetEvent('vorp:showUi', function(active)
    vorpShowUI = active
    local jsonpost = { type = "ui", action = "hide" }
    if active then jsonpost = { type = "ui", action = "show" } end

    SendNUIMessage(jsonpost)
end)

RegisterNetEvent('vorp:setPVPUi', function(active)
    SendNUIMessage({ type = "ui", action = "setpvp", pvp = active })
end)

RegisterNetEvent('vorp:SelectedCharacter', function()
    Citizen.Wait(10000)
    SendNUIMessage({
        type = "ui",
        action = "initiate",
        hidegold = Config.HideGold,
        hidemoney = Config.HideMoney,
        hidelevel = Config.HideLevel,
        hideid = Config.HideID,
        hidetokens = Config.HideTokens,
        uiposition = Config.UIPosition,
        uilayout = Config.UILayout,
        closeondelay = Config.CloseOnDelay,
        closeondelayms = Config.CloseOnDelayMS,
        hidepvp = Config.HidePVP,
        pvp = Config.PVP
    })

    if Config.HideWithRader then
        local cantoggle = not Config.HideUi

        Citizen.CreateThread(function()
            while true do
                if IsRadarHidden() then
                    cantoggle = true
                    SendNUIMessage({ type = "ui", action = "hide" })
                    vorpShowUI = false
                elseif cantoggle and Config.OpenAfterRader then
                    cantoggle = false
                    SendNUIMessage({ type = "ui", action = "show" })
                    vorpShowUI = true
                end

                Citizen.Wait(1000)
            end
        end)
    end
end)

RegisterNUICallback('close', function(args, cb)
    vorpShowUI = false
    cb('ok')
end)
