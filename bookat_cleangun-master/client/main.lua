--==================================
--====    CLEAN GUN SCRIPT      ====
--====      Le Bookmaker        ====
--====       Alphatule          ====
--====         ENJOY            ====
--==================================


-- for cleaning your gun with animation ENJOY
RegisterNetEvent('cleaning:startcleaningshort')
AddEventHandler('cleaning:startcleaningshort', function()
    local ped = PlayerPedId()
    local Cloth= CreateObject(GetHashKey('s_balledragcloth01x'), GetEntityCoords(PlayerPedId()), false, true, false, false, true)
    local PropId = GetHashKey("CLOTH")
    local actshort = GetHashKey("SHORTARM_CLEAN_ENTER")
    local actlong = GetHashKey("LONGARM_CLEAN_ENTER")
    local retval, weaponHash = GetCurrentPedWeapon(PlayerPedId(), false, weaponHash, false)
    local model = GetWeapontypeGroup(weaponHash)
    local object = GetObjectIndexFromEntityIndex(GetCurrentPedWeaponEntityIndex(PlayerPedId(),0))
    -- print("Model --> "..model)
    -- print("Weapon hash --> "..weaponHash)
    -- print("NOmbre--> "..weaponName)
    if model == 416676503 or model == -1101297303 then
        TriggerEvent("vorp_inventory:CloseInv");
        Citizen.InvokeNative(0x72F52AA2D2B172CC,  PlayerPedId(), 1242464081, Cloth, PropId, actshort, 1, 0, -1.0)   
        Wait(15000)
        --TriggerEvent("vorp:NotifyLeft", Language.translate[Config.lang]['word'], Language.translate[Config.lang]['notif'], "generic_textures", "tick", 5000)
        TriggerEvent("vorp:Tip", Language.translate[Config.lang]['notif'], 5000)
        Citizen.InvokeNative(0xA7A57E89E965D839,object,0.0,0)
        Citizen.InvokeNative(0x812CE61DEBCAB948,object,0.0,0)
    else
        TriggerEvent("vorp_inventory:CloseInv");
        Citizen.InvokeNative(0x72F52AA2D2B172CC,  PlayerPedId(), 1242464081, Cloth, PropId, actlong, 1, 0, -1.0)   
        Wait(15000)
        --TriggerEvent("vorp:NotifyLeft", Language.translate[Config.lang]['word'], Language.translate[Config.lang]['notif'], "generic_textures", "tick", 5000)
        TriggerEvent("vorp:Tip", Language.translate[Config.lang]['notif'], 5000)
        Citizen.InvokeNative(0xA7A57E89E965D839,object,0.0,0)
        Citizen.InvokeNative(0x812CE61DEBCAB948,object,0.0,0)
    end
end)



-- commande to help the script work you can put that in comment if you want 

RegisterCommand('weapon1', function(source, args, rawCommand)
    local object = GetObjectIndexFromEntityIndex(GetCurrentPedWeaponEntityIndex(PlayerPedId(),0))
    if not DoesEntityExist(object) then return end
    Citizen.InvokeNative(0xA7A57E89E965D839,object,0.0,0)
    --Citizen.InvokeNative(0xA7A57E89E965D839, object, true)
end)

RegisterCommand('weapon2', function(source, args, rawCommand)
    local object = GetObjectIndexFromEntityIndex(GetCurrentPedWeaponEntityIndex(PlayerPedId(),0))
    if not DoesEntityExist(object) then return end
    Citizen.InvokeNative(0xA7A57E89E965D839,object,0.5,0)
    --Citizen.InvokeNative(0xA7A57E89E965D839, object, false)
end)


RegisterCommand('weapon3', function(source, args, rawCommand)
    local object = GetObjectIndexFromEntityIndex(GetCurrentPedWeaponEntityIndex(PlayerPedId(),0))
    if not DoesEntityExist(object) then return end
    local retval2 = Citizen.InvokeNative(0x0D78E1097F89E637,object)--GetWeaponDegradation(object)
    print(retval2)
end)

RegisterCommand('weapon4',function(source,args,raw)
    local object = GetObjectIndexFromEntityIndex(GetCurrentPedWeaponEntityIndex(PlayerPedId(),0))
    if not DoesEntityExist(object) then return end
    local hash = tonumber(args[1])
    print(Citizen.InvokeNative(0xBD5DD5EAE2B6CE14, hash))
end)

