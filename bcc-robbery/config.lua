Config = {}

---------------- Main Setup ------------------------
Config.defaultlang = "en_lang" -- set your language

Config.Webhook = "" --set your Discord Webhook

Config.RobberyCommand = 'robbery' --command to enter to enable robberies
Config.RobberyCooldown = 30000 --This is the cooldown in ms for each robbery meaning once a place is robbed you have to wait this long to rob it again

--These are jobs that will not be able to do robberies
Config.NoRobberyJobs = { --add as many as you want just copy paste a table
    {jobname = 'banksjef'}
    }

Config.PoliceAlert = {
    enabled = true,
    Job = 'police',
    AlertMssg = 'Robbery In Progress!',
    ShowMssgTime = 30000,
    BlipTime = 60000
}

--Lockpicking setup
Config.LockPick = {
    MaxAttemptsPerLock = 3,
    lockpickitem = 'lockpick',
    difficulty = 10,
    hintdelay = 500,
    pins = { -- hardcoded pins, if randomPins set to true, then this will be ignored.
        {
            deg = 25 -- 0-360 degrees
        },
        {
            deg = 0 -- 0-360 degrees
        },
        {
            deg = 300 -- 0-360 degrees
        }
    },
    randomPins = true --If random is set to True, then pins above will be ignored.
}

