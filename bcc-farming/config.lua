Config = {
    defaultlang = "en_lang", -- Language file to use

    fullWaterBucketItem = "wateringcan", -- Item name for the full water bucket
    emptyWaterBucketItem = "wateringcan_empty", -- Item name for the empty water bucket

    plantSetup = {
        blips = true, -- If true, it will create blips for the plants
        deleteAfterDays = 3, -- Days after the plant will be deleted if not harvested (0 will disable, but it's not recommended)
        lockedToPlanter = false, -- If true, only the player who planted the seed will be able to harvest it
        maxPlants = 10, -- Maximum amount of plants a player can have
        plants = {
            {

                webhooked = false, -- If true, it will send a message to the webhook when the plant is planted, and when it's harvested
                plantingToolRequired = true, -- If true, the player will need a tool to plant the seed
                plantingTool = "hoe", -- Item name for the tool required to plant the seed
                plantingToolDurability = 100, -- Durability of the tool required to plant the seed
                plantingToolUsage = 1, -- Durability usage of the tool required to plant the seed
                plantName = "wheat", -- Name of the plant
                seedName = "wheatseed", -- Item name for the seed
                plantProp = "p_tree_orange_01", -- Prop for the plant to be spawned
                soilRequired = false, -- If true, the seed will require soil to be planted
                soilAmount = 1, -- Amount of soil required to plant the seed
                soilName = "soil", -- Item name for the soil required to plant the seed
                fertilizerName = "fertilizerGreen", -- Item name for the fertilizer to fertilize the seed
                fertTimeReduction = 900, -- Time reduction in seconds when using fertilizer
                timeToGrow = 1800, -- Time in seconds for the plant to grow
                plantOffset = 1, -- If the plant is not on the ground properly you can use this setting
                jobLocked = false, -- If true, only players with the job will be able to harvest the plant
                rewards = {
                    {
                        itemName = "wheat",
                        amount = 3
                    }
                },
                jobs = {
                    'farmer',
                    'doctor'
                }
            },
 {

                webhooked = false, -- If true, it will send a message to the webhook when the plant is planted, and when it's harvested
                plantingToolRequired = true, -- If true, the player will need a tool to plant the seed
                plantingTool = "hoe", -- Item name for the tool required to plant the seed
                plantingToolDurability = 100, -- Durability of the tool required to plant the seed
                plantingToolUsage = 1, -- Durability usage of the tool required to plant the seed
                plantName = "potato", -- Name of the plant
                seedName = "potatoseed", -- Item name for the seed
                plantProp = "p_tree_orange_01", -- Prop for the plant to be spawned
                soilRequired = false, -- If true, the seed will require soil to be planted
                soilAmount = 1, -- Amount of soil required to plant the seed
                soilName = "soil", -- Item name for the soil required to plant the seed
                fertilizerName = "fertilizerGreen", -- Item name for the fertilizer to fertilize the seed
                fertTimeReduction = 900, -- Time reduction in seconds when using fertilizer
                timeToGrow = 1800, -- Time in seconds for the plant to grow
                plantOffset = 1, -- If the plant is not on the ground properly you can use this setting
                jobLocked = false, -- If true, only players with the job will be able to harvest the plant
                rewards = {
                    {
                        itemName = "potato",
                        amount = 4
                    }
                },
                jobs = {
                    'farmer',
                    'doctor'
                }
            }
,
 {

                webhooked = false, -- If true, it will send a message to the webhook when the plant is planted, and when it's harvested
                plantingToolRequired = true, -- If true, the player will need a tool to plant the seed
                plantingTool = "hoe", -- Item name for the tool required to plant the seed
                plantingToolDurability = 100, -- Durability of the tool required to plant the seed
                plantingToolUsage = 1, -- Durability usage of the tool required to plant the seed
                plantName = "carrot", -- Name of the plant
                seedName = "carrotseed", -- Item name for the seed
                plantProp = "p_tree_orange_01", -- Prop for the plant to be spawned
                soilRequired = false, -- If true, the seed will require soil to be planted
                soilAmount = 1, -- Amount of soil required to plant the seed
                soilName = "soil", -- Item name for the soil required to plant the seed
                fertilizerName = "fertilizerRed", -- Item name for the fertilizer to fertilize the seed
                fertTimeReduction = 300, -- Time reduction in seconds when using fertilizer
                timeToGrow = 900, -- Time in seconds for the plant to grow
                plantOffset = 1, -- If the plant is not on the ground properly you can use this setting
                jobLocked = false, -- If true, only players with the job will be able to harvest the plant
                rewards = {
                    {
                        itemName = "carrot",
                        amount = 2
                    }
                },
                jobs = {
                    'farmer',
                    'doctor'
                }
            }
,
 {

                webhooked = false, -- If true, it will send a message to the webhook when the plant is planted, and when it's harvested
                plantingToolRequired = true, -- If true, the player will need a tool to plant the seed
                plantingTool = "hoe", -- Item name for the tool required to plant the seed
                plantingToolDurability = 100, -- Durability of the tool required to plant the seed
                plantingToolUsage = 1, -- Durability usage of the tool required to plant the seed
                plantName = "marijuana", -- Name of the plant
                seedName = "marijuanaseed", -- Item name for the seed
                plantProp = "p_tree_orange_01", -- Prop for the plant to be spawned
                soilRequired = false, -- If true, the seed will require soil to be planted
                soilAmount = 1, -- Amount of soil required to plant the seed
                soilName = "soil", -- Item name for the soil required to plant the seed
                fertilizerName = "fertilizerBlue", -- Item name for the fertilizer to fertilize the seed
                fertTimeReduction = 900, -- Time reduction in seconds when using fertilizer
                timeToGrow = 1800, -- Time in seconds for the plant to grow
                plantOffset = 1, -- If the plant is not on the ground properly you can use this setting
                jobLocked = false, -- If true, only players with the job will be able to harvest the plant
                rewards = {
                    {
                        itemName = "marijuana",
                        amount = 2
                    }
                },
                jobs = {
                    'farmer',
                    'doctor'
                }
            }
, {

                webhooked = false, -- If true, it will send a message to the webhook when the plant is planted, and when it's harvested
                plantingToolRequired = true, -- If true, the player will need a tool to plant the seed
                plantingTool = "hoe", -- Item name for the tool required to plant the seed
                plantingToolDurability = 100, -- Durability of the tool required to plant the seed
                plantingToolUsage = 1, -- Durability usage of the tool required to plant the seed
                plantName = "appletree", -- Name of the plant
                seedName = "appleseed", -- Item name for the seed
                plantProp = "p_tree_orange_01", -- Prop for the plant to be spawned
                soilRequired = false, -- If true, the seed will require soil to be planted
                soilAmount = 1, -- Amount of soil required to plant the seed
                soilName = "soil", -- Item name for the soil required to plant the seed
                fertilizerName = "fertilizerBlue", -- Item name for the fertilizer to fertilize the seed
                fertTimeReduction = 900, -- Time reduction in seconds when using fertilizer
                timeToGrow = 1800, -- Time in seconds for the plant to grow
                plantOffset = 1, -- If the plant is not on the ground properly you can use this setting
                jobLocked = false, -- If true, only players with the job will be able to harvest the plant
                rewards = {
                    {
                        itemName = "apple",
                        amount = 10
                    }
                },
                jobs = {
                    'farmer',
                    'doctor'
                }
            }
,

 {

                webhooked = false, -- If true, it will send a message to the webhook when the plant is planted, and when it's harvested
                plantingToolRequired = true, -- If true, the player will need a tool to plant the seed
                plantingTool = "hoe", -- Item name for the tool required to plant the seed
                plantingToolDurability = 100, -- Durability of the tool required to plant the seed
                plantingToolUsage = 1, -- Durability usage of the tool required to plant the seed
                plantName = "orangetree", -- Name of the plant
                seedName = "orangeseed", -- Item name for the seed
                plantProp = "p_tree_orange_01", -- Prop for the plant to be spawned
                soilRequired = false, -- If true, the seed will require soil to be planted
                soilAmount = 1, -- Amount of soil required to plant the seed
                soilName = "soil", -- Item name for the soil required to plant the seed
                fertilizerName = "fertilizerBlue", -- Item name for the fertilizer to fertilize the seed
                fertTimeReduction = 900, -- Time reduction in seconds when using fertilizer
                timeToGrow = 1800, -- Time in seconds for the plant to grow
                plantOffset = 1, -- If the plant is not on the ground properly you can use this setting
                jobLocked = false, -- If true, only players with the job will be able to harvest the plant
                rewards = {
                    {
                        itemName = "orange",
                        amount = 10
                    }
                },
                jobs = {
                    'farmer',
                    'doctor'
                }
            }
,

 {

                webhooked = false, -- If true, it will send a message to the webhook when the plant is planted, and when it's harvested
                plantingToolRequired = true, -- If true, the player will need a tool to plant the seed
                plantingTool = "hoe", -- Item name for the tool required to plant the seed
                plantingToolDurability = 100, -- Durability of the tool required to plant the seed
                plantingToolUsage = 1, -- Durability usage of the tool required to plant the seed
                plantName = "onion", -- Name of the plant
                seedName = "onionseed", -- Item name for the seed
                plantProp = "p_tree_orange_01", -- Prop for the plant to be spawned
                soilRequired = false, -- If true, the seed will require soil to be planted
                soilAmount = 1, -- Amount of soil required to plant the seed
                soilName = "soil", -- Item name for the soil required to plant the seed
                fertilizerName = "fertilizerBlue", -- Item name for the fertilizer to fertilize the seed
                fertTimeReduction = 900, -- Time reduction in seconds when using fertilizer
                timeToGrow = 1800, -- Time in seconds for the plant to grow
                plantOffset = 1, -- If the plant is not on the ground properly you can use this setting
                jobLocked = false, -- If true, only players with the job will be able to harvest the plant
                rewards = {
                    {
                        itemName = "onoion",
                        amount = 4
                    }
                },
                jobs = {
                    'farmer',
                    'doctor'
                }
            }
,

 {

                webhooked = false, -- If true, it will send a message to the webhook when the plant is planted, and when it's harvested
                plantingToolRequired = true, -- If true, the player will need a tool to plant the seed
                plantingTool = "hoe", -- Item name for the tool required to plant the seed
                plantingToolDurability = 100, -- Durability of the tool required to plant the seed
                plantingToolUsage = 1, -- Durability usage of the tool required to plant the seed
                plantName = "cotton", -- Name of the plant
                seedName = "cottonseed", -- Item name for the seed
                plantProp = "p_tree_orange_01", -- Prop for the plant to be spawned
                soilRequired = false, -- If true, the seed will require soil to be planted
                soilAmount = 1, -- Amount of soil required to plant the seed
                soilName = "soil", -- Item name for the soil required to plant the seed
                fertilizerName = "fertilizerBlue", -- Item name for the fertilizer to fertilize the seed
                fertTimeReduction = 900, -- Time reduction in seconds when using fertilizer
                timeToGrow = 1800, -- Time in seconds for the plant to grow
                plantOffset = 1, -- If the plant is not on the ground properly you can use this setting
                jobLocked = false, -- If true, only players with the job will be able to harvest the plant
                rewards = {
                    {
                        itemName = "cotton",
                        amount = 4
                    }
                },
                jobs = {
                    'farmer',
                    'doctor'
                }
            }
,
 {

                webhooked = false, -- If true, it will send a message to the webhook when the plant is planted, and when it's harvested
                plantingToolRequired = true, -- If true, the player will need a tool to plant the seed
                plantingTool = "hoe", -- Item name for the tool required to plant the seed
                plantingToolDurability = 100, -- Durability of the tool required to plant the seed
                plantingToolUsage = 1, -- Durability usage of the tool required to plant the seed
                plantName = "cocoa", -- Name of the plant
                seedName = "cocoaseeds", -- Item name for the seed
                plantProp = "p_tree_orange_01", -- Prop for the plant to be spawned
                soilRequired = false, -- If true, the seed will require soil to be planted
                soilAmount = 1, -- Amount of soil required to plant the seed
                soilName = "soil", -- Item name for the soil required to plant the seed
                fertilizerName = "fertilizerBlue", -- Item name for the fertilizer to fertilize the seed
                fertTimeReduction = 900, -- Time reduction in seconds when using fertilizer
                timeToGrow = 1800, -- Time in seconds for the plant to grow
                plantOffset = 1, -- If the plant is not on the ground properly you can use this setting
                jobLocked = false, -- If true, only players with the job will be able to harvest the plant
                rewards = {
                    {
                        itemName = "cocoa",
                        amount = 4
                    }
                },
                jobs = {
                    'farmer',
                    'doctor'
                }
            }
,

{

                webhooked = false, -- If true, it will send a message to the webhook when the plant is planted, and when it's harvested
                plantingToolRequired = true, -- If true, the player will need a tool to plant the seed
                plantingTool = "hoe", -- Item name for the tool required to plant the seed
                plantingToolDurability = 100, -- Durability of the tool required to plant the seed
                plantingToolUsage = 1, -- Durability usage of the tool required to plant the seed
                plantName = "sugar", -- Name of the plant
                seedName = "sugarcaneseed", -- Item name for the seed
                plantProp = "p_tree_orange_01", -- Prop for the plant to be spawned
                soilRequired = false, -- If true, the seed will require soil to be planted
                soilAmount = 1, -- Amount of soil required to plant the seed
                soilName = "soil", -- Item name for the soil required to plant the seed
                fertilizerName = "fertilizerBlue", -- Item name for the fertilizer to fertilize the seed
                fertTimeReduction = 900, -- Time reduction in seconds when using fertilizer
                timeToGrow = 1800, -- Time in seconds for the plant to grow
                plantOffset = 1, -- If the plant is not on the ground properly you can use this setting
                jobLocked = false, -- If true, only players with the job will be able to harvest the plant
                rewards = {
                    {
                        itemName = "sugar",
                        amount = 4
                    }
                },
                jobs = {
                    'farmer',
                    'doctor'
                }
            }
,



 {

                webhooked = false, -- If true, it will send a message to the webhook when the plant is planted, and when it's harvested
                plantingToolRequired = true, -- If true, the player will need a tool to plant the seed
                plantingTool = "hoe", -- Item name for the tool required to plant the seed
                plantingToolDurability = 100, -- Durability of the tool required to plant the seed
                plantingToolUsage = 1, -- Durability usage of the tool required to plant the seed
                plantName = "onion", -- Name of the plant
                seedName = "onionseed", -- Item name for the seed
                plantProp = "p_tree_orange_01", -- Prop for the plant to be spawned
                soilRequired = false, -- If true, the seed will require soil to be planted
                soilAmount = 1, -- Amount of soil required to plant the seed
                soilName = "soil", -- Item name for the soil required to plant the seed
                fertilizerName = "fertilizerBlue", -- Item name for the fertilizer to fertilize the seed
                fertTimeReduction = 900, -- Time reduction in seconds when using fertilizer
                timeToGrow = 1800, -- Time in seconds for the plant to grow
                plantOffset = 1, -- If the plant is not on the ground properly you can use this setting
                jobLocked = false, -- If true, only players with the job will be able to harvest the plant
                rewards = {
                    {
                        itemName = "onoion",
                        amount = 4
                    }
                },
                jobs = {
                    'farmer',
                    'doctor'
                }
            }



        }
    },
    townSetup = {
        canPlantInTowns = false, -- If true, players will be able to plant seeds in towns
        townLocations = {
            {
                coords = vector3(-297.48,  791.1, 118.33), -- Valentine
                townRange = 150 -- Range where the town will be considered
            },
            {
                coords = vector3(2930.95, 1348.91, 44.1), -- Annesburg
                townRange = 150 -- Range where the town will be considered
            },
            {
                coords = vector3(2632.52, -1312.31, 51.42), -- Saint Denis
                townRange = 150 -- Range where the town will be considered
            },
            {
                coords = vector3(1346.14, -1312.5, 76.53), -- Rhodes
                townRange = 150 -- Range where the town will be considered
            },
            {
                coords = vector3(-1801.09, -374.86, 161.15), -- Strawberry
                townRange = 150 -- Range where the town will be considered
            },
            {
                coords = vector3(-801.77, -1336.43, 43.54), -- Blackwater
                townRange = 150 -- Range where the town will be considered
            },
            {
                coords = vector3(-3659.38, -2608.91, -14.08), -- Armadillo
                townRange = 150 -- Range where the town will be considered
            },
            {
                coords = vector3(-5498.97, -2950.61, -1.62), -- Tumbleweed
                townRange = 150 -- Range where the town will be considered
            }
        }
    }
}