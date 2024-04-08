Config = {}

-- Active language/locale
Config.defaultlang = "en" -- options available: pt,en,br or add them yourself.

Config.drinkAmount = 5 -- amount from fred_metabolism you will decrease thirsty

-- Keybinds
Config.Keys = {-- Examples https://github.com/mja00/redm-shit/blob/master/nuiweaponspawner/config.lua
  fill_Canteen_Button = 0x760A9C6F, --[G]
  fill_Bucket_Button  = 0xC7B5340A, --[ENTER]
  drink_Button        = 0xB2F377E8, --[F]
  wash_Button         = 0x8AAA0AD4  --[LALT]
}

Config.Features = {-- Enable or Disable Plugin Features
  EnableWash          = true, -- Options true/false
  EnableDrink         = true,
  EnableCanteen       = false,
  EnableBucket        = true
}

Config.Notifications = {
  duration            = 7,           -- The time in seconds it will be showing each notification
  position            = "TipBottom", -- available values = NotifyLeft,Tip,NotifyTo,TipRight,TipBottom,ShowTopNotification,
                                     -- ShowAdvancedRightNotification,ShowBasicTopNotification,ShowSimpleCenterText,ShowBottomRight,deadplayerNotifY,
                                     -- updatemissioNotify,warningNotify
}

Config.Anims = {--Examples here https://raw.githubusercontent.com/femga/rdr3_discoveries/master/animations/ingameanims/ingameanims_list.lua
  fill_Canteen_A        = "amb_camp@world_camp_fire_crouch_ground@male_b@base",--The main Animation value
  fill_Canteen_B        = "base",--The second Animation value
  fill_Bucket_A         = "amb_camp@world_camp_fire_crouch_ground@male_b@base",
  fill_Bucket_B         = "base",
  drink_A               = "mech_dynamic@world_player_dynamic_kneel_ground@coffee@male_a@use_idles@idle_b",
  drink_B               = "idle_d",
  wash_A                = "amb_work@prop_human_pump_water@female_b@idle_a",
  wash_B                = "idle_a",
}

--[[
  IT IS NECESSARY ADD ITEMS TO THE USABLE INTO THE METABOLISM PLUGIN BUT NOT THE 'canteen_empty' BECAUSE DONT HAS NOTHING TO DRING FROM IT
]]


--MORE TODO