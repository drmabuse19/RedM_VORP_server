Config = {}

Config.WebhookLink = '' --insert your webhook link here if you want webhooks

Config.defaultlang = 'no'

Config.shop = {
    shoplocation = {
        allowblip = true,
        name = "Saint Denis",
        Pos = {x = 1877.96, y = -1344.97, z = 42.49},
        BlipHash = -1733535731,
        BlipName = "Saint Denis Hunter",
        BlipColor = "BLIP_MODIFIER_MP_COLOR_10",
    },
    shoplocation2 = {
        allowblip = true,
        name = "Blackwater",
        Pos = {x = -860.98, y = -1386.12, z = 43.54},
        BlipHash = -1733535731,
        BlipName = "Blackwater Hunter",
        BlipColor = "BLIP_MODIFIER_MP_COLOR_10",
    }
}

-------------------------- Level System Setup ------------------------------------
Config.LevelSystem = true       --Set this true to use the level system, false will disable it
Config.LevelIncreaseperHunt = 1 --This is how much your level will go up per completed hunt
Config.Levels = {
    {
        level = 10,         --Level you have to be at
        costreduction = 10, -- The Hunt's will cost this much less to start
        nextlevel = 20,     --This has to be the number of the next level so since the next level is 20 it has to be set to 20
    },
    {
        level = 20,
        costreduction = 20,
        nextlevel = 30,
    },
    {
        level = 30,
        costreduction = 30,
        nextlevel = 40,
    }, --Can add or remove levels by copy pasting a table and changing what you need
}

