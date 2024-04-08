local VORPcore = exports.vorp_core:GetCore()

local T = Translation.Langs[Config.Lang]

local fishEntity = {
    [`A_C_FISHBLUEGIL_01_MS`]        = "a_c_fishbluegil_01_ms",
    [`A_C_FISHBLUEGIL_01_SM`]        = "a_c_fishbluegil_01_sm",
    [`A_C_FISHBULLHEADCAT_01_MS`]    = "a_c_fishbullheadcat_01_ms",
    [`A_C_FISHBULLHEADCAT_01_SM`]    = "a_c_fishbullheadcat_01_sm",
    [`A_C_FISHCHAINPICKEREL_01_MS`]  = "a_c_fishchainpickerel_01_ms",
    [`A_C_FISHCHAINPICKEREL_01_SM`]  = "a_c_fishchainpickerel_01_sm",
    [`A_C_FISHCHANNELCATFISH_01_LG`] = "a_c_fishchannelcatfish_01_lg",
    [`A_C_FISHCHANNELCATFISH_01_XL`] = "a_c_fishchannelcatfish_01_xl",
    [`A_C_FISHLAKESTURGEON_01_LG`]   = "a_c_fishlakesturgeon_01_lg",
    [`A_C_FISHLARGEMOUTHBASS_01_LG`] = "a_c_fishlargemouthbass_01_lg",
    [`A_C_FISHLARGEMOUTHBASS_01_MS`] = "a_c_fishlargemouthbass_01_ms",
    [`A_C_FISHLONGNOSEGAR_01_LG`]    = "a_c_fishlongnosegar_01_lg",
    [`A_C_FISHMUSKIE_01_LG`]         = "a_c_fishmuskie_01_lg",
    [`A_C_FISHNORTHERNPIKE_01_LG`]   = "a_c_fishnorthernpike_01_lg",
    [`A_C_FISHPERCH_01_MS`]          = "a_c_fishperch_01_ms",
    [`A_C_FISHPERCH_01_SM`]          = "a_c_fishperch_01_sm",
    [`A_C_FISHRAINBOWTROUT_01_LG`]   = "a_c_fishrainbowtrout_01_lg",
    [`A_C_FISHRAINBOWTROUT_01_MS`]   = "a_c_fishrainbowtrout_01_ms",
    [`A_C_FISHREDFINPICKEREL_01_MS`] = "a_c_fishredfinpickerel_01_ms",
    [`A_C_FISHREDFINPICKEREL_01_SM`] = "a_c_fishredfinpickerel_01_sm",
    [`A_C_FISHROCKBASS_01_MS`]       = "a_c_fishrockbass_01_ms",
    [`A_C_FISHROCKBASS_01_SM`]       = "a_c_fishrockbass_01_sm",
    [`A_C_FISHSALMONSOCKEYE_01_LG`]  = "a_c_fishsalmonsockeye_01_lg",
    [`A_C_FISHSALMONSOCKEYE_01_ML`]  = "a_c_fishsalmonsockeye_01_ml",
    [`A_C_FISHSALMONSOCKEYE_01_MS`]  = "a_c_fishsalmonsockeye_01_ms",
    [`A_C_FISHSMALLMOUTHBASS_01_LG`] = "a_c_fishsmallmouthbass_01_lg",
    [`A_C_FISHSMALLMOUTHBASS_01_MS`] = "a_c_fishsmallmouthbass_01_ms",
}

