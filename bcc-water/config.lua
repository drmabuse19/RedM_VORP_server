Config = {}

Config.defaultlang = 'en_lang'
---------------------------------------------------------------

-- Vorp Metabolism              = 1
-- Fred Metabolism Free         = 2
-- Outsider Needs               = 3
-- Fred Metabolism Paid v1.4    = 4
-- Fred Metabolism Paid v2      = 5
-- RSD Metabolism Paid          = 6
-- NXT Metabolism Paid          = 7
-- Andrade Metabolism Paid      = 8
-- FX-HUD                       = 9
Config.app = 1
---------------------------------------------------------------

Config.keys = {
    drink       = 0x760A9C6F, -- [G] Drink from Wild Waters
    wash        = 0x80F28E95, -- [L] Wash Player in Wild Waters
    fillBucket  = 0xCEFD9220, -- [E] Fill Bucket at Water Pumps and Wild Waters
    fillCanteen = 0x27D1C284, -- [R] Fill Canteen at Water Pumps and Wild Waters
}
---------------------------------------------------------------

Config.pumpsEnabled = true -- Enable the Use of Water Pumps

Config.pumpCanteen  = true -- Fill Canteen at Pumps
Config.pumpBucket   = true -- Fill Bucket at Pumps
---------------------------------------------------------------

Config.wildEnabled = true -- Enable the Use of Rivers and Lakes (Wild Waters)

Config.wildCanteen = true -- Fill Canteen in Wild Waters
Config.wildBucket  = true -- Fill Bucket in Wild Waters
Config.wildWash    = true -- Wash in Wild Waters
Config.wildDrink   = true -- Drink Directly from Wild Waters
---------------------------------------------------------------

-- Item Names from Database
Config.emptyBucket = 'wateringcan_empty'

Config.fullBucket  = 'wateringcan'

Config.canteen     = 'bottle'
---------------------------------------------------------------

-- Crouch in Wild Water to Show Prompts
Config.crouch = true -- Default: true / Set to false to Remove Crouch Requirement
---------------------------------------------------------------

Config.usePrompt = true -- true = Show Prompt Button at Water Pumps / false = Show Text at Water Pumps (no button)
---------------------------------------------------------------

Config.showMessages = true -- Show / Hide Canteen Level Messages
---------------------------------------------------------------

-- Boosts Drinking from Canteen
Config.health  = 10 -- Default: 10 / Value is 0 - 100 / Set to 0 to Disable

Config.stamina = 20 -- Default: 20 / Value is 0 - 100 / Set to 0 to Disable

Config.thirst  = 50 -- Default: 50 / Value is 0 - 100
---------------------------------------------------------------

-- Effects Drinking from Wild Waters
Config.gainHealth = true -- true = Gain Health by wildHealth Value / false = Lose by Value
Config.wildHealth  = 5  -- Default: 5 / Value is 0 - 100 / Set to 0 to Disable

Config.gainStamina = true -- true = Gain Stamina by wildStamina Value / false = Lose by Value
Config.wildStamina = 10 -- Default: 10 / Value is 0 - 100 / Set to 0 to Disable

Config.wildThirst  = 25 -- Default: 25 / Value is 0 - 100
---------------------------------------------------------------

-- Translate Canteen Metadata
Config.lang = {
    level = 'Level',
    empty = 'Empty',
    full  = 'Full'
}
---------------------------------------------------------------

Config.locations = { -- Wild Water Locations
    [1]  = { name = 'Sea of Coronado',     hash = -247856387  },
    [2]  = { name = 'San Luis River',      hash = -1504425495 },
    [3]  = { name = 'Lake Don Julio',      hash = -1369817450 },
    [4]  = { name = 'Flat Iron Lake',      hash = -1356490953 },
    [5]  = { name = 'Upper Montana River', hash = -1781130443 },
    [6]  = { name = 'Owanjila',            hash = -1300497193 },
    [7]  = { name = 'Hawks Eye Creek',     hash = -1276586360 },
    [8]  = { name = 'Little Creek River',  hash = -1410384421 },
    [9]  = { name = 'Dakota River',        hash =  370072007  },
    [10] = { name = 'Beartooth Beck',      hash =  650214731  },
    [11] = { name = 'Lake Isabella',       hash =  592454541  },
    [12] = { name = 'Cattail Pond',        hash = -804804953  },
    [13] = { name = 'Deadboot Creek',      hash =  1245451421 },
    [14] = { name = 'Spider Gorge',        hash = -218679770  },
    [15] = { name = 'O\'Creagh\'s Run',    hash = -1817904483 },
    [16] = { name = 'Moonstone Pond',      hash = -811730579  },
    [17] = { name = 'Kamassa River',       hash = -1229593481 },
    [18] = { name = 'Elysian Pool',        hash = -105598602  },
    [19] = { name = 'Heartlands Overflow', hash =  1755369577 },
    [20] = { name = 'Lagras Bayou',        hash = -557290573  },
    [21] = { name = 'Lannahechee River',   hash = -2040708515 },
    [22] = { name = 'Calmut Ravine',       hash =  231313522  },
    [23] = { name = 'Ringneck Creek',      hash =  2005774838 },
    [24] = { name = 'Stillwater Creek',    hash = -1287619521 },
    [25] = { name = 'Lower Montana River', hash = -1308233316 },
    [27] = { name = 'Aurora Basin',        hash = -196675805  },
    [28] = { name = 'Barrow Lagoon',       hash =  795414694  },
    [29] = { name = 'Arroyo De La Vibora', hash = -49694339   },
    [30] = { name = 'Bahia De La Paz',     hash = -1168459546 },
    [31] = { name = 'Dewberry Creek',      hash =  469159176  },
    [32] = { name = 'Whinyard Strait',     hash = -261541730  },
    [33] = { name = 'Cairn Lake',          hash = -1073312073 },
    [34] = { name = 'Hot Springs',         hash =  1175365009 },
    [35] = { name = 'Mattlock Pond',       hash =  301094150  },
    [36] = { name = 'Southfield Flats',    hash = -823661292  },
}