RegisterCommand('text',function(source,args,raw)
    local object = GetObjectIndexFromEntityIndex(GetCurrentPedWeaponEntityIndex(PlayerPedId(),0))
    if not DoesEntityExist(object) then return end
    print(Citizen.InvokeNative(0xD56E5F336C675EFA,object))
end)







































--weaponHash = {
--    "WEAPON_PISTOL_M1899",      
--    "WEAPON_PISTOL_MAUSER",       
--    "WEAPON_PISTOL_SEMIAUTO",        
--    "WEAPON_PISTOL_VOLCANIC",       
--    "WEAPON_REVOLVER_CATTLEMAN",       
--    "WEAPON_REVOLVER_DOUBLEACTION",       
--    "WEAPON_REVOLVER_LEMAT",        
--    "WEAPON_REVOLVER_SCHOFIELD",
--    "WEAPON_REPEATER_CARBINE",
--	"WEAPON_REPEATER_HENRY",
--	"WEAPON_RIFLE_VARMINT",
--    "WEAPON_REPEATER_WINCHESTER",
--    "WEAPON_SHOTGUN_DOUBLEBARREL",
--	"WEAPON_SHOTGUN_DOUBLEBARREL_EXOTIC",
--	"WEAPON_SHOTGUN_PUMP",
--	"WEAPON_SHOTGUN_REPEATING",
--	"WEAPON_SHOTGUN_SAWEDOFF",
--	"WEAPON_SHOTGUN_SEMIAUTO",
--    "WEAPON_SNIPERRIFLE_ROLLINGBLOCK_EXOTIC",
--    "WEAPON_SNIPERRIFLE_ROLLINGBLOCK",
--    "WEAPON_SNIPERRIFLE_CARCANO"
--}                                        
--
---- for cleaning your gun with animation ENJOY
--RegisterNetEvent('cleaning:startcleaningshort')
--AddEventHandler('cleaning:startcleaningshort', function(cleaning)
--    while cleaning do 
--           Citizen.Wait(0) 
--        for i = 1, #weaponHash, 1 do
--            local ped = PlayerPedId()
--            local Cloth= CreateObject(GetHashKey('s_balledragcloth01x'), GetEntityCoords(PlayerPedId()), false, true, false, false, true)
--            local PropId = GetHashKey("CLOTH")
--            local actshort = GetHashKey("SHORTARM_CLEAN_ENTER")
--            local actlong = GetHashKey("LONGARM_CLEAN_ENTER")
--            local retval, weaponName = GetCurrentPedWeapon(PlayerPedId(), false, GetHashKey(weaponHash[i]), false)
--            if i <= 9 then
--                TriggerEvent("vorp_inventory:CloseInv");
--                Citizen.InvokeNative(0x72F52AA2D2B172CC,  PlayerPedId(), 1242464081, Cloth, PropId, actshort, 1, 0, -1.0)   
--                Wait(15000)
--                TriggerEvent("vorp:NotifyLeft", Language.translate[Config.lang]['word'], Language.translate[Config.lang]['notif'], "generic_textures", "tick", 5000)
--                --Citizen.InvokeNative(0xA7A57E89E965D839, weaponHash, 0.0)
--                Citizen.InvokeNative(0xA7A57E89E965D839, weaponName, 0.0)
--                cleaning = false
--            else
--                TriggerEvent("vorp_inventory:CloseInv");
--                Citizen.InvokeNative(0x72F52AA2D2B172CC,  PlayerPedId(), 1242464081, Cloth, PropId, actlong, 1, 0, -1.0)   
--                Wait(15000)
--                TriggerEvent("vorp:NotifyLeft", Language.translate[Config.lang]['word'], Language.translate[Config.lang]['notif'], "generic_textures", "tick", 5000)
--                Citizen.InvokeNative(0xA7A57E89E965D839, weaponName, 0.0)
--                cleaning = false            
--            end
--            if cleaning == false then 
--                break
--            end
--        end 
--    end
--end)
-- 
--
--RegisterCommand('weapon', function(source, args, rawCommand)
--    local retval --[[ boolean ]], weaponHash = GetCurrentPedWeapon(PlayerPedId(), false, weaponHash , false)
--    local weaponName = Citizen.InvokeNative(0x89CF5FF3D363311E, weaponHash)
--    --print("Weapon name --> "..weaponName)
--    print("Weapon hash --> "..weaponHash)
--    --print("Weappon hash --> "..GetHashKey(weaponHash))
--end)
