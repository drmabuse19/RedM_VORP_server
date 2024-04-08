Config = {}

Config.defaultlang = "en_lang"
Config.DevMode = true -- enable this if you want to make testes, dont leave true in live servers
Config.Webhook = '' -- WEBHOOK VORPCORE

-- Crafting Key
Config.Keys = {
    G = 0x760A9C6F
}

-- Options: s, m, l
Config.Styles = {
    fontSize = 'm',
    descriptionsidebar = true
}

Config.Commands = {
    campfire = true,
    extinguish = true
}

-- distance to interact with Locations and campfires
Config.Distances = {
    campfire = 1.5,
    locations = 2.5
}

-- Craftable Locations
--EXAMPLE: 
-- {
--     name = 'Blackwater Crafting Express',
--     id = 'blackwater',
--     Job = { 'butcher' }, -- set to 0 to allow any jobs, or like { "butcher" } to job restriction
--     x = -872.222, 
--     y = -1390.924, 
--     z = 43.573
-- }
Config.Locations = {
    {
        name = 'Blackwater Crafting Station',
        id = 'blackwater',
        Job = 0, -- set to 0 to allow any jobs, or like { "butcher" } to job restriction
        x = -872.222, 
        y = -1390.924, 
        z = 43.573,
        Blip = {
            enable = true,
            Hash = 1754365229
        },
        Categories = 0, -- set to 0 to allow all categories or like {"food"} to restrict
    }
}

Config.PlaceableCampfire = "p_campfire05x"

-- Restrict campfire usage to specific roles or set to 0 to allow any role
-- Example: { "butcher" }
-- set to 0 to allow any jobs, or like { "butcher" } to job restriction
Config.CampfireJobLock = 0

-- Disables/Enables the kneeling animation when crafting
Config.KneelingAnimation = true

-- Crafting Prop Location is resource intensive, turn this to false if you want to use less resources.
-- Disables/Enables Crafting Props
Config.CraftingPropsEnabled = true

-- Props for the player to craft at
-- List of porps you can use for crafting
-- "P_CAMPFIRECOMBINED01X","p_campfirefresh01x","p_fireplacelogs01x","p_woodstove01x","p_stove04x","p_campfire04x","p_campfire05x","p_campfire02x","p_campfirecombined02x","p_campfirecombined03x","p_kettle03x","p_campfirecombined04x", "P_CAMPFIRECOOK02X","P_CAMPFIRE_WIN2_01X","P_CRAFTINGPOT01X"
Config.CraftingProps = {
    {
        title = "Campfire",
        prop = "p_campfire05x"
    }}
-- How long the progressbar will show when crafting
Config.CraftTime = 15000

-- Craftable item categories. ident and Config.crafting.Category must equal eachother.
--EXAMPLE: 
-- {
--     ident = 'food', 
--     text = 'Craft Food',
--     Location = { 'campfire' }, -- set to 0 to allow any locations from Config.Locations
--     Job = { 'butcher' } -- set to 0 to allow any jobs, or like { "butcher" } to job restriction
-- },
Config.Categories = {
    {
        ident = 'food', 
        text = 'Matretter',
        Location = 0,
        Job = 0
    },
 {
        ident = 'ingredient', 
        text = 'Råvarer',
        Location = 0,
        Job = 0
    },

 {
        ident = 'tent', 
        text = 'Telt',
        Location = 0,
        Job =  {"snekker"}
    },

    {
        ident = 'items',
        text = 'Utstyr',
        Location = 0,
        Job = {"snekker"}
    },
    {
        ident = 'weapons',
        text = 'Våpen',
        Location = 0,
        Job = {"smed"}
    },
    {
        ident = 'meleeweapons',
        text = 'Håndhåpen',
        Location = 0,
        Job = 0
    },
}

