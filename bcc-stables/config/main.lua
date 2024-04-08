 Config = {}

-- Language
Config.defaultlang = 'en_lang'
-----------------------------------------------------

Config.devMode = false -- Default: false / Do Not Run on a Live Server
-----------------------------------------------------

-- Set the currency type
-- 0 = Cash Only
-- 1 = Gold Only
-- 2 = Both
Config.currencyType = 2 -- Default: 2
-----------------------------------------------------

Config.keys = {
	shop    = 0x760A9C6F, --[G] Open Stable Menu
    call    = 0x80F28E95, --[L] Call Horse at Stable
	ret     = 0x27D1C284, --[R] Return Horse at Stable
    sell    = 0x80F28E95, --[L] Sell Tamed Horse at Sell Point
    keep    = 0x27D1C284, --[R] Keep Tamed Horse at Sell Point
    trade   = 0x27D1C284, --[R] Trade Horse to Player
    drink   = 0xD8F73058, --[U] Horse Drink when in Water
    rest    = 0x620A6C5E, --[V] Horse Rest
    sleep   = 0x43CDA5B0, --[Z] Horse Sleep
    wallow  = 0x9959A6F0, --[C] Horse Wallow
    info    = 0x80F28E95, --[L] Horse Info 
    inv	    = 0x5966D52A, --[B] Open Inventory
    revive  = 0x27D1C284, --[R] Revive Horse
    weapons = 0xAC4BD4F1, --[Tab] HorseWeapons
}
-----------------------------------------------------

-- Horse Items
Config.horsebrush = 'horsebrush'
Config.horsebrushDurability = true

Config.lantern = 'oil_lantern'
Config.lanternDurability = true

Config.haycube = 'consumable_haycube'

Config.reviver = 'consumable_horse_reviver'
-----------------------------------------------------

-- Change / Translate Stables Commands
Config.commands = {
    horseRespawn = 'horseRespawn', -- Respawn Horse if Stuck or Unable to Reach
    horseSetWild = 'horseSetWild', -- Dev Mode: Make a Horse Wild
    horseWrithe  = 'horseWrithe',  -- Dev Mode: Set Horse to Writhe State
}
-----------------------------------------------------

-- Sell Price in Stable is 60% of Horse cashPrice
Config.sellPrice = 0.60 -- Default: 0.60
-----------------------------------------------------

-- Max Number of Horses per Player
Config.maxPlayerHorses  = 5  -- Default: 5
Config.maxTrainerHorses = 10 -- Default: 10
-----------------------------------------------------

-- Can Spawn Horse Anywhere with Whistle 
Config.whistleSpawn = true -- Default:true / Set to false to only Use 'Call Horse' Button at Stable to Spawn Horse
-----------------------------------------------------

-- Can Use Flee Button in Horse Menu
Config.fleeEnabled = true -- Default: true / Set to false to Return Horse at Stable Only
-----------------------------------------------------

-- Can Use when Stable is Closed
Config.closedCall   = true -- Default: true / 'Call Horse' Button at Stable
Config.closedReturn = true -- Default: true / 'Return Horse' Button at Stable
-----------------------------------------------------

-- Horse Health Level to set Writhe State (Horse Down)
Config.writheHealth = 35 -- Default: 35 / Set to 0 to Disable
-----------------------------------------------------

-- Horse Inventory
Config.useSaddlebags    = true  -- Default: true / Require Saddlebags for Inventory
Config.shareInventory   = true -- Default: false / Share with All Players
Config.allowWeapons     = true  -- Default: true / Allow Weapons
-----------------------------------------------------

-- Health and Stamina Boosts (Set to 0 to Disable Boost - Animations Still Work)
Config.boost = {
	brushHealth  = 10, -- Increase for Brushing Horse
	brushStamina = 10,
	feedHealth   = 20, -- Increase for Feeding Horse
	feedStamina  = 20,
    drinkHealth  = 20, -- Increase for Horse Drinking
	drinkStamina = 20,
}
-----------------------------------------------------

-- Horse Drinking
Config.drinkLength = 20 -- Default: 20 / Time in Seconds for Animation to Run
-----------------------------------------------------

-- Places Horse Name Above Horse When Saddle is Empty
Config.horseTag    = true -- Default: true / Set to false to disable
Config.tagDistance = 15   -- Default: 15 / Distance from Horse the Tag is Visible
-----------------------------------------------------

