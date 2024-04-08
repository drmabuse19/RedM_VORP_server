
-- Support https://discord.gg/cfxdev
Config = {
    brewProp = "mp006_p_moonshiner_still03x",
    mashProp = "model_name_for_barrel",
    brewTime = 5000,  -- Time taken to brew in milliseconds. Adjust accordingly.
    mashTime = 3000,   -- Time taken to create mash in milliseconds.
    brewAnimDict = 'cript_re@moonshine_camp@player_put_in_her',
    brewAnim = 'put_in_still',
    DeleteStillDict = 'mini_games@story@beechers@build_floor@john',
    DeleteStillAnim = 'intro_pickup',
    Brewing = {
        Requirements = {
            {item = "water", quantity = 2},  
            {item = "corn", quantity = 2},  

        },
        Rewards = {
            {item = "moonshine", quantity = 1}, 
        },
        FailureRate = 0.1,  -- 10% chance that brewing will fail. Adjust this as needed.
        FailurePenalty = {  -- If brewing fails
            removeRequirements = true,  -- If true, remove all required items even if brewing fails.
            rewardReduction = 0  -- If set to a value, reduce the reward by this much in case of failure.
        },
    },

      UsableItems = {
        ['moonshine'] = {
            removeItems = {
                {item = 'moonshine', count = 1},
            },
            addItems = {
               -- {item = '', count = 1}
            },
            notification = 'Drinking Moonshine',
           -- clientEffect = 'here'  -- specify client-side effect here
        },
        

    },
    Farming = {
        Crops = {
            {crop = "corn", growTime = 60000},  -- Grow time in seconds
            {crop = "wheat", growTime = 45000},
        },
        HarvestAnimDict = '',
        HarvestAnim = '',
        Locations = {
            {x = 123.4, y = 567.8, z = 90.1, radius = 10.0},  
            {x = 223.4, y = 267.8, z = 50.1, radius = 15.0},  
        
        },
    
    },
    Translation = {
        createAlcohol = "Press [E] to create alcohol",
        createMash = "Press [E] to create mash",
        destroyStill = "Press [F] to destroy (pickup) still",
        placeStill = "Press [G] to place still",
        startFarming = "Press [E] to start farming",
        farmingInProgress = "Farming in progress...",
        farmingComplete = "Farming complete!",
        notInFarmingArea = "You are not in a farming area",    
    }
}
