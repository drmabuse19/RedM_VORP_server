-----------------------------------------------------
-- Train Model Config
-----------------------------------------------------
Trains = {
    appleseed = {
        model = 'appleseed_config',     -- Model Name of the Train - DO NOT CHANGE
        label = 'Appleseed',            -- Displayed Name of this Train
        price = 150,                    -- Purchase Price for this Train
        maxSpeed = 15,                  -- Max Speed / *30 is Highest Game Allows*
        fuel = {
            enabled = true,             -- Set false to Disable Fuel Use
            maxAmount = 100,            -- Maximum Fuel Capacity
            itemAmount = 5,             -- Number of Items Needed to Fuel Train
            decreaseTime = 30,          -- Time in Seconds to Decrease Fuel Level
            decreaseAmount = 5          -- Amount of Fuel to Decrease
        },
        condition = {
            enabled = true,             -- Set false to Disable Condition Decrease
            maxAmount = 100,            -- Maximum Condition
            itemAmount = 5,             -- Number of Items Needed to Repair Train
            decreaseTime = 30,          -- Time in Seconds to Decrease Condition Level
            decreaseAmount = 5          -- Amount of Condition to Decrease
        },
        inventory = {
            enabled = true,             -- Set to false to Disable Train Inventory
            limit = 100,                -- Inventory Limit for this Train
            acceptWeapons = true,       -- Inventory can Hold Weapons
            shared = true,              -- Inventory is Shared with All Players
        },
        blip = {
            show   = true,              -- Show Blip for Train Location
            name   = 'Train',           -- Name of Blip on the Map
            sprite = -250506368,        -- Default: -250506368
            color  = 'WHITE'            -- Color of Blip
        },
    },
    bountyhunter = {
        model = 'bountyhunter_config',
        label = 'Bounty Hunter',
        price = 175,
        maxSpeed = 20,
        fuel = {
            enabled = true,
            maxAmount = 100,
            itemAmount = 5,
            decreaseTime = 30,
            decreaseAmount = 5
        },
        condition = {
            enabled = true,
            maxAmount = 100,
            itemAmount = 5,
            decreaseTime = 30,
            decreaseAmount = 5
        },
        inventory = {
            enabled = true,
            limit = 100,
            acceptWeapons = true,
            shared = true,
        },
        blip = {
            show   = true,
            name   = 'Train',
            sprite = -250506368,
            color  = 'WHITE'
        },
    },
    engine = {
        model = 'engine_config',
        label = 'Engine (No Cars)',
        price = 250,
        maxSpeed = 30,
        fuel = {
            enabled = true,
            maxAmount = 100,
            itemAmount = 5,
            decreaseTime = 30,
            decreaseAmount = 5
        },
        condition = {
            enabled = true,
            maxAmount = 100,
            itemAmount = 5,
            decreaseTime = 30,
            decreaseAmount = 5
        },
        inventory = {
            enabled = true,
            limit = 100,
            acceptWeapons = true,
            shared = true,
        },
        blip = {
            show   = true,
            name   = 'Train',
            sprite = -250506368,
            color  = 'WHITE'
        },
    },
    gunslinger3 = {
        model = 'gunslinger3_config',
        label = 'Gunslinger 3',
        price = 175,
        maxSpeed = 20,
        fuel = {
            enabled = true,
            maxAmount = 100,
            itemAmount = 5,
            decreaseTime = 30,
            decreaseAmount = 5
        },
        condition = {
            enabled = true,
            maxAmount = 100,
            itemAmount = 5,
            decreaseTime = 30,
            decreaseAmount = 5
        },
        inventory = {
            enabled = true,
            limit = 100,
            acceptWeapons = true,
            shared = true,
        },
        blip = {
            show   = true,
            name   = 'Train',
            sprite = -250506368,
            color  = 'WHITE'
        },
    },
    gunslinger4 = {
        model = 'gunslinger4_config',
        label = 'Gunslinger 4',
        price = 200,
        maxSpeed = 25,
        fuel = {
            enabled = true,
            maxAmount = 100,
            itemAmount = 5,
            decreaseTime = 30,
            decreaseAmount = 5
        },
        condition = {
            enabled = true,
            maxAmount = 100,
            itemAmount = 5,
            decreaseTime = 30,
            decreaseAmount = 5
        },
        inventory = {
            enabled = true,
            limit = 100,
            acceptWeapons = true,
            shared = true,
        },
        blip = {
            show   = true,
            name   = 'Train',
            sprite = -250506368,
            color  = 'WHITE'
        },
    },
    prisoner = {
        model = 'prisoner_escort_config',
        label = 'Prisoner Escort',
        price = 100,
        maxSpeed = 10,
        fuel = {
            enabled = true,
            maxAmount = 100,
            itemAmount = 5,
            decreaseTime = 30,
            decreaseAmount = 5
        },
        condition = {
            enabled = true,
            maxAmount = 100,
            itemAmount = 5,
            decreaseTime = 30,
            decreaseAmount = 5
        },
        inventory = {
            enabled = true,
            limit = 100,
            acceptWeapons = true,
            shared = true,
        },
        blip = {
            show   = true,
            name   = 'Train',
            sprite = -250506368,
            color  = 'WHITE'
        },
    },
    winter4 = {
        model = 'winter4_config',
        label = 'Winter 4',
        price = 150,
        maxSpeed = 15,
        fuel = {
            enabled = true,
            maxAmount = 100,
            itemAmount = 5,
            decreaseTime = 30,
            decreaseAmount = 5
        },
        condition = {
            enabled = true,
            maxAmount = 100,
            itemAmount = 5,
            decreaseTime = 30,
            decreaseAmount = 5
        },
        inventory = {
            enabled = true,
            limit = 100,
            acceptWeapons = true,
            shared = true,
        },
        blip = {
            show   = true,
            name   = 'Train',
            sprite = -250506368,
            color  = 'WHITE'
        }
    }
}