local fishNames = {
    [`A_C_FISHBLUEGIL_01_MS`]        = FishData.A_C_FISHBLUEGIL_01_MS[1],
    [`A_C_FISHBLUEGIL_01_SM`]        = FishData.A_C_FISHBLUEGIL_01_SM[1],
    [`A_C_FISHBULLHEADCAT_01_MS`]    = FishData.A_C_FISHBULLHEADCAT_01_MS[1],
    [`A_C_FISHBULLHEADCAT_01_SM`]    = FishData.A_C_FISHBULLHEADCAT_01_SM[1],
    [`A_C_FISHCHAINPICKEREL_01_MS`]  = FishData.A_C_FISHCHAINPICKEREL_01_MS[1],
    [`A_C_FISHCHAINPICKEREL_01_SM`]  = FishData.A_C_FISHCHAINPICKEREL_01_SM[1],
    [`A_C_FISHCHANNELCATFISH_01_LG`] = FishData.A_C_FISHCHANNELCATFISH_01_LG[1],
    [`A_C_FISHCHANNELCATFISH_01_XL`] = FishData.A_C_FISHCHANNELCATFISH_01_XL[1],
    [`A_C_FISHLAKESTURGEON_01_LG`]   = FishData.A_C_FISHLAKESTURGEON_01_LG[1],
    [`A_C_FISHLARGEMOUTHBASS_01_LG`] = FishData.A_C_FISHLARGEMOUTHBASS_01_LG[1],
    [`A_C_FISHLARGEMOUTHBASS_01_MS`] = FishData.A_C_FISHLARGEMOUTHBASS_01_MS[1],
    [`A_C_FISHLONGNOSEGAR_01_LG`]    = FishData.A_C_FISHLONGNOSEGAR_01_LG[1],
    [`A_C_FISHMUSKIE_01_LG`]         = FishData.A_C_FISHMUSKIE_01_LG[1],
    [`A_C_FISHNORTHERNPIKE_01_LG`]   = FishData.A_C_FISHNORTHERNPIKE_01_LG[1],
    [`A_C_FISHPERCH_01_MS`]          = FishData.A_C_FISHPERCH_01_MS[1],
    [`A_C_FISHPERCH_01_SM`]          = FishData.A_C_FISHPERCH_01_SM[1],
    [`A_C_FISHRAINBOWTROUT_01_LG`]   = FishData.A_C_FISHRAINBOWTROUT_01_LG[1],
    [`A_C_FISHRAINBOWTROUT_01_MS`]   = FishData.A_C_FISHRAINBOWTROUT_01_MS[1],
    [`A_C_FISHREDFINPICKEREL_01_MS`] = FishData.A_C_FISHREDFINPICKEREL_01_MS[1],
    [`A_C_FISHREDFINPICKEREL_01_SM`] = FishData.A_C_FISHREDFINPICKEREL_01_SM[1],
    [`A_C_FISHROCKBASS_01_MS`]       = FishData.A_C_FISHROCKBASS_01_MS[1],
    [`A_C_FISHROCKBASS_01_SM`]       = FishData.A_C_FISHROCKBASS_01_SM[1],
    [`A_C_FISHSALMONSOCKEYE_01_LG`]  = FishData.A_C_FISHSALMONSOCKEYE_01_LG[1],
    [`A_C_FISHSALMONSOCKEYE_01_ML`]  = FishData.A_C_FISHSALMONSOCKEYE_01_ML[1],
    [`A_C_FISHSALMONSOCKEYE_01_MS`]  = FishData.A_C_FISHSALMONSOCKEYE_01_MS[1],
    [`A_C_FISHSMALLMOUTHBASS_01_LG`] = FishData.A_C_FISHSMALLMOUTHBASS_01_LG[1],
    [`A_C_FISHSMALLMOUTHBASS_01_MS`] = FishData.A_C_FISHSMALLMOUTHBASS_01_MS[1],
}