----------------------------------- Hunt Setup ------------------------------------
Config.locations = {
    {
        --gator setup
        hintcost = 50,
        location = "Saint Denis",                                     -- location of hunt, needs to be same as shoplocation name
        level = 1,                                                    -- level of trust needed
        Leganimalhealth = 500,                                        -- sets the legendary animals health amount max is 1000 I believe
        investigationspot = { x = 1718.58, y = -1001.05, z = 41.84 }, --this is where the first chest will spawn
        huntname = 'Legendary Gator',                                 --the name of the hunt in the menu(make sure these are unique no duplicates otherwise code will break)
        enemynpc = true,                                              --if you want to fight enemy npcs or not
        coordinates = { x = 2002.28, y = -1758.61, z = 41.03 },       --this is where the animal will spawn
        pedmodel = 'A_C_Alligator_02',                                -- Ped model of the animal
        CooldownTime = 30000,                                        -- Time in ms that will have to pass before anyone can hunt this animal again
        GivenItems = {                                                --this lists the items it gives you you can add more if you want
            {
                name = "legaligators",
                count = 1
            },
        },
        npcblipcoord = { x = 1885.23, y = -735.3, z = 41.96 }, --where the blip of the npcs will show
        npcschest = { x = 1880.93, y = -734.88, z = 42.53 },   --where the chest appears after you kill the npcs
        Npccoords = {                                          --npcs coords you cann add as many as you want or as little as you want
            { x = 1893.72, y = -734.27, z = 42.09 },
            { x = 1890.78, y = -741.34, z = 42.12 },
            { x = 1894.06, y = -743.03, z = 42.27 },
            { x = 1895.48, y = -752.23, z = 41.68 },
            { x = 1881.26, y = -754.46, z = 41.7 },
            { x = 1875.95, y = -755.99, z = 41.5 },
        },
        SecondaryAnimals = {
            secondaryanimals = true,          --if true it will spawn animals along with the legendary animal to help it
            animalmodel = 'A_C_Alligator_01', --this is the model of the secondary animal. Make sure this is not the same model as any legendary animals
            Animalspawns = {
                { x = 1996.61, y = -1761.09, z = 41.51 },
                { x = 1992.2,  y = -1761.04, z = 41.16 },
            },
        },
    },
    {
        --bear setup
        hintcost = 50,
        level = 0,               -- level of trust needed
        location = "Blackwater", -- location of hunt, needs to be same as shoplocation name
        Leganimalhealth = 500,   --max is 1000 I believe
        investigationspot = { x = 1197.62, y = 2034.54, z = 322.93 },
        huntname = 'Legendary Bear',
        enemynpc = true,
        coordinates = { x = 1416.96, y = 1802.72, z = 170.48 },
        pedmodel = 'MP_A_C_BEAR_01',
        CooldownTime = 7200000,
        GivenItems = {
            {
                name = "Steak",
                count = 1
            },
        },
        npcblipcoord = { x = 723.44, y = 1851.35, z = 239.16 },
        npcschest = { x = 718.31, y = 1850.45, z = 238.88 },
        Npccoords = {
            { x = 714.14, y = 1860.12, z = 239.46 },
            { x = 724.25, y = 1859.29, z = 239.77 },
            { x = 721.45, y = 1866.38, z = 239.81 },
            { x = 722.36, y = 1845.43, z = 237.87 },
        },
        SecondaryAnimals = {
            secondaryanimals = false,         --if true it will spawn animals along with the legendary animal to help it
            animalmodel = 'A_C_Alligator_01', --this is the model of the secondary animal. Make sure this is not the same model as any legendary animals
            Animalspawns = {
                { x = 1996.61, y = -1761.09, z = 41.51 },
                { x = 1992.2,  y = -1761.04, z = 41.16 },
            },
        },
    },
    {
        --wolf setup
        hintcost = 50,
        location = "Strawberry", -- location of hunt, needs to be same as shoplocation name
        level = 2,               -- level of trust needed
        Leganimalhealth = 500,   --max is 1000 I believe
        investigationspot = { x = -1726.5, y = -87.84, z = 181.28 },
        huntname = 'Legendary Wolf',
        enemynpc = true,
        coordinates = { x = -1526.75, y = 517.37, z = 102.05 },
        pedmodel = 'MP_A_C_Wolf_01',
        CooldownTime = 7200000,
        GivenItems = {
            {
                name = "legwolfs1", --this is the 2nd item it gives
                count = 1           --This is the amount of the 2nd item it gives
            },
        },
        npcblipcoord = { x = -1812.67, y = 651.78, z = 131.04 },
        npcschest = { x = -1822.0, y = 657.03, z = 131.72 },
        Npccoords = {
            { x = -1816.78, y = 647.18, z = 130.97 },
            { x = -1808.41, y = 652.65, z = 131.11 },
            { x = -1808.34, y = 660.62, z = 132.2 },
            { x = -1809.72, y = 668.07, z = 133.31 },
        },
        SecondaryAnimals = {
            secondaryanimals = false,         --if true it will spawn animals along with the legendary animal to help it
            animalmodel = 'A_C_Alligator_01', --this is the model of the secondary animal. Make sure this is not the same model as any legendary animals
            Animalspawns = {
                { x = 1996.61, y = -1761.09, z = 41.51 },
                { x = 1992.2,  y = -1761.04, z = 41.16 },
            },
        },
    },
    {
        --boar setup
        hintcost = 50,
        location = "Strawberry", -- location of hunt, needs to be same as shoplocation name
        level = 3,               -- level of trust needed
        Leganimalhealth = 500,   --max is 1000 I believe
        investigationspot = { x = 757.77, y = -842.5, z = 55.24 },
        huntname = "Legendary Boar",
        enemynpc = true,
        coordinates = { x = 1182.4, y = -96.61, z = 96.55 },
        pedmodel = 'MP_A_C_Boar_01',
        CooldownTime = 7200000,
        GivenItems = {
            {
                name = "legboars", --this is the 2nd item it gives
                count = 1          --This is the amount of the 2nd item it gives
            },
        },
        npcblipcoord = { x = 897.4, y = 255.53, z = 120.08 },
        npcschest = { x = 894.56, y = 255.83, z = 119.81 },
        Npccoords = {
            { x = 897.4,  y = 255.53, z = 120.08 },
            { x = 894.24, y = 251.26, z = 118.7 },
            { x = 898.0,  y = 249.3,  z = 119.09 },
            { x = 892.39, y = 247.5,  z = 117.96 },
        },
        SecondaryAnimals = {
            secondaryanimals = false,         --if true it will spawn animals along with the legendary animal to help it
            animalmodel = 'A_C_Alligator_01', --this is the model of the secondary animal. Make sure this is not the same model as any legendary animals
            Animalspawns = {
                { x = 1996.61, y = -1761.09, z = 41.51 },
                { x = 1992.2,  y = -1761.04, z = 41.16 },
            },
        },
    },
    {
        --fox
        hintcost = 70,
        location = "Strawberry", -- location of hunt, needs to be same as shoplocation name
        level = 4,               -- level of trust needed
        Leganimalhealth = 500,   --max is 1000 I believe
        investigationspot = { x = 1470.33, y = -1723.61, z = 61.85 },
        huntname = "Legendary Fox",
        enemynpc = false,
        coordinates = { x = 751.77, y = -971.89, z = 48.7 },
        pedmodel = 'MP_A_C_FOX_01',
        CooldownTime = 7200000,
        GivenItems = {
            {
                name = "legfoxs3", --this is the 2nd item it gives
                count = 1          --This is the amount of the 2nd item it gives
            },
        },
        npcblipcoord = { x = 897.4, y = 255.53, z = 120.08 },
        npcschest = { x = 894.56, y = 255.83, z = 119.81 },
        Npccoords = {
            { x = 897.4,  y = 255.53, z = 120.08 },
            { x = 894.24, y = 251.26, z = 118.7 },
            { x = 898.0,  y = 249.3,  z = 119.09 },
            { x = 892.39, y = 247.5,  z = 117.96 },
        },
        SecondaryAnimals = {
            secondaryanimals = false,         --if true it will spawn animals along with the legendary animal to help it
            animalmodel = 'A_C_Alligator_01', --this is the model of the secondary animal. Make sure this is not the same model as any legendary animals
            Animalspawns = {
                { x = 1996.61, y = -1761.09, z = 41.51 },
                { x = 1992.2,  y = -1761.04, z = 41.16 },
            },
        },
    }, --Too add more hunts just copy and paste one from above and change what you need
}

------------------------------------------ TRANSLATE HERE! ------------------------------------------------------
Config.Language = {
    Deadtext = 'You died, hunt failed',
    Cluefound = 'You found a clue pointing to the animals location',
    Initialblipmark = 'The last known location of the animal has been marked',
    Poachersattack = 'Watch Out Poachers are attacking!',
    Cooldownactive = 'I have nothing to offer come back later',
    Lastlocationblip = 'Last Location',
    Poachersdead = 'You killed the poachers now look around for any clues',
    Poacherschestblip = 'Poachers Chest',
    ChestPrompt = 'Search the chest',
    ClueBlip = 'Clue',
    Menuname = "Legendary Hunts",
    Hunterblip = "Hunter",
    Shoptext = 'Press "G" to see what the hunter is offering',
    LegAnimalSpawned = 'The Animal is Nearby!',
    AnimalSkinned = 'You skinned the Animal, and got its pelt!',
    Leveldisp = 'Your Current Level',
    Nolevel = 'You have not experinced enough to talk to me',
    AlreadyInMission = 'You are already doing a hunt!',
    WebhookTitle = 'Bcc Legendaries',
    WebhookDesc = 'Has Started Hunting The'
}


--[[--------BLIP_COLORS----------
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
WHITE         = 'BLIP_MODIFIER_MP_COLOR_32']]