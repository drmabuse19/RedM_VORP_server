--------------------------------------------------------------------------------
----------------------------------- DevDokus -----------------------------------
--------------------------------------------------------------------------------
-- Temperature Settings
Temperature   = {
  Format      = 'C',                          -- Set it to C or F
  Max         = 29,                           -- Max Temp before losing more vitals stats.
  Min         = 10,                          -- Min Temp before losing more vitals stats.
  ColdDamage  = { Water = 0.05, Food = 0.1 }, -- Amount of drain per second below min Temp
  HotDamage   = { Water = 0.25, Food = 0.01}, -- Amount of drain per second above max Temp
}

-- Food Settings
Food = {
  DrainIdle = 0.01,                           -- Amount of drain when standing still
  DrainRunning = 0.20,                        -- Amount of drain when running
  DrainWalking = 0.03,                        -- Amount of drain when walking
  LoseWhen = 10.0,                            -- Losing innercore health below this threshold
  DamagePerSec = 1.0,                         -- Amount of damage on innercore health per second.
}

-- Water Settings
Water = {
  DrainIdle = 0.02,                            -- Amount of drain when standing still
  DrainRunning = 0.20,                         -- Amount of drain when running
  DrainWalking = 0.05,                         -- Amount of drain when walking
  LoseWhen = 10.0,                             -- Losing innercore health below this threshold
  DamagePerSec = 1.0,                          -- Amount of damage on innercore health per second.
}
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- ATTENTION --
-- I am still busy with expanding this script and giving it more
-- functionality. Visit my Github regularly to see if there are new updates.
-- Thank you for using this script, I hope you enjoy :)
--------------------------------------------------------------------------------