-- Craftable Items/Rewards And their Recipes
--EXAMPLE: 
-- {
--     Text = "Meat Bfast ",
--     SubText = "InvMax = 10",
--     Desc = "Recipe: 1x Meat, 1x Salt",
--     Items = {
--         {
--             name = "meat",
--             count = 1
--         },
--         {
--             name = "salt",
--             count = 1
--         }
--     },
--     Reward = {
--         {
--             name = "consumable_breakfast", -- if you use the currency mode, you don't need a name section inside the reward section
--             count = 1
--         }
--     },
--     Job = { 'butcher' }, -- set to 0 to allow any jobs, or like { "butcher" } to job restriction
--     Location = { 'blackwater' }, -- set to 0 to allow any locations from Config.Locations, or like { "butcher" } to job restriction
--     UseCurrencyMode = false, -- true if you want to use the currency mode otherwise set this to false
--     CurrencyType = 0, -- 0 => money, 1 => gold
--     Category = "food",
--     Animation = 'knifecooking' -- set what animation should play when crafting (if this is not set it has a default animation). Animations can be found below in Config.Animations
-- }
Config.Crafting = {
    {
        Text = "Stekt kjøtt ",
        SubText = "InvMax = 10",
        Desc = "Recipe: 1x Meat, 1x Salt",
        Items = {
            {
                name = "meat",
                count = 1,
                take = true -- This determines if recipe items will be taken from inventory after crafting. If ommited, it will default to true.
            },
            {
                name = "salt",
                count = 1,
                take = false -- This determines if recipe items will be taken from inventory after crafting. If ommited, it will default to true.
            }
        },
        Reward = {
            {
                name = "consumable_breakfast",
                count = 1
            }
        },
        Type = "item", -- indicate if it is 'weapon' or 'item'
        Job = 0, -- set to 0 to allow any jobs, or like { "butcher" } to job restriction
        Location = 0, -- set to 0 to allow any locations from Config.Locations, or like { "butcher" } to job restriction
        UseCurrencyMode = false,
        CurrencyType = 0, -- 0 = money, 1 = gold
        Category = "food",
        Animation = 'knifecooking',
        TakeItems = true -- This determines if recipe items will be taken from inventory after crafting. If ommited, it will default to true.
    },  {
        Text = "Mel",
        SubText = "InvMax = 10",
        Desc = "Recipe: 1x Hvete",
        Items = {
            {
                name = "wheat",
                count = 1,
                take = true -- This determines if recipe items will be taken from inventory after crafting. If ommited, it will default to true.
            }        },
        Reward = {
            {
                name = "flour",
                count = 2
            }
        },
        Type = "item", -- indicate if it is 'weapon' or 'item'
        Job = 0, -- set to 0 to allow any jobs, or like { "butcher" } to job restriction
        Location = 0, -- set to 0 to allow any locations from Config.Locations, or like { "butcher" } to job restriction
        UseCurrencyMode = false,
        CurrencyType = 0, -- 0 = money, 1 = gold
        Category = "ingredient",
        Animation = 'craft',
        TakeItems = true -- This determines if recipe items will be taken from inventory after crafting. If ommited, it will default to true.
    },
    {
        Text = "Tørka kjøtt ",
        SubText = "InvMax = 10",
        Desc = "Recipe: 1 x SGM, 1 x Salt",
        Items = {
            {
                name = "consumable_game",
                count = 1
            },
            {
                name = "salt",
                count = 1
            }
        },
        Reward ={
            {
                name = "cookedsmallgame",
                count = 2
            }
        },
        Type = "item", -- indicate if it is 'weapon' or 'item'
        Job = 0,
        Location = 0,
        UseCurrencyMode = false,
        CurrencyType = 0,
        Category = "food",
        Animation = 'knifecooking'
    }, 
    {
        Text = "Eplekake ",
        SubText = "InvMax = 10",
        Desc = "Recipe: 10x Apple, 1x Water, 15x Sugar, 5x Egg, 15x Flour",
        Items = {
            {
                name = "apple",
                count = 10
            },
            {
                name = "water",
                count = 1
            },
            {
                name = "sugar",
                count = 15
            },
            {
                name = "flour",
                count = 15
            },
            {
                name = "eggs",
                count = 5
            }
        },
        Reward = {
            {
                name = "consumable_applepie",
                count = 1
            }
        },
        Type = "item", -- indicate if it is 'weapon' or 'item'
        Job = 0,
        Location = 0,
        UseCurrencyMode = false,
        CurrencyType = 0,
        Category = "food"

    },
    {
        Text = "Biff ",
        SubText = "InvMax = 10",
        Desc = "Recipe: 1x Meat",
        Items = {
            {
                name = "meat",
                count = 1
            }
        },
        Reward = {
            {
                name = "steak",
                count = 1
            }
        },
        Type = "item",
        Job = 0,
        Location = 0, -- set to 0 to allow any locations from Config.Locations, or like { "butcher" } to job restriction
        UseCurrencyMode = false,
        CurrencyType = 0,
        Category = "food",
        Animation = 'spindlecook'
    },
    {
        Text = "Frokost ",
        SubText = "InvMax = 5",
        Desc = "Recipe: 5x Pork, 2x Eggs",
        Items = {
            {
                name = "Pork",
                count = 5
            },
            {
                name = "eggs",
                count = 2
            }
        }, 
        Reward = {
            {
                name = "consumable_breakfast",
                count = 1
            }
        },
        Type = "item",
        Job = 0,
        Location = 0, -- set to 0 to allow any locations from Config.Locations, or like { "butcher" } to job restriction
        UseCurrencyMode = false,
        CurrencyType = 0,
        Category = "food"
    },
    {
        Text = "Blåbærpai",
        SubText = "InvMax = 10",
        Desc = "Recipe: 6x BlueBerry, 1 x Water, 1x Sugar, 1x Egg, 1x Flour",
        Items = {
            {
                name = "blueberry",
                count = 39
            },
            {
                name = "water",
                count = 2
            },
            {
                name = "sugar",
                count = 6
            },
            {
                name = "eggs",
                count = 4
            },
            {
                name = "flour",
                count = 10
            }
        }, 
        Reward = {
            {
                name = "consumable_blueberrypie",
                count = 1
            }
        },
        Type = "item",
        Job = 0,
        Location = 0, -- set to 0 to allow any locations from Config.Locations, or like { "butcher" } to job restriction
        UseCurrencyMode = false,
        CurrencyType = 0,
        Category = "food"
    },
    {
        Text = "Stekt Svin",
        SubText = "InvMax = 10 ",
        Desc = "Recipe: 1x Pork, 1x Salt",
        Items = {
            {
                name = "Pork",
                count = 1
            },
            {
                name = "salt",
                count = 1
            }
        },
        Reward ={
            {
                name = "knifecooking",
                count = 1
            }
        },
        Type = "item", -- indicate if it is 'weapon' or 'item'
        Job = 0,
        Location = 0,
        UseCurrencyMode = false,
        CurrencyType = 0,
        Category = "food",
        Animation = 'spindlecook'
    },
    {
        Text = "T-ben stek",
        SubText = "InvMax = 10",
        Desc = "Recipe 1x Big Game Meat, 1x Salt",
        Items = {
            {
                name = "BigGameMeat",
                count = 1
            },
            {
                name = "salt",
                count = 1
            }
        },
        Reward = {
            {
                name = "SaltedCookedBigGameMeat",
                count = 1
            }
        },
        Type = "item", -- indicate if it is 'weapon' or 'item'
        Job = 0,
        Location = 0,
        UseCurrencyMode = false,
        CurrencyType = 0,
        Category = "food",
        Animation = 'spindlecook'
    },
    {
        Text = "Stekt indrefillet",
        SubText = "InvMax = 10",
        Desc = "Recipe: 1x Big Game Meat",
        Items = {
            {
                name = "BigGameMeat",
                count = 1
            }
        },
        Reward = {
            {
                name = "CookedBigGameMeat",
                count = 1
            }
        },
        Type = "item", -- indicate if it is 'weapon' or 'item'
        Job = 0,
        Location = 0,
        UseCurrencyMode = false,
        CurrencyType = 0,
        Category = "food",
        Animation = 'spindlecook'
    },
    {
        Text = "PorkChop ",
        SubText = "InvMax = 10",
        Desc = "Recipe: 1x Pork",
        Items = {
            {
                name = "Pork",
                count = 1
            }
        },
        Reward = {
            {
                name = "cookedpork",
                count = 1
            }
        },
        Type = "item", -- indicate if it is 'weapon' or 'item'
        Job = 0,
        Location = 0,
        UseCurrencyMode = false,
        CurrencyType = 0,
        Category = "food",
        Animation = 'knifecooking'
    },
    {
        Text = "Hakke ",
        SubText = "InvMax = 5",
        Desc = "Recipe: 150x Iron, 50x Wood",
        Items = {
            {
                name = "iron",
                count = 150
            },
            {
                name = "wood",
                count = 50
            }
        },
        Reward = {
            {
                name = "pickaxe",
                count = 1
            }
        },
        Type = "weapon", -- indicate if it is 'weapon' or 'item'
        Job = 0,
        Location = 0,
        UseCurrencyMode = false,
        CurrencyType = 0,
        Category = "items"
    },
    {
        Text = "Øks ",
        SubText = "InvMax = 5",
        Desc = "Recipe: 140x Iron, 80x Wood",
        Items = {
            {
                name = "iron",
                count = 140
            },
            {
                name = "wood",
                count = 80
            }
        },
        Reward ={
            {
                name = "axe",
                count = 1
            }
        },
        Type = "item", -- indicate if it is 'weapon' or 'item'
        Job = 0,
        Location = 0,
        UseCurrencyMode = false,
        CurrencyType = 0,
        Category = "items"
    },
    {
        Text = "Bål ",
        SubText = "InvMax = 5",
        Desc = "Recipe: 80x Rock, 90x Wood, 20x Coal",
        Items = {
            {
                name = "rock",
                count = 80
            },
            {
                name = "wood",
                count = 90
            },
            {
                name = "coal",
                count = 20
            }
        },
        Reward ={
            {
                name = "campfire",
                count = 1
            }
        },
        Type = "item", -- indicate if it is 'weapon' or 'item'
        Job = 0,
        Location = 0,
        UseCurrencyMode = false,
        CurrencyType = 0,
        Category = "items"
    },
    {
        Text = "Stekt fugl ",
        SubText = "InvMax = 10",
        Desc = "Recipe: 1x Rå fugle kjøtt",
        Items = {
            {
                name = "rawbirdmeat",
                count = 1
            }
        },
        Reward ={
            {
                name = "cookedbird",
                count = 1
            }
        },
        Type = "item", -- indicate if it is 'weapon' or 'item'
        Job = 0,
        Location = 0,
        UseCurrencyMode = false,
        CurrencyType = 0,
        Category = "food"
    },
    {
        Text = "Gullbar ",
        SubText = "InvMax = 15",
        Desc = "Recipe: 1x Gold Ore",
        Items = {
            {
                name = "goldnugget",
                count = 14
            }
        },
        Reward ={
            {
                --name = "gold", -- if you use the currency mode, you don't need a name section inside the reward section
                count = 1
            }
        },
        Type = "item", -- indicate if it is 'weapon' or 'item'
        Job = {banksjef},
        Location = 0, -- set to 0 to allow any locations from Config.Locations, or like { "butcher" } to job restriction
        UseCurrencyMode = true,
        CurrencyType = 1,
        Category = "items"
    },
    {
        Text = "Lite kjøttstykke ",
        SubText = "InvMax = 10 ",
        Desc = "Recipe: 1x Rå lite kjøttstykke",
        Items = {
            {
                name = "consumable_game",
                count = 1
            }
        },
        Reward ={
            {
                name = "plainsmallgame",
                count = 1
            }
        },
        Type = "item",
        Job = 0,
        Location = 0, -- set to 0 to allow any locations from Config.Locations, or like { "butcher" } to job restriction
        UseCurrencyMode = false,
        CurrencyType = 0,
        Category = "food"
    },
    {
        Text = "Tau ",
        SubText = "InvMax = 10",
        Desc = "Recipe: 90x Fiber",
        Items = {
            {
                name = "fibers",
                count = 90
            }
        },
        Reward ={
            {
                name = "rope",
                count = 1
            }
        },
        Type = "item",
        Job = 0,
        Location = 0, -- set to 0 to allow any locations from Config.Locations, or like { "butcher" } to job restriction
        UseCurrencyMode = false,
        CurrencyType = 0,
        Category = "items"
    },
    {
        Text = "Tøystykke ",
        SubText = "InvMax = 10",
        Desc = "Recipe: 70x Wool",
        Items = {
            {
                name = "wool",
                count = 70
            }
        },
        Reward ={
            {
                name = "cloth",
                count = 2
            }
        },
        Type = "item",
        Job = 0,
        Location = 0, -- set to 0 to allow any locations from Config.Locations, or like { "butcher" } to job restriction
        UseCurrencyMode = false,
        CurrencyType = 0,
        Category = "items"
    },
    {
        Text = "Telt  ",
        SubText = "InvMax = 5 ",
        Desc = "Recipe: 500x Tøystykke, 220x Tau, 190x Tre",
        Items = {
            {
                name = "cloth",
                count = 500
            },
            {
                name = "rope",
                count = 220
            },
            {
                name = "wood",
                count = 190
            }
        },
        Reward ={
            {
                name = "tent",
                count = 1
            }
        },
        Type = "tent",
        Job = 0,
        Location = 0, -- set to 0 to allow any locations from Config.Locations, or like { "butcher" } to job restriction
        UseCurrencyMode = false,
        CurrencyType = 0,
        Category = "items"
    },
    {
        Text = "Sovematte ",
        SubText = "InvMax = 5",
        Desc = "Recipe: 15x Skinn, 18x Tøystykke, 7x Tre",
        Items = {
            {
                name = "pelt",
                count = 15
            },
            {
                name = "cloth",
                count = 18
            },
            {
                name = "wood",
                count = 7
            }
        },
        Reward ={
            {
                name = "bedroll",
                count = 1
            }
        },
        Type = "item",
        Job = 0,
        Location = 0, -- set to 0 to allow any locations from Config.Locations, or like { "butcher" } to job restriction
        UseCurrencyMode = false,
        CurrencyType = 0,
        Category = "items"
    }, 
    {
        Text = "Cigar",
        SubText = "InvMax = 20",
        Desc = "Recipe: 1x Indian Tobacco, 1x Fiber",
        Items = {
            {
                name = "Indian_Tobbaco",
                count = 10
            },
            {
                name = "fibers",
                count =20
            }
        },
        Reward ={
            {
                name = "cigar",
                count = 1
            }
        },
        Type = "item",
        Job = 0,
        Location = 0, -- set to 0 to allow any locations from Config.Locations, or like { "butcher" } to job restriction
        UseCurrencyMode = false,
        CurrencyType = 0,
        Category = "items"
    },
    {
        Text = "Rullings ",
        SubText = "InvMax = 20",
        Desc = "Recipe: 1x Indian Tobacco, 1x Fiber",
        Items = {
            {
                name = "Indian_Tobbaco",
                count = 3
            },
            {
                name = "fibers",
                count = 2
            }
        },
        Reward ={
            {
                name = "cigarette",
                count = 1
            }
        },
        Type = "item",
        Job = 0,
        Location = 0, -- set to 0 to allow any locations from Config.Locations, or like { "butcher" } to job restriction
        UseCurrencyMode = false,
        CurrencyType = 0,
        Category = "items"
    }, 
    {
        Text = "CowBoy Frokost ",
        SubText = "InvMax = 10",
        Desc = "Recipe: 10x Meat, 10x Eggs, 10x potatoes",
        Items = {
            {
                name = "meat",
                count = 10
            },
            {
                name = "eggs",
                count = 10
            },
            {
                name = "potato",
                count = 10
            }
        },
        Reward ={
            {
                name = "steakeggs",
                count = 1
            }
        },
        Type = "item",
        Job = 0,
        Location = 0, -- set to 0 to allow any locations from Config.Locations, or like { "butcher" } to job restriction
        UseCurrencyMode = false,
        CurrencyType = 0,
        Category = "food"
    }, 
    {
        Text = "Vegitar stuing ",
        SubText = "InvMax = 10",
        Desc = "Recipe: 5x Gullerot, 3x Maiskolbe, 5x Poteter, 1x Vann, 2x Salt",
        Items = {
            {
                name = "carrot",
                count = 5
            },
            {
                name = "corn",
                count = 3
            },
            {
                name = "potato",
                count = 5
            },
            {
                name = "water",
                count = 1
            },
            {
                name = "salt",
                count = 2
            }
        },
        Reward ={
            {
                name = "vegstew",
                count = 1
            }
        },
        Type = "item",
        Job = 0,
        Location = 0, -- set to 0 to allow any locations from Config.Locations, or like { "butcher" } to job restriction
        UseCurrencyMode = false,
        CurrencyType = 0,
        Category = "food"
    },   
    {
        Text = "Svin i epplesaus ",
        SubText = "InvMax = 10",
        Desc = "Recipe: 1x Svin, 2x Eppler",
        Items = {
            {
                name = "Pork",
                count = 1
            },
            {
                name = "apple",
                count = 2
            }
        },
        Reward ={
            {
                name = "porknapples",
                count = 1
            }
        },
        Type = "item",
        Job = 0,
        Location = 0, -- set to 0 to allow any locations from Config.Locations, or like { "butcher" } to job restriction
        UseCurrencyMode = false,
        CurrencyType = 0,
        Category = "food"
    },
    {
        Text = "Fuglestuing ",
        SubText = "InvMax = 10",
        Desc = "Recipe: 4x Rå fugl, 3x Gullerot, 1x Maiskoble, 2x Vann, 2x Salt",
        Items = {
            {
                name = "rawbirdmeat",
                count = 4
            },
            {
                name = "carrot",
                count = 3
            },
            {
                name = "corn",
                count = 1
            },
            {
                name = "water",
                count = 2
            },
            {
                name = "salt",
                count = 2
            }
        },
        Reward ={
            {
                name = "birdstew",
                count = 1
            }
        },
        Type = "item",
        Job = 0,
        Location = 0, -- set to 0 to allow any locations from Config.Locations, or like { "butcher" } to job restriction
        UseCurrencyMode = false,
        CurrencyType = 0,
        Category = "food"
    },
   
    {
        Text = "Bow ",
        SubText = "InvMax = 1",
        Desc = "Recipe: 2x Hard wood, 4x Fibers",
        Items = {
            {
                name = "hwood",
                count = 2
            },
            {
                name = "fibers",
                count = 4
            },
        },
        Reward ={
            {
                name = "WEAPON_BOW_IMPROVED",
                count = 1
            }
        },
        Type = "weapon", -- indicate if it is 'weapon' or 'item'
        Job = 0, 
        Location = 0,
        Category = "weapons",
        Animation = 'craft' -- set what animation should play when crafting (if this is not set it has a default animation). Animations can be found below in Config.Animations
    },
    {
        Text = "Revolver Navy ",
        SubText = "InvMax = 1",
        Desc = "Recipe 1x Revolver barrel, 1x Revolver cylinder, 1x Revolver handle",
        Items = {
            {
                name = "revolverbarrel",
                count = 1
            },
            {
                name = "revolvercylinder",
                count = 1
            },
            {
                name = "revolverhandle",
                count = 1
            },
        },
        Reward = {
            {
                name = "WEAPON_REVOLVER_NAVY",
                count = 1
            }
        },
        Type = "weapon", -- indicate if it is 'weapon' or 'item'
        Job = 0, -- set to 0 to allow any jobs, or like { "butcher" } to job restriction
        Location = 0, -- set to 0 to allow any locations from Config.Locations, or like { "butcher" } to job restriction
        Category = "weapons",
        Animation = 'craft' -- set what animation should play when crafting (if this is not set it has a default animation). Animations can be found below in Config.Animations
    },
    {
        Text = "Knife ",
        SubText = "InvMax = 1",
        Desc = "Recipe 1x Iron, 1x Soft wood",
        Items = {
            {
                name = "iron",
                count = 1
            },
            {
                name = "wood",
                count = 1
            },
        },
        Reward = {
            {
                name = "WEAPON_MELEE_KNIFE",
                count = 1
            }
        },
        Type = "weapon", -- indicate if it is 'weapon' or 'item'
        Job = 0, -- set to 0 to allow any jobs, or like { "butcher" } to job restriction
        Location = 0, -- set to 0 to allow any locations from Config.Locations, or like { "butcher" } to job restriction
        Category = "meleeweapons",
        Animation = 'craft' -- set what animation should play when crafting (if this is not set it has a default animation). Animations can be found below in Config.Animations
    },
}

