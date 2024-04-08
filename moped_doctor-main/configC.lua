Config = {}

Config.BlackBars = true -- should blackbars appear when doctor is patching you up?
Config.Time = 60 -- time it takes for the doctor to patch you up (in seconds)

Config.Receptionist = `CS_nbxreceptionist_01` -- Receptionits model
Config.ReceptionistScenario = `WORLD_HUMAN_SHOPKEEPER` -- Receptionits idle scenario
Config.ReceptionistLoc = vector4(2717.54, -1225.98, 50.37, 180.23)
Config.Doctor = `CS_SDDoctor_01` -- Doctor model


Config.Locales = {
    ["doctor"] = "Doctor",
    ["doctorpatching"] = "The doctor is patching you up.",
    ["youhave"] = "You have",
    ["seconds"]= "seconds left.",
	["healthy"]= "You don't need any medical help.",
    ["notenough"]= "You don't have enough money. You're missing ",
    ["occupied"]= "The doctor is already taking care of somebody else. Please wait.",
	["job"]= "The doctor is not here.. (There is already a player doctor somewhere! Go find him!)",
	["press"]= "Press ~r~E ~w~to get patched up by the doctor", -- should change E to your InteractControl if you change it
}

Config.InteractControl = 0x43F2959C -- E

Config.EnabledControls = { -- controls enabled when doctor is patching you up
	0x4BC9DABB, -- push to talk 
	0x9720FCEE, -- chat

}

Config.Notification = 'vorp' -- redemrp, vorp, gum_notify or chat. If you want to you can use your own notification system in the function below.

SendNotification = function(text) -- not really sure about any of these framework notifications so please correct these if they dont work :)
	if Config.Notification == 'redemrp' then
		TriggerEvent('redem_roleplay:Tip', text, 7500)
	elseif Config.Notification == 'vorp' then
		TriggerEvent("vorp:TipRight", text, 7500)
	elseif Config.Notification == 'gum_notify' then
		exports['gum_notify']:DisplayLeftNotification(Config.Locales.doctor, text, '', 7500)
	elseif Config.Notification == 'chat' then
	TriggerEvent('chat:addMessage', {
		color = { 255, 0, 0},
		multiline = true,
		args = {Config.Locales.doctor, text}
	})
	end
end
