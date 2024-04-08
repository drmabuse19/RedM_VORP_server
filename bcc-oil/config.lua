Config = {}

Config.WebhookLink = '' --insert your webhook link here (leave empty for no webhooks)

Config.Lang = "English"

------------------------------------------ Oil Job Setup ---------------------------------------------------
---------Oil Part of the job -------------
Config.OilandSupplyWagonSpawn = {x = 526.83, y = 703.01, z = 117.0, h = 263.92} --Coords your oil and supply wagons will spawn at
Config.ManagerBlip = true --If true will create a blip on the Manager, if false it will not
Config.ManagerPedModel = 'u_m_m_cktmanager_01' -- This is the model the manager will spawn as
Config.OilWagon = {price = 2000, sellprice = 80} --Oil wagon model hash theres 2 but there the same(making this easily changeable incase you do want to change the model)
Config.OilWagonFillTime = 10000 --time in ms it takes to fill the oil wagon aswell as unload when delivering oil
Config.BasicOilDeliveryPay = 65 --This is the base pay rate for doing an oil mission (the payoutbonus in the Config.OilCompanyLevels will be added to this amount)
Config.LevelIncreasePerDelivery = 1 --sets the amount your level increases per delivery mission
--------------------- config player's wagon blip---------------------------
Config.OilWagonBilpHash = 1612913921 --Set Oil Wagon blip icon using blip hashes (https://redlookup.com/blips)
Config.OilWagonBlipColor = 'BLIP_MODIFIER_MP_COLOR_32' --Set Supply wagon blip color. you can find the colors you can use in the end of this config file
Config.SupplyWagonBilpHash = 1612913921 --Set Supply Wagon blip icon using blip hashes (https://redlookup.com/blips)
Config.SupplyWagonBlipColor = 'BLIP_MODIFIER_MP_COLOR_32' --Set Supply wagon blip color. you can find the colors you can use in the end of this config file
------------------------ config company manager blip and criminal blip-------------------------
Config.ManagerBlipHash = 1000514759
Config.ManagerBlipColor = 'BLIP_MODIFIER_MP_COLOR_2'
Config.CriminalBlipHash = 1000514759
Config.CriminalBlipColor = 'BLIP_MODIFIER_MP_COLOR_2'

-------------This is the levels, and what they pay-----------------------------------------
--This level setup is for the entire oil company this will effect payout for basic jobs etc(You can add or remove levels as you please but there has to be atleast 1)
Config.SniffOil = { --oil sniffing setup
    enable = true, --if true players will be able to sniff oil and get high
    Coords = {x = 477.82, y = 641.27, z = 115.28}, --coords you will have to go to to sniff oil
    EffectTime = 600000, --the time the screen effect will last
}

Config.OilCompanyLevels = {
    {
        level = 10, --this is the level you have to be at or above to get the bonus
        payoutbonus = 5	, --this is how much extra you will get when finishing a delivery mission
        nextlevel = 20, --this has to be the next level so since the next level is 20 this has to be 20
    },
    {
        level = 20,
        payoutbonus = 40,
        nextlevel = 30,
    },
    {
        level = 30,
        payoutbonus = 100,
        nextlevel = 40,
    },
}

--------Place Where You Will Go To Deliver The Oil, It Picks Randomly Each Delivery--------
Config.OilDeliveryPoints = {
    {
        DeliveryPoint = {x = -223.44, y = 642.03, z = 113.14}, --the point you have to go to
        NpcSpawn = {x = -226.0, y = 632.26, z = 113.21, h = 200}, --the point the npc will spawn make this close to the deliverypoint coords
    },
    {
        DeliveryPoint = {x = -172.01, y = 652.05, z = 113.73},
        NpcSpawn = {x = -179.5, y = 650.0, z = 113.58, h = 200},
    },

    {
        DeliveryPoint = {x = -848.1, y = -1293.61, z = 43.15}, --Blackwater

        NpcSpawn ={x = -843.49, y = -1291.71, z = 43.57},
    },

    {
        DeliveryPoint = {x = -884.01, y = -1392.86, z = 44.31}, --Blackwater

        NpcSpawn ={x = -883.45, y = -1400.87, z = 44.46},
    },
  {
        DeliveryPoint = {x = -835.49, y = -1334.16, z = 43.4}, --Blackwater
        NpcSpawn ={x = -841.43, y = -1327.55, z = 43.48},
    },
{
        DeliveryPoint = {x = -1767.36, y = -398.71, z = 155.97}, --Starbewvalli
        NpcSpawn ={x = -1771.13, y = -395.78, z = 156.31},
    },
{
        DeliveryPoint = {x = 2952.89, y = 1377.23, z = 43.91}, --ab north
        NpcSpawn ={x = 2946.78, y = 1371.0, z = 43.95},
    },
{
        DeliveryPoint = {x = 2964.24, y = 561.86, z = 44.41}, --canhorn
        NpcSpawn ={x = 2968.49, y = 568.35, z = 44.42},
    },

}

------Supply part of the job-----------
Config.SupplyWagon = {price = 2000, sellprice = 850} --price and sell price of supply wagon
Config.FillySupplyWagonTime = 10000 --time it will take to fill your supply wagon
Config.SupplyDeliveryBasePay = 60 --Base pay for delivering supplies

--These are the locations the script will randomly pick one from them to make you deliver too
Config.SupplyDeliveryLocations = {
    {x = 781.75, y = 854.34, z = 118.36},
    {x = 1100.41, y = 493.49, z = 95.63},
    {x = 891.75, y = 266.95, z = 116.3},

{x = -223.44, y = 642.03, z = 113.14},
{x = -172.01, y = 652.05, z = 113.73},
{x = -848.1, y = -1293.61, z = 43.15},
{x = -884.01, y = -1392.86, z = 44.31},
{x = -835.49, y = -1334.16, z = 43.4},
{x = -1767.36, y = -398.71, z = 155.97},
{x = 2952.89, y = 1377.23, z = 43.91},
{x = 2964.24, y = 561.86, z = 44.41}
}

--------------Criminal Job Setup----------------------------------------------
Config.CriminalPedSpawn ={x = -5526.61, y = -2928.92, z = -1.36,h = 300}--this is the location the criminal ped that gives you jobs will spawn
Config.CriminalPedBlip = false --if enabled this will place a blip on the criminal peds location on the map
Config.CriminalPedModel = 'U_M_M_STORY_TUMBLEWEED_01' --model of the criminal ped
Config.CriminalLevelIncrease = 1 --this is how much your level will increase per job completed(this is for all jobs)
Config.OilCompanyLevelDecrease = 1 --this is how much your oilco level will decrease upon doing a criminal misison
Config.StealOilWagonBasePay = 500 --this is the base pay for stealing an oil wagon
Config.CrimBlipHash = 'blip_mp_torch' --Blip hash
Config.RobOilWagonCooldown = 9000000 --Amount of time in ms that has to pass before anyone can rob the oil wagon again
Config.RobOilCoCooldown = 9000000 --Time in ms before a player can rob the oil company again

-----Level Setup-----
Config.CriminalLevels = {
    {
        level = 5, --this is the level you have to be at or above to get the bonus
        payoutbonus = 300, --this is how much extra you will get when finishing a delivery mission
        nextlevel = 15, --this has to be the next level so since the next level is 20 this has to be 20
    },
    {
        level = 15,
        payoutbonus = 500,
        nextlevel = 30,
    },
    {
        level = 30,
        payoutbonus = 750,
        nextlevel = 40,
    },
}

----Steal Oil Wagon Setup-----
Config.OilWagonrobberyLocations = {
    {
        wagonLocation = vector3(381.15, -21.5, 109.09),
        wagonHeading = 360,
        pedlocation = {
            {x = 384.9, y = -23.37, z = 109.06},
            {x = 383.09, y = -19.78, z = 108.91},
            {x = 381.08, y = -13.82, z = 108.57},
 {x = 384.9, y = -23.37, z = 109.06},
            {x = 383.09, y = -19.78, z = 108.91},
            {x = 381.08, y = -13.82, z = 108.57},

 {x = 384.9, y = -23.37, z = 109.06},
            {x = 383.09, y = -19.78, z = 108.91},
            {x = 381.08, y = -13.82, z = 108.57},

        },
        returnlocation = {x = -3651.13, y = -2569.03, z = -13.73},
    },
}

---Rob Oil Company Setup----
Config.RobOilCoEnemyPeds = true --if true enemy peds will spawn when you are done lockpicking to fight you
Config.RobOilCoEnemyPedsLocations = {
    {x = 505.34, y = 700.74, z = 116.05},
    {x = 503.61, y = 689.27, z = 117.48},
    {x = 507.35, y = 682.53, z = 117.39},
    {x = 512.52, y = 686.54, z = 117.4},
{x = 443.35, y = 664.29, z = 115.36},
{x = 441.71, y = 668.39, z = 115.34},
{x = 439.29, y = 667.89, z = 115.51},
{x = 475.82, y = 644.27, z = 115.28},
{x = 477.82, y = 647.27, z = 115.28},
{x = 478.82, y = 642.27, z = 115.28}
}

Config.LockPick = {
    MaxAttemptsPerLock = 3,
    lockpickitem = 'lockpick',
    difficulty = 10,
    hintdelay = 500,
}

Config.RobOilCompany = {
    {
        lootlocation = {x = 493.83, y = 675.16, z = 117.39}, --locations where you will have to go to lockpick
        rewards = { --this will handle the rewards
            itemspayout = true, --if true it will give items, if false it will just pay the cash amount set below
            cashpayout = 100, --this is the amount of cash it will give you
            items = { 
            
            },
        },
    }, --you can add more locations to this, the script will randomly choose one table each robbery too add more just copy paste table change what you need
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
