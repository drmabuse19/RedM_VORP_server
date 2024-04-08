Config = {}

-- Language setting - English | Portuguese_PT | Portuguese_BR | French | German | Spanish
Lang = "English"

-- Notification display settings
Config.useNotifyRight = false -- Set to 'true' for displaying notifications on the right (standard); 'false' for left side display (modern look)

-- Item receiving settings
-- Enable or disable the chance to receive ITEMS
Config.canReceiveItems = true  -- Set to 'true' to enable, 'false' to disable item receiving
Config.receiveItem = 20        -- Threshold number; receive item if random number is below this
Config.chanceGettingItem = 30 -- Chance of getting an item, as a percentage
-- List of possible items to receive
Config.items = {
    { name = "water",              label = "Water",                amount = 1 },
    }

-- Money receiving settings
-- Enable or disable the chance to receive MONEY
Config.canReceiveMoney = true  -- Set to 'true' to enable, 'false' to disable money receiving
Config.receiveMoney = 10        -- Threshold number; receive money if random number is below this
Config.chanceGettingMoney = 20 -- Chance of getting money, as a percentage
-- List of possible money values to receive
Config.money = {0.15423,0.2532,1,0.432,0.1453,0.16432, 0.1,0.124,0.2,0.3 }

-- Gold receiving settings
-- Enable or disable the chance to receive GOLD
Config.canReceiveGold = false -- Set to 'true' to enable, 'false' to disable gold receiving
Config.receiveGold = 5        -- Threshold number; receive gold if random number is below this
Config.chanceGettingGold = 10 -- Chance of getting gold, as a percentage
-- List of possible gold values to receive
Config.gold = { 1, 2, 3 }

-- Weapons receiving settings
-- Enable or disable the chance to receive WEAPONS
Config.canReceiveWeapons = false -- Set to 'true' to enable, 'false' to disable weapon receiving
Config.receiveWeapon = 10        -- Threshold number; receive weapon if random number is below this
Config.chanceGettingWeapon = 100 -- Chance of getting a weapon, as a percentage
-- List of possible weapons to receive
Config.weapons = {
    { name = "WEAPON_REVOLVER_CATTLEMAN", label = "Cattleman Revolver" },
    { name = "WEAPON_REPEATER_CARBINE",   label = "Carbine Repeater" },
   }