-- Horse Training and Taming
Config.trainerOnly = false -- Default: false / Only Trainers can Tame and Keep/Sell Wild Horses / Only Trainers can Train Horses
Config.trainerJob = {
	{ name = 'trainer', grade = 0 },
}
Config.trainingDistance = 100  -- Default:100 / Distance Traveled to Increase XP
Config.horseXpPerCheck  = 1    -- Default: 1 / XP Earned per 'trainingDistance' Achieved
Config.horseXpPerBrush  = 1    -- Default: 1 / Set to 0 to Disable / Amount of XP Earned when Brushing Horse
Config.horseXpPerFeed   = 1    -- Default: 1 / Set to 0 to Disable / Amount of XP Earned when Feeding Horse
Config.horseXpPerDrink  = 1    -- Default: 1 / Set to 0 to Disable / Amount of XP Earned When Horse Drinks
Config.showXpMessage    = true -- Default: true / Show XP Increase Message on Screen

Config.displayHorseBreed = true -- Default: true / Display Breed of Horse Player Mounted

Config.tameCost       = 25 -- Default: 25 / Cost of Registering a Tamed Horse

Config.allowSale  = true -- Default: true / Allow Player to Sell Tamed Horse
Config.sellCooldown = 15 -- Cooldown for Selling Tamed Horses in Minutes
Config.allowKeep  = true -- Default: true / Allow Player to Keep Tamed Horse
-----------------------------------------------------

Config.BlipColors = {
	LIGHT_BLUE    = 'BLIP_MODIFIER_MP_COLOR_1',
	DARK_RED      = 'BLIP_MODIFIER_MP_COLOR_2',
	PURPLE        = 'BLIP_MODIFIER_MP_COLOR_3',
	ORANGE        = 'BLIP_MODIFIER_MP_COLOR_4',
	TEAL          = 'BLIP_MODIFIER_MP_COLOR_5',
	LIGHT_YELLOW  = 'BLIP_MODIFIER_MP_COLOR_6',
	PINK          = 'BLIP_MODIFIER_MP_COLOR_7',
	GREEN         = 'BLIP_MODIFIER_MP_COLOR_8',
	DARK_TEAL     = 'BLIP_MODIFIER_MP_COLOR_9',
	RED           = 'BLIP_MODIFIER_MP_COLOR_10',
	LIGHT_GREEN   = 'BLIP_MODIFIER_MP_COLOR_11',
	TEAL2         = 'BLIP_MODIFIER_MP_COLOR_12',
	BLUE          = 'BLIP_MODIFIER_MP_COLOR_13',
	DARK_PUPLE    = 'BLIP_MODIFIER_MP_COLOR_14',
	DARK_PINK     = 'BLIP_MODIFIER_MP_COLOR_15',
	DARK_DARK_RED = 'BLIP_MODIFIER_MP_COLOR_16',
	GRAY          = 'BLIP_MODIFIER_MP_COLOR_17',
	PINKISH       = 'BLIP_MODIFIER_MP_COLOR_18',
	YELLOW_GREEN  = 'BLIP_MODIFIER_MP_COLOR_19',
	DARK_GREEN    = 'BLIP_MODIFIER_MP_COLOR_20',
	BRIGHT_BLUE   = 'BLIP_MODIFIER_MP_COLOR_21',
	BRIGHT_PURPLE = 'BLIP_MODIFIER_MP_COLOR_22',
	YELLOW_ORANGE = 'BLIP_MODIFIER_MP_COLOR_23',
	BLUE2         = 'BLIP_MODIFIER_MP_COLOR_24',
	TEAL3         = 'BLIP_MODIFIER_MP_COLOR_25',
	TAN           = 'BLIP_MODIFIER_MP_COLOR_26',
	OFF_WHITE     = 'BLIP_MODIFIER_MP_COLOR_27',
	LIGHT_YELLOW2 = 'BLIP_MODIFIER_MP_COLOR_28',
	LIGHT_PINK    = 'BLIP_MODIFIER_MP_COLOR_29',
	LIGHT_RED     = 'BLIP_MODIFIER_MP_COLOR_30',
	LIGHT_YELLOW3 = 'BLIP_MODIFIER_MP_COLOR_31',
	WHITE         = 'BLIP_MODIFIER_MP_COLOR_32'
}
