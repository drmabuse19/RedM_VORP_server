local knockedOut = false
local wait = 0
local RegeningHealth = false
local sleep = 1

function DrawText(str, x, y, w, h, enableShadow, col1, col2, col3, a, centre)
    str = CreateVarString(10, "LITERAL_STRING", str, Citizen.ResultAsLong())
    SetTextScale(w, h)
    SetTextColor(math.floor(col1), math.floor(col2), math.floor(col3), math.floor(a))
    SetTextCentre(centre)
    if enableShadow then
        SetTextDropshadow(1, 0, 0, 0, 255)
    end
    Citizen.InvokeNative(0xADA9255D, 10);
    DisplayText(str, x, y)
end

function RegenHealth()
    CreateThread(function ()
        while true do
            if RegeningHealth then
                if GetEntityHealth(PlayerPedId()) <= Config.HealthRegen.MaxHealthToStopRegen then
                    SetEntityHealth(PlayerPedId(), GetEntityHealth(PlayerPedId()) + Config.HealthRegen.HealthPerTick)
                else
                    RegeningHealth = false
                end
            else
                break
            end
            Wait(Config.HealthRegen.HeathTimeTick * 1000)
        end
    end)
end

function KnockedOut()
    CreateThread(function ()
        while true do
            sleep = 1
            if knockedOut then
                if Config.KnockedOut.OnScreenTextActive then
                    DrawText(Config.KnockedOut.OnScreenText, 0.50, 0.95, 0.7, 0.5, true, 255, 255, 255, 255, true)
                end
                SetPlayerInvincible(PlayerId(), true)
                DisablePlayerFiring(PlayerId(), true)
                SetPedToRagdoll(PlayerPedId(), 1000, 1000, 0, 0, 0, 0)
                ResetPedRagdollTimer(PlayerPedId())
                SetTimecycleModifier('Bloom')
                SetTimecycleModifierStrength(2.8);
                ShakeGameplayCam("VIBRATE_SHAKE", 1.0)
                if wait >= 0 then
                    wait = wait - 1
                    if Config.HealthRegen.Active then
                        if GetEntityHealth(PlayerPedId()) <= Config.HealthRegen.MinHealthToStartRegen and not RegeningHealth then
                            RegeningHealth = true
                            RegenHealth()
                        end
                    end
                else
                    ClearTimecycleModifier()
                    SetPlayerInvincible(PlayerId(), false)
                    DisablePlayerFiring(PlayerId(), false)
                    knockedOut = false
                end
            else
                ClearTimecycleModifier()
                SetPlayerInvincible(PlayerId(), false)
                DisablePlayerFiring(PlayerId(), false)
                break
            end
            Wait(sleep)
        end
    end)
end

CreateThread(function()
    while true do
        sleep = 1
        if IsPedInMeleeCombat(PlayerPedId()) then
            if Citizen.InvokeNative(0xDCF06D0CDFF68424, PlayerPedId(), GetHashKey("WEAPON_UNARMED"), 0) then
                if GetEntityHealth(PlayerPedId()) < Config.KnockedOut.MinHealthToBeKnockedOut and not knockedOut then
                    if Config.KnockedOut.AddedScreenEffect then
                        ShakeGameplayCam(Config.KnockedOut.AddedScreenEffect, Config.KnockedOut.AddedEffectIntensity)
                    end
                    knockedOut = true
                    wait = math.random(Config.KnockedOut.KnockedOutTimeMin,Config.KnockedOut.KnockedOutTimeMax) * 100
                    KnockedOut()
                end
            end
        end
        Wait(sleep)
	end
end)