Config.Animations = {
    ["craft"] = { --Default Animation
        dict = "mech_inventory@crafting@fallbacks",
        name = "full_craft_and_stow", 
        flag = 27,
        type = 'standard'
    },
    ["spindlecook"] = {
        dict = "amb_camp@world_camp_fire_cooking@male_d@wip_base",
        name = "wip_base",
        flag = 17,
        type = 'standard',
        prop = {
            model = 'p_stick04x',
            coords = {
                x = 0.2, 
                y = 0.04,
                z = 0.12,
                xr = 170.0,
                yr = 50.0,
                zr = 0.0
            },
            bone = 'SKEL_R_Finger13',
            subprop = {
                model = 's_meatbit_chunck_medium01x',
                coords = {
                    x = -0.30, 
                    y = -0.08,
                    z = -0.30,
                    xr = 0.0,
                    yr = 0.0,
                    zr = 70.0
                }
            }
        }
    },
    ["knifecooking"] = {
        dict = "amb_camp@world_player_fire_cook_knife@male_a@wip_base",
        name = "wip_base", 
        flag = 17,
        type = 'standard',
        prop = {
            model = 'w_melee_knife06',
            coords = {
                x = -0.01, 
                y = -0.02,
                z = 0.02,
                xr = 190.0,
                yr = 0.0,
                zr = 0.0
            },
            bone = 'SKEL_R_Finger13',
            subprop = {
                model = 'p_redefleshymeat01xa',
                coords = {
                    x = 0.00, 
                    y = 0.02,
                    z = -0.20,
                    xr = 0.0,
                    yr = 0.0,
                    zr = 0.0
                }
            }
        }
    },
    ["campfire"] = {
        dict = "script_campfire@lighting_fire@male_male",
        name = "light_fire_b_p2_male_b", 
        flag = 17,
        type = 'standard'
	}
}
