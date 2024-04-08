Config = {}

Config.HealthRegen = {
    Active = false,                 -- true / false
    MinHealthToStartRegen = 50,     -- Health at which regen starts while knocked out
    MaxHealthToStopRegen = 250,     -- Stops the health regen to stop abuse
    HealthPerTick = 2,              -- How much each tick gives you for health
    HeathTimeTick = 2,              -- How many seconds between health regen ticks
}

Config.KnockedOut = {
    RandomChance = true,            -- true / false - if true, once a player reaches the MinHealthToBeKnockedOut, knockouts can happen. If false, knockout will occur on first hit after players reached MinHealthToBeKnockedOut
    AddedScreenEffect = 'LARGE_EXPLOSION_SHAKE',    -- If you want to disable set to false
    AddedEffectIntensity = 2.5,     -- 2.5 standard MUST USE FLOAT 0.0
    MinHealthToBeKnockedOut = 200,  -- Health at which there is a change to be knocked out
    KnockedOutTimeMin = 15,         -- How many seconds player will be down at a minimum from being knocked out
    KnockedOutTimeMax = 20,         -- How many seconds player will be down at a maximum from being knocked out
    OnScreenTextActive = true,      -- true / false
    OnScreenText = "You have been knocked out!",
}