-- Main robbery setup
Config.Robberies = {
    {
        Id = 101, --this has to be unique to each robbery
        StartingCoords = {x = -322.36, y = 804.46, z = 117.88}, --coords you have to be near to start the robbery
        EnemyNpcs = true, --if true enemy npcs will spawn and attack the player
        WaitBeforeLoot = 30000, --wait in ms before player can loot 0 for none
        LootLocations = { --This is the loot location setup, add as many as youd like
                     {
                LootCoordinates = {x = -324.15, y = 804.44, z = 117.88}, --coordinates of the loot box
                CashReward = 350, --amount of cash to reward
                ItemRewards = { --these are the items it will reward can add as many as youd like
                    {
                        name = 'iron', --the name of the item in the database
                        count = 10, --amount to give
                    },
                },
            },
        },
        EnemyNpcCoords = { --coords where the enemy npcs will spawn add as many as youd like
            {x = -325.04, y = 797.18, z = 117.88}, --coords the peds will spawn at
            {x = -320.61, y = 803.24, z = 117.88},
{x = -317.21, y = 801.09, z = 117.59},
{x = -318.2, y = 802.8, z = 117.39},
{x = -316.95, y = 819.09, z = 121.85},{x = -316.05, y = 819.64, z = 121.85},{x = -316.76, y = 819.89, z = 121.85}
        },
    },
 {
        Id =102, --this has to be unique to each robbery
        StartingCoords = {x = -309.55, y = 806.51, z = 118.98}, --coords you have to be near to start the robbery
        EnemyNpcs = true, --if true enemy npcs will spawn and attack the player
        WaitBeforeLoot = 30000, --wait in ms before player can loot 0 for none
        LootLocations = { --This is the loot location setup, add as many as youd like
                     {
                LootCoordinates = {x = -313.59, y = 805.01, z = 118.98}, --coordinates of the loot box
                CashReward = 650, --amount of cash to reward
                ItemRewards = { --these are the items it will reward can add as many as youd like
                    {
                        name = 'iron', --the name of the item in the database
                        count = 10, --amount to give
                    },
                },
            },
        },
        EnemyNpcCoords = { --coords where the enemy npcs will spawn add as many as youd like
            {x = -325.04, y = 797.18, z = 117.88}, --coords the peds will spawn at
            {x = -320.61, y = 803.24, z = 117.88},{x = -330.42, y = 822.34, z = 117.88},{x = -331.57, y = 821.65, z = 117.79},{x = -331.57, y = 821.65, z = 117.79},{x = -331.57, y = 821.65, z = 117.79},{x = -331.57, y = 821.65, z = 117.79},{x = -331.57, y = 821.65, z = 117.79},{x = -331.57, y = 821.65, z = 117.79},{x = -331.57, y = 821.65, z = 117.79},{x = -331.57, y = 821.65, z = 117.79},
{x = -317.21, y = 801.09, z = 117.59},
{x = -318.2, y = 802.8, z = 117.39},
{x = -316.95, y = 819.09, z = 121.85},{x = -316.05, y = 819.64, z = 121.85},{x = -316.76, y = 819.89, z = 121.85}
        },
    }
,
 {
        Id =103, --this has to be unique to each robbery
        StartingCoords = {x = -327.02, y = 775.72, z = 117.48}, --coords you have to be near to start the robbery
        EnemyNpcs = true, --if true enemy npcs will spawn and attack the player
        WaitBeforeLoot = 30000, --wait in ms before player can loot 0 for none
        LootLocations = { --This is the loot location setup, add as many as youd like
                     {
                LootCoordinates ={x = -326.25, y = 772.83, z = 117.44}, --coordinates of the loot box
                CashReward = 450, --amount of cash to reward
                ItemRewards = { --these are the items it will reward can add as many as youd like
                    {
                        name = 'iron', --the name of the item in the database
                        count = 10, --amount to give
                    },
                },
            },
        },
        EnemyNpcCoords = { --coords where the enemy npcs will spawn add as many as youd like
            {x = -325.04, y = 797.18, z = 117.88}, --coords the peds will spawn at
            {x = -320.61, y = 803.24, z = 117.88},{x = -330.42, y = 822.34, z = 117.88},{x = -331.57, y = 821.65, z = 117.79},{x = -331.57, y = 821.65, z = 117.79},{x = -331.57, y = 821.65, z = 117.79},{x = -331.57, y = 821.65, z = 117.79},{x = -331.57, y = 821.65, z = 117.79},{x = -331.57, y = 821.65, z = 117.79},{x = -331.57, y = 821.65, z = 117.79},{x = -331.57, y = 821.65, z = 117.79},
        },
    }

,
 {
        Id =4, --this has to be unique to each robbery
        StartingCoords = {x = -281.68, y = 782.01, z = 119.5}, --coords you have to be near to start the robbery
        EnemyNpcs = true, --if true enemy npcs will spawn and attack the player
        WaitBeforeLoot = 30000, --wait in ms before player can loot 0 for none
        LootLocations = { --This is the loot location setup, add as many as youd like
                     {
                LootCoordinates ={x = -279.82, y = 778.82, z = 119.5}, --coordinates of the loot box
                CashReward = 450, --amount of cash to reward
                ItemRewards = { --these are the items it will reward can add as many as youd like
                    {
                        name = 'iron', --the name of the item in the database
                        count = 10, --amount to give
                    },
                },
            },
        },
        EnemyNpcCoords = { --coords where the enemy npcs will spawn add as many as youd like
            {x = -325.04, y = 797.18, z = 117.88}, --coords the peds will spawn at
            {x = -320.61, y = 803.24, z = 117.88},{x = -330.42, y = 822.34, z = 117.88},{x = -331.57, y = 821.65, z = 117.79},{x = -331.57, y = 821.65, z = 117.79},{x = -331.57, y = 821.65, z = 117.79},{x = -331.57, y = 821.65, z = 117.79},{x = -331.57, y = 821.65, z = 117.79},{x = -331.57, y = 821.65, z = 117.79},{x = -331.57, y = 821.65, z = 117.79},{x = -331.57, y = 821.65, z = 117.79},
        },
    }


,
 {
        Id =105, --this has to be unique to each robbery
        StartingCoords = {x = -285.1, y = 806.05, z = 119.39}, --coords you have to be near to start the robbery
        EnemyNpcs = true, --if true enemy npcs will spawn and attack the player
        WaitBeforeLoot = 30000, --wait in ms before player can loot 0 for none
        LootLocations = { --This is the loot location setup, add as many as youd like
                     {
                LootCoordinates ={x = -288.22, y = 805.17, z = 119.39}, --coordinates of the loot box
                CashReward = 100, --amount of cash to reward
                ItemRewards = { --these are the items it will reward can add as many as youd like
                    {
                        name = 'iron', --the name of the item in the database
                        count = 10, --amount to give
                    },
                },
            },    {
                LootCoordinates ={x = -284.98, y = 810.5, z = 119.39}, --coordinates of the loot box
                CashReward = 800, --amount of cash to reward
                ItemRewards = { --these are the items it will reward can add as many as youd like
                    {
                        name = 'iron', --the name of the item in the database
                        count = 10, --amount to give
                    },
                },
            },    {
                LootCoordinates ={x = -290.74, y = 815.15, z = 119.39}, --coordinates of the loot box
                CashReward = 0, --amount of cash to reward
                ItemRewards = { --these are the items it will reward can add as many as youd like
                    {
                        name = 'iron', --the name of the item in the database
                        count = 10, --amount to give
                    },
                },
            }, {
                LootCoordinates ={x = -282.37, y = 817.82, z = 119.39}, --coordinates of the loot box
                CashReward = 0, --amount of cash to reward
                ItemRewards = { --these are the items it will reward can add as many as youd like
                    {
                        name = 'iron', --the name of the item in the database
                        count = 10, --amount to give
                    },
                },
            },



        },
        EnemyNpcCoords = { --coords where the enemy npcs will spawn add as many as youd like
            {x = -325.04, y = 797.18, z = 117.88}, --coords the peds will spawn at
            {x = -320.61, y = 803.24, z = 117.88},{x = -330.42, y = 822.34, z = 117.88},{x = -331.57, y = 821.65, z = 117.79},{x = -331.57, y = 821.65, z = 117.79},{x = -331.57, y = 821.65, z = 117.79},{x = -331.57, y = 821.65, z = 117.79},{x = -331.57, y = 821.65, z = 117.79},{x = -331.57, y = 821.65, z = 117.79},{x = -331.57, y = 821.65, z = 117.79},{x = -331.57, y = 821.65, z = 117.79},{x = -320.61, y = 803.24, z = 117.88},{x = -330.42, y = 822.34, z = 117.88},{x = -331.57, y = 821.65, z = 117.79},{x = -331.57, y = 821.65, z = 117.79},{x = -331.57, y = 821.65, z = 117.79},{x = -331.57, y = 821.65, z = 117.79},{x = -331.57, y = 821.65, z = 117.79},{x = -331.57, y = 821.65, z = 117.79},{x = -331.57, y = 821.65, z = 117.79},{x = -331.57, y = 821.65, z = 117.79},{x = -320.61, y = 803.24, z = 117.88},{x = -330.42, y = 822.34, z = 117.88},{x = -331.57, y = 821.65, z = 117.79},{x = -331.57, y = 821.65, z = 117.79},{x = -331.57, y = 821.65, z = 117.79},{x = -331.57, y = 821.65, z = 117.79},{x = -331.57, y = 821.65, z = 117.79},{x = -331.57, y = 821.65, z = 117.79},{x = -331.57, y = 821.65, z = 117.79},{x = -331.57, y = 821.65, z = 117.79},
        },
    }


,
 {
        Id =106, --this has to be unique to each robbery
        StartingCoords = {x = -275.82, y = 806.03, z = 119.38}, --coords you have to be near to start the robbery
        EnemyNpcs = true, --if true enemy npcs will spawn and attack the player
        WaitBeforeLoot = 30000, --wait in ms before player can loot 0 for none
        LootLocations = { --This is the loot location setup, add as many as youd like
                     {
                LootCoordinates ={x = -278.55, y = 805.14, z = 119.38}, --coordinates of the loot box
                CashReward = 0, --amount of cash to reward
                ItemRewards = { --these are the items it will reward can add as many as youd like
                    {
                        name = 'iron', --the name of the item in the database
                        count = 10, --amount to give
                    },
                },
            },



        },
        EnemyNpcCoords = { --coords where the enemy npcs will spawn add as many as youd like
            {x = -325.04, y = 797.18, z = 117.88}, --coords the peds will spawn at
            {x = -320.61, y = 803.24, z = 117.88},{x = -330.42, y = 822.34, z = 117.88},{x = -331.57, y = 821.65, z = 117.79},{x = -331.57, y = 821.65, z = 117.79},{x = -331.57, y = 821.65, z = 117.79},{x = -331.57, y = 821.65, z = 117.79},{x = -331.57, y = 821.65, z = 117.79},{x = -331.57, y = 821.65, z = 117.79},{x = -331.57, y = 821.65, z = 117.79},{x = -331.57, y = 821.65, z = 117.79},{x = -320.61, y = 803.24, z = 117.88},{x = -330.42, y = 822.34, z = 117.88},{x = -331.57, y = 821.65, z = 117.79},{x = -331.57, y = 821.65, z = 117.79},{x = -331.57, y = 821.65, z = 117.79},{x = -331.57, y = 821.65, z = 117.79},{x = -331.57, y = 821.65, z = 117.79},{x = -331.57, y = 821.65, z = 117.79},{x = -331.57, y = 821.65, z = 117.79},{x = -331.57, y = 821.65, z = 117.79},{x = -320.61, y = 803.24, z = 117.88},{x = -330.42, y = 822.34, z = 117.88},{x = -331.57, y = 821.65, z = 117.79},{x = -331.57, y = 821.65, z = 117.79},{x = -331.57, y = 821.65, z = 117.79},{x = -331.57, y = 821.65, z = 117.79},{x = -331.57, y = 821.65, z = 117.79},{x = -331.57, y = 821.65, z = 117.79},{x = -331.57, y = 821.65, z = 117.79},{x = -331.57, y = 821.65, z = 117.79},
        },
    }
,
}

------------------- Translate Here -----------------------
Config.Language = {
    RobberyStart = 'Robbery Started!',
    OnCooldown = 'This has been robbed recently!',
    LootMarked = 'Begin Looting!',
    HoldOutBeforeLooting = 'Wait',
    HoldOutBeforeLooting2 = 'Minutes Before Looting',
    RobberyFail = 'Robbery Failed!',
    Rob = 'LockPick',
    Robbery = 'LockBox',
    PickFailed = 'Lockpicking Failed Lock Broken',
    RobberyEnable = 'Robberies enabled shoot a gun, at a valid location to start a robbery!',
    RobberyDisable = 'Robberies Disabled',
    WrongJob = 'You can not start robberies due to your job!'
}