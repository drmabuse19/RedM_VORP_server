---------- Pulling Essentials -------------
local VORPcore = {} --Pulls vorp core
TriggerEvent("getCore", function(core)
  VORPcore = core
end)
local VORPInv = {}
VORPInv = exports.vorp_inventory:vorp_inventoryApi()
local BccUtils = exports['bcc-utils'].initiate()

local discord = BccUtils.Discord.setup(Config.Webhook, 'BCC-Robbery','https://cdn.discordapp.com/attachments/1215063804296306758/1217571513713037312/webhooks.256x228.png?ex=660482d6&is=65f20dd6&hm=4484c2bdde6de17680f53cf6999147f1477694c788fb81b19e77e6add140fb79&')

-------- Job Alert Setup -----
local police_alert = exports['bcc-job-alerts']:RegisterAlert({
    name = 'banker', --The name of the alert
    command = nil, -- the command, this is what players will use with /
    message = Config.PoliceAlert.AlertMssg, -- Message to show to theh police
    messageTime = Config.PoliceAlert.ShowMssgTime, -- Time the message will stay on screen (miliseconds)
    job = Config.PoliceAlert.Job, -- Job the alert is for
    jobgrade = { 0, 1, 2, 3, 4, 5 }, -- What grades the alert will effect
    icon = "star", -- The icon the alert will use
    hash = -1282792512, -- The radius blip
    radius = 40.0, -- The size of the radius blip
    blipTime = Config.PoliceAlert.BlipTime, -- How long the blip will stay for the job (miliseconds)
    blipDelay = 5000, -- Delay time before the job is notified (miliseconds)
    originText = "", -- Text displayed to the user who enacted the command
    originTime = 0 --The time the origintext displays (miliseconds)
})

------------- Cooldown Handler thanks to Byte ----------------
local cooldowns = {}
RegisterServerEvent('bcc-robbery:ServerCooldownCheck', function(shopid, v)
    local _source = source
    if cooldowns[shopid] then --Check if the robery has a cooldown registered yet.
        local seconds = Config.RobberyCooldown
        if os.difftime(os.time(), cooldowns[shopid]) >= seconds then -- Checks the current time difference from the stored enacted time, then checks if that difference us past the seconds threshold
            cooldowns[shopid] = os.time() --Update the cooldown with the new enacted time.
            TriggerClientEvent("bcc-robbery:RobberyHandler", _source, v) --Robbery is not on cooldown
            police_alert:SendAlert(_source)
        else --robbery is on cooldown
            VORPcore.NotifyRightTip(_source, _U('OnCooldown'), 4000)
        end
    else
        cooldowns[shopid] = os.time() --Store the current time
        TriggerClientEvent("bcc-robbery:RobberyHandler", _source, v) --Robbery is not on cooldown
        police_alert:SendAlert(_source)
    end
end)

--------- Event to handle pay outs ----------
RegisterServerEvent('bcc-robbery:CashPayout', function(amount)
    local Character = VORPcore.getUser(source).getUsedCharacter --checks the char used
    Character.addCurrency(0, amount)
    VORPcore.NotifyRightTip(source,_U('youTook')..amount.."$", 5000)
    -- Discord notification
    discord:sendMessage("Name: " .. Character.firstname .. " " .. Character.lastname .. "\nIdentifier: " .. Character.identifier .. "\nReward: " .. amount)
end)

RegisterServerEvent('bcc-robbery:ItemsPayout', function(table)
    local Character = VORPcore.getUser(source).getUsedCharacter
    for k, v in pairs(table.ItemRewards) do
        VORPInv.addItem(source, v.name, v.count)
        VORPcore.NotifyRightTip(source,_U('youTook')..v.name.." "..v.count, 5000)
        --Discord notification
        discord:sendMessage("Name: " .. Character.firstname .. " " .. Character.lastname .. "\nIdentifier: " .. Character.identifier .. "\nReward: " .. v.count.." "..v.name)
	end
end)

-------- Job Restrictor Check -------
RegisterServerEvent('bcc-robbery:JobCheck', function()
    local Character = VORPcore.getUser(source).getUsedCharacter --checks the char used
    local job = false
    for k, v in pairs(Config.NoRobberyJobs) do
        if v.jobname == Character.job then
            job = true
        end
    end
    if not job then
        TriggerClientEvent('bcc-robbery:RobberyEnabler', source)
    else
        VORPcore.NotifyRightTip(source, _U('WrongJob'), 4000)
    end
end)

BccUtils.Versioner.checkRelease(GetCurrentResourceName(), 'https://github.com/BryceCanyonCounty/bcc-robbery')