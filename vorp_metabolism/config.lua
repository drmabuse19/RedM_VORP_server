Config = {
  Locale = "en",

  UseMetabolism = true, -- Experimental Function

  -- Status amount rate drop
  EveryTimeStatusDown = 7200, --  3,6 seconds
  HowAmountThirstWhileRunning = 2, -- Example drop 3 every 3,6 seconds -- Max value 1000
  HowAmountHungerWhileRunning = 1,
  HowAmountThirst = 2,
  HowAmountHunger = 1,
  HowAmountMetabolismWhileRunning = 4,
  HowAmountMetabolism = 2,

  FirstHungerStatus = 1000, -- 100%
  FirstThirstStatus = 1000, -- 100%

  OnRespawnHungerStatus = 1000,
  OnRespawnThirstStatus = 1000,

  FirstMetabolismStatus = 0,

  ItemsToUse = {
    {
      Name = "water",
      Thirst = 300,
      Hunger = 0,
      Metabolism = 250,
      Stamina = 200,
      InnerCoreHealth = 10,
      OuterCoreHealth = 5,
      InnerCoreHealthGold = 0,
      OuterCoreHealthGold = 500,
      InnerCoreStaminaGold = 200,
      OuterCoreStaminaGold = 1000,
      PropName = "water",
      Animation = "drink",
      Effect = "",
      EffectDuration = ""
    },
    {
      Name = "apple",
      Thirst = 100,
      Hunger = 40,
      Metabolism = 500,
      Stamina = 100,
      InnerCoreHealth = 10,
      OuterCoreHealth = 5,
      InnerCoreHealthGold = 0.0,
      OuterCoreHealthGold = 0.0,
      InnerCoreStaminaGold = 0.0,
      OuterCoreStaminaGold = 0.0,
      PropName = "apple",
      Animation = "s_peach01x",
      Effect = "",
      EffectDuration = ""
    },
    {
      Name = "consumable_salmon_can",
      Thirst = 300,
      Hunger = 100,
      Metabolism = 300,
      Stamina = 100,
      InnerCoreHealth = 10,
      OuterCoreHealth = 5,
      InnerCoreHealthGold = 0.0,
      OuterCoreHealthGold = 0.0,
      InnerCoreStaminaGold = 0.0,
      OuterCoreStaminaGold = 0.0,
      PropName = "s_canbeansused01x",
      Animation = "eat",
      Effect = "",
      EffectDuration = ""
    },
    {
      Name = "consumable_medicine",
      Thirst = 100,
      Hunger = 0,
      Metabolism = 200,
      Stamina = 0,
      InnerCoreHealth = 60,
      OuterCoreHealth = 40,
      InnerCoreHealthGold = 500.0,
      OuterCoreHealthGold = 1000.0,
      InnerCoreStaminaGold = 0.0,
      OuterCoreStaminaGold = 0.0,
      PropName = "p_bottlemedicine01x",
      Animation = "drink",
      Effect = "",
      EffectDuration = ""
    },
    {
      Name = "consumable_cornedbeef_can",
      Thirst =  0,
      Hunger = 150,
      Metabolism = 100,
      Stamina = 120,
      InnerCoreHealth = 30,
      OuterCoreHealth = 15,
      InnerCoreHealthGold = 0.0,
      OuterCoreHealthGold = 0.0,
      InnerCoreStaminaGold = 0.0,
      OuterCoreStaminaGold = 0.0,
      PropName = "s_peach01x",
      Animation = "eat",
      Effect = "",
      EffectDuration = ""
    
  },    {
      Name = "consumable_coffee",
      Thirst =  500,
      Hunger = 0,
      Metabolism = 100,
      Stamina = 120,
      InnerCoreHealth = 70,
      OuterCoreHealth = 45,
      InnerCoreHealthGold = 0.0,
      OuterCoreHealthGold = 0.0,
      InnerCoreStaminaGold = 0.0,
      OuterCoreStaminaGold = 0.0,
      PropName = "s_peach01x",
      Animation = "drink",
      Effect = "",
      EffectDuration = ""
    },    {
      Name = "consumable_carrot",
      Thirst =  60,
      Hunger = 30,
      Metabolism = 300,
      Stamina = 100,
      InnerCoreHealth = 5,
      OuterCoreHealth = 45,
      InnerCoreHealthGold = 0.0,
      OuterCoreHealthGold = 0.0,
      InnerCoreStaminaGold = 0.0,
      OuterCoreStaminaGold = 0.0,
      PropName = "s_peach01x",
      Animation = "eat",
      Effect = "",
      EffectDuration = ""
    },    {
      Name = "consumable_biscuit_box",
      Thirst =   0,
      Hunger = 200,
      Metabolism = 600,
      Stamina = 140,
      InnerCoreHealth = 15,
      OuterCoreHealth = 5,
      InnerCoreHealthGold = 0.0,
      OuterCoreHealthGold = 0.0,
      InnerCoreStaminaGold = 0.0,
      OuterCoreStaminaGold = 0.0,
      PropName = "s_peach01x",
      Animation = "eat",
      Effect = "",
      EffectDuration = ""
    },    {
      Name = "bread",
      Thirst =   0,
      Hunger = 300,
      Metabolism = 600,
      Stamina = 140,
      InnerCoreHealth = 15,
      OuterCoreHealth = 5,
      InnerCoreHealthGold = 0.0,
      OuterCoreHealthGold = 0.0,
      InnerCoreStaminaGold = 0.0,
      OuterCoreStaminaGold = 0.0,
      PropName = "s_peach01x",
      Animation = "eat",
      Effect = "",
      EffectDuration = ""
    }

  
}

}

Translations = {
  ['en'] = {
    ['OnUseItem'] =  "Du har konsumert: %s"
  },
  ['pt_br'] = {
    ['OnUseItem'] =  "Você consumiu %s"
  },
  ['es'] = {
    ['OnUseItem'] =  "Has consumido %s"
  }
}
