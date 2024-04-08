--[[....................................]]--
--[[       Config by i3ucky#4415        ]]--
--[[            wildfired.de            ]]--
--[[....................................]]--

Config = {}

--[[ Command ]]--
Config.Command = "mdt"

--[[ Allowed Jobs ]]--
Config.Jobs = {"police","realestate","marshal","sheriff","admin"}

--[[ Offices ]]--
Config.UseOffice = true
Config.Open = { 
	['key'] = 0xD9D0E1C0, -- SPACE
	['text'] = "~e~[SPACE] ~q~um Archiv zu öffnen",
	} 
Config.Office = {
    [1] = {
        coords={-304.10, 829.9, 120.0}, -- Valentine
    },
    [2] = {
        coords={-325.81, 819.8, 118.0}, -- Valentine 2
    }
}

--[[ Notifys ]]--
Config.Notify = {  
	['1'] = "Offender changes have been saved.", 
	['2'] = "Report changes have been saved.",
	['3'] = "Report has been successfully deleted.",
	['4'] = "A new report has been submitted.",
	['5'] = "A new warrant has been created.", 
	['6'] = "Warrant has been successfully deleted.",
	['7'] = "This report cannot be found.",
	['8'] = "Note saved.",
	['9'] = "Note deleted.",
	} 