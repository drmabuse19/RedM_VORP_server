Config = {}

Config.defaultlang = 'en_lang'
-----------------------------------------------------

Config.keys = {
    station   = 0x760A9C6F, -- Default: 0x760A9C6F [G]
    fuel      = 0x5415BE48, -- Default: 0x5415BE48 [G]
    repair    = 0x73A8FD83, -- Default: 0x73A8FD83 [H]
    bridge    = 0x760A9C6F, -- Default: 0x760A9C6F [G]
    delivery  = 0x760A9C6F, -- Default: 0x760A9C6F [G]
    inventory = 0xD8F73058, -- Default: 0xD8F73058 [U]
}
-----------------------------------------------------

Config.webhookLink = '' -- Insert Webhook Link to Enable
Config.webhookTitle = 'BCC-Train' -- Insert Webhook Title
Config.webhookAvatar = '' -- Insert Webhook Avatar
-----------------------------------------------------

Config.maxTrains = 5 -- Max Number of Trains a Player may Own
-----------------------------------------------------

Config.sellPrice = 0.60 -- Default: 0.60 / Sell Price is 60% of Purchase Price
-----------------------------------------------------

Config.cruiseControl = false -- Set true to Enable Cruise Control
-----------------------------------------------------

Config.fuel = {
    item = 'bagofcoal',         -- Item Name in the Database
    itemName = 'Bag of Coal',   -- Item Display Name
}
-----------------------------------------------------

Config.condition = {
    item = 'trainoil',      -- Item Name in the Database
    itemName = 'Train Oil', -- Item Display Name
}
-----------------------------------------------------

Config.bacchusBridge = {
    enabled = true,                             -- Blow Up Bacchus Bridge!
    coords = vector3(492.01, 1774.41, 182.5),   -- Coords of Location to Place Dynamite
    item = 'dynamite',                          -- Item Name in Database
    itemAmount = 20,                             -- Number of Items Needed
    timer = 30                                  -- Time in Seconds Before Explosion
}
-----------------------------------------------------

Config.despawnDist = 300 -- Maximum Distance Conductor can be from Train Before it Despawns
-----------------------------------------------------

Config.minigame = {
    focus = true,           -- Should minigame take nui focus (required)
    cursor = false,         -- Should minigame have cursor
    maxattempts = 3,        -- How many fail attempts are allowed before game over
    type = 'bar',           -- What should the bar look like. (bar, trailing)
    userandomkey = false,   -- Should the minigame generate a random key to press?
    keytopress = 'B',       -- userandomkey must be false for this to work. Static key to press
    keycode = 66,           -- The JS keycode for the keytopress
    speed = 5,              -- How fast the orbiter grows
    strict = true           -- if true, letting the timer run out counts as a failed attempt
}
-----------------------------------------------------

-- Time in Minutes Before Player can Start Delivery After Successful Completion
Config.cooldown = {
    delivery = 90
}
-----------------------------------------------------

Config.deliveryLocations = { -- Add as Many Locations as You Want
    { -- Heartland Oil Fields
        trainCoords = vector3(482.21, 655.46, 115.67),      -- Stop Train for Delivery
        deliveryCoords = vector3(469.27, 669.22, 117.39),   -- Player Delivery Coords
        pay = 20,                                           -- Pay for Completing Mission
        outWest = false,                                    -- Set false if This is Not in the Desert/Western Part of the Map
        radius = 10                                         -- Radius from trainCoords to Stop the Train
    },
    { -- East Hanover
        trainCoords = vector3(2231.4, 657.21, 93.83),
        deliveryCoords = vector3(2226.6, 644.73, 93.33),
        pay = 30,
        outWest = false,
        radius = 10
    },
    { -- St. Denis
        trainCoords = vector3(2712.19, -1467.63, 45.75),
        deliveryCoords = vector3(2713.09, -1491.56, 45.97),
        pay = 50,
        outWest = false,
        radius = 10
    },
    { -- Armadillo
        trainCoords = vector3(-3749.8, -2635.28, -13.87),
        deliveryCoords = vector3(-3735.51, -2620.4, -13.27),
        pay = 30,
        outWest = true,
        radius = 10
    },
}
-----------------------------------------------------

Config.blipColors = {
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