local fishTextures = {
    [`A_C_FISHBLUEGIL_01_MS`]        = FishData.A_C_FISHBLUEGIL_01_MS[2],
    [`A_C_FISHBLUEGIL_01_SM`]        = FishData.A_C_FISHBLUEGIL_01_SM[2],
    [`A_C_FISHBULLHEADCAT_01_MS`]    = FishData.A_C_FISHBULLHEADCAT_01_MS[2],
    [`A_C_FISHBULLHEADCAT_01_SM`]    = FishData.A_C_FISHBULLHEADCAT_01_SM[2],
    [`A_C_FISHCHAINPICKEREL_01_MS`]  = FishData.A_C_FISHCHAINPICKEREL_01_MS[2],
    [`A_C_FISHCHAINPICKEREL_01_SM`]  = FishData.A_C_FISHCHAINPICKEREL_01_SM[2],
    [`A_C_FISHCHANNELCATFISH_01_LG`] = FishData.A_C_FISHCHANNELCATFISH_01_LG[2],
    [`A_C_FISHCHANNELCATFISH_01_XL`] = FishData.A_C_FISHCHANNELCATFISH_01_XL[2],
    [`A_C_FISHLAKESTURGEON_01_LG`]   = FishData.A_C_FISHLAKESTURGEON_01_LG[2],
    [`A_C_FISHLARGEMOUTHBASS_01_LG`] = FishData.A_C_FISHLARGEMOUTHBASS_01_LG[2],
    [`A_C_FISHLARGEMOUTHBASS_01_MS`] = FishData.A_C_FISHLARGEMOUTHBASS_01_MS[2],
    [`A_C_FISHLONGNOSEGAR_01_LG`]    = FishData.A_C_FISHLONGNOSEGAR_01_LG[2],
    [`A_C_FISHMUSKIE_01_LG`]         = FishData.A_C_FISHMUSKIE_01_LG[2],
    [`A_C_FISHNORTHERNPIKE_01_LG`]   = FishData.A_C_FISHNORTHERNPIKE_01_LG[2],
    [`A_C_FISHPERCH_01_MS`]          = FishData.A_C_FISHPERCH_01_MS[2],
    [`A_C_FISHPERCH_01_SM`]          = FishData.A_C_FISHPERCH_01_SM[2],
    [`A_C_FISHRAINBOWTROUT_01_LG`]   = FishData.A_C_FISHRAINBOWTROUT_01_LG[2],
    [`A_C_FISHRAINBOWTROUT_01_MS`]   = FishData.A_C_FISHRAINBOWTROUT_01_MS[2],
    [`A_C_FISHREDFINPICKEREL_01_MS`] = FishData.A_C_FISHREDFINPICKEREL_01_MS[2],
    [`A_C_FISHREDFINPICKEREL_01_SM`] = FishData.A_C_FISHREDFINPICKEREL_01_SM[2],
    [`A_C_FISHROCKBASS_01_MS`]       = FishData.A_C_FISHROCKBASS_01_MS[2],
    [`A_C_FISHROCKBASS_01_SM`]       = FishData.A_C_FISHROCKBASS_01_SM[2],
    [`A_C_FISHSALMONSOCKEYE_01_LG`]  = FishData.A_C_FISHSALMONSOCKEYE_01_LG[2],
    [`A_C_FISHSALMONSOCKEYE_01_ML`]  = FishData.A_C_FISHSALMONSOCKEYE_01_ML[2],
    [`A_C_FISHSALMONSOCKEYE_01_MS`]  = FishData.A_C_FISHSALMONSOCKEYE_01_MS[2],
    [`A_C_FISHSMALLMOUTHBASS_01_LG`] = FishData.A_C_FISHSMALLMOUTHBASS_01_LG[2],
    [`A_C_FISHSMALLMOUTHBASS_01_MS`] = FishData.A_C_FISHSMALLMOUTHBASS_01_MS[2],
}

Citizen.CreateThread(function()
    Citizen.Wait(2000)
    for index, item in pairs(Baits) do
        exports.vorp_inventory:registerUsableItem(item, function(data)
            local UsableBait = item

            exports.vorp_inventory:subItem(data.source, UsableBait, 1)
            TriggerClientEvent("vorp_fishing:UseBait", data.source, UsableBait)
            exports.vorp_inventory:closeInventory(data.source)
        end)
    end
end)

RegisterServerEvent('vorp_fishing:FishToInventory')
AddEventHandler("vorp_fishing:FishToInventory", function(fishModel)
    local _source = source
    local fish = fishEntity[fishModel]
    local fish_name = fishNames[fishModel]
    local fish_texture = fishTextures[fishModel]

    exports.vorp_inventory:addItem(_source, fish, 1)
    VORPcore.NotifyAvanced(_source, T.YourGot .. " " .. fish_name, "inventory_items", fish_texture, "COLOR_PURE_WHITE", 4000)
end)

RegisterServerEvent('vorp_fishing:discord')
AddEventHandler("vorp_fishing:discord", function(fishModel, fishWeight, status)
    local _source = source
    local Character = VORPcore.getUser(_source).getUsedCharacter

    local fish = fishEntity[fishModel]
    local fish_name = fishNames[fishModel]
    local fish_weight = string.format("%.2f%%", (fishWeight * 54.25))
    local webhook = Config.DiscordWebHook
    local botname = Config.DiscordBotName
    local avatar = Config.DiscordAvatar
    local footerlogo = Config.DiscordFooterLogo
    local color = 4777493
    local CharName = ""
    local _description = ""

    if Character ~= nil then
        if Character.lastname ~= nil then
            CharName = Character.firstname .. ' ' .. Character.lastname
        else
            CharName = Character.firstname
        end
    end

    if status == "keep" then
        _description = T.discord_fishKept
    elseif status == "throw" then
        _description = T.discord_fishThrow
    end

    local title = CharName .. " " .. T.discord_fishCaught
    local description = _description .. "\n" .. T.discord_fieldFishName .. ": " .. fish_name .. "\n" .. T.discord_fieldFishWeight .. ": " .. fish_weight .. "Kg"

    VORPcore.AddWebhook(title, webhook, description, color, botname, footerlogo, avatar)
end)
