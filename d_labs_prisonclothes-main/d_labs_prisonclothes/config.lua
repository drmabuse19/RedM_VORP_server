Config = {}

Config.Debug = false		

Config.FrameWork = 'RSG' -- the logic of returning clothes / Standalone / RSG / VORP

Config.Reset = 'db' -- if the Framework is set to Standalone, a character reset command must be set (most often "db" or "Loadskin") 

Config.Item = 'prison_clothes' -- Item for use 

Config.Translation = {
	PrisonOn = 'you put on prison clothes.',
	PrisonOff = 'you took off your prison clothes.',
}

Config.Notif = {
    cross = {"scoretimer_textures", "scoretimer_generic_cross"},
    locked = {"menu_textures","stamp_locked_rank"},
    tick = {"scoretimer_textures","scoretimer_generic_tick"},
    money = {"inventory_items", "money_moneystack"},
    alert = {"menu_textures", "menu_icon_alert"},
}

-- Item for RSG

-- ["prison_clothes"] = {
-- 	['name'] = "prison_clothes",
-- 	['label'] = "Prison Clothes",
-- 	['description'] = "",
-- 	['weight'] = 0,
-- 	['useable'] = false,
-- 	['type'] = "item",
-- 	['unique'] = false,
-- 	['image'] = "prison_clothes.png",
-- 	['shouldClose'] = false,
-- 	['combinable'] = nil,
-- 	['level'] = 0,
-- },
