Trainers = {
    valentine = {
        shop = {
            prompt = 'Valentine Trainer',               -- Text Below the Prompt Button
            distance = 3.0,                             -- Distance Between Player and Shop to Show Prompts
        },
        blip = {
            show = true,                                -- Show Blip On Map
            name = 'Valentine Trainer',                 -- Name of Blip on Map
            sprite = -1103135225,
            color = 'WHITE',                            -- See Blip Colors in config/main.lua
        },
        npc = {
            active = true,                              -- Turns NPC On / Off
            model = 'MP_LM_STEALHORSE_BUYERS_01',       -- Model Used for NPC
            coords = vector3(-359.5, 774.31, 116.39),   -- NPC and Shop Blip Positions
            heading = 356.94,                           -- NPC Heading
            distance = 100.0,                           -- Distance Between Player and Shop for NPC to Spawn
        }
    },
    -----------------------------------------------------

    tumbleweed = {
        shop = {
            prompt = 'Tumbleweed Trainer',
            distance = 3.0,
        },
        blip = {
            show = true,
            name = 'Tumbleweed Trainer',
            sprite = -1103135225,
            color = 'WHITE',
        },
        npc = {
            active = true,
            model = 'MP_LM_STEALHORSE_BUYERS_01',
            coords = vector3(-5541.06, -3049.58, -1.18),
            heading = 345.45,
            distance = 100.0,
        }
    },
    -----------------------------------------------------

    vanhorn = {
        shop = {
            prompt = 'Van Horn Trainer',
            distance = 3.0,
        },
        blip = {
            show = true,
            name = 'Van Horn Trainer',
            sprite = -1103135225,
            color = 'WHITE',
        },
        npc = {
            active = true,
            model = 'MP_LM_STEALHORSE_BUYERS_01',
            coords = vector3(2960.46, 790.94, 51.4),
            heading = 80.85,
            distance = 100.0,
        }
    },
    -----------------------------------------------------
}