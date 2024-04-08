Config = {}


Config.interactiondist = 2.5 -- distance to interact with location

Config.locations = { -- list of all crafting locations
   
    ["location1"] = {x = 0,y = 0,z =0},
}

Config.craftingprops = {"p_campfire02x","p_campfirecombined02x","p_campfirecombined03x","p_kettle03x","p_campfirecombined04x"}

Config.crafting = {
    [1] = {
        ['Text'] = "Boiled Egg  - 1xEgg, 1xWater",
        ['SubText'] = "",
        ['Desc'] = "",
        ['Param'] = {
            ['Item'] = "eggs",
            ['Item2'] = "water",
            ['Item3'] = "",
            ['Count'] = 1,
            ['Count2'] = 1,
            ['Count3'] = 0,
            ['Reward'] ={{ name = "boiledegg", count = 1}},
            ['Job'] = {"cook"}, -- the job required
            ['prop'] = 0, -- 0 means any
            ['location'] = {"location1"}, -- keep 0 to allow crafting from any marked location

        }
    }, 
     [2] = {
        ['Text'] = "Dried Salmon  - 1xSockeye Salmon, 1xSalt", -- name of item to craft on list
        ['SubText'] = "",
        ['Desc'] = "",
        ['Param'] = {
            ['Item'] = "a_c_fishsalmonsockeye_01_ms", 
            ['Item2'] = "salt", 
            ['Item3'] = "",
            ['Count'] = 1, 
            ['Count2'] = 1, 
            ['Count3'] = 0,
            ['Reward'] ={{ name = "consumable_salmon", count = 1}},
            ['Job'] = 0, 
            ['prop'] = {"p_campfire02x","p_campfirecombined02x","p_campfirecombined03x","p_kettle03x"}, -- will only show in those 2 props 
            ['location'] = {"location1","location2"}, -- this item can only be crafted in location 1 and 2 

        }
    },
    [3] = {
        ['Text'] = "Cooked Bluegil with Veggies - 1xSmall Bluegil, 1xCarrot and 1xCorn",
        ['SubText'] = "",
        ['Desc'] = "",
        ['Param'] = {
            ['Item'] = "a_c_fishbluegil_01_sm",
            ['Item2'] = "carrots",
            ['Item3'] = "consumable_corn",
            ['Count'] = 1,
            ['Count2'] = 1,
            ['Count3'] = 1,
            ['Reward'] ={{ name = "cookedbluegil", count = 1}},
            ['Job'] = 0, -- the job required
            ['prop'] = 0, -- 0 means any
            ['location'] = 0, 

        }
    },
    [4] = {
        ['Text'] = "ChocolateBar - 2xCocoa and 3xSugar",
        ['SubText'] = "",
        ['Desc'] = "",
        ['Param'] = {
            ['Item'] = "cocoa",
            ['Item2'] = "sugar",
            ['Item3'] = "",
            ['Count'] = 2,
            ['Count2'] = 3,
            ['Count3'] = 0,
            ['Reward'] ={{ name = "consumable_chocolate_bar", count = 1}},
            ['Job'] = 0, -- the job required
            ['prop'] = 0, -- 0 means any
            ['location'] = 0, 

        }
    },
    [5] = {
        ['Text'] = "Fruit Salad - 2xBlack Berry, 1xBlack Currant and 1xCreekplum",
        ['SubText'] = "",
        ['Desc'] = "",
        ['Param'] = {
            ['Item'] = "Black_Berry",
            ['Item2'] = "Black_Currant",
            ['Item3'] = "Creekplum",
            ['Count'] = 2,
            ['Count2'] = 1,
            ['Count3'] = 1,
            ['Reward'] ={{ name = "consumable_fruitsalad", count = 1}},
            ['Job'] = 0, -- the job required
            ['prop'] = 0, -- 0 means any
            ['location'] = 0, 

        } 
    },
    [6] = {
        ['Text'] = "Jerkied Meat - 2xMeat and 2xSalt",
        ['SubText'] = "",
        ['Desc'] = "",
        ['Param'] = {
            ['Item'] = "meat",
            ['Item2'] = "salt",
            ['Item3'] = "",
            ['Count'] = 2,
            ['Count2'] = 2,
            ['Count3'] = 0,
            ['Reward'] ={{ name = "beefjerky", count = 1}},
            ['Job'] = 0, -- the job required
            ['prop'] = 0, -- 0 means any
            ['location'] = 0, 

        }
    },
    [7] = {
        ['Text'] = "Dried Bluegil - 2xSalt, 1xMedium Bluegil",
        ['SubText'] = "",
        ['Desc'] = "",
        ['Param'] = {
            ['Item'] = "salt",
            ['Item2'] = "meat",
            ['Item3'] = "",
            ['Count'] = 2,
            ['Count2'] = 1,
            ['Count3'] = 0,
            ['Reward'] ={{ name = "consumable_bluegil", count = 1}},
            ['Job'] = 0, -- the job required
            ['prop'] = 0, -- 0 means any
            ['location'] = 0, 

        }
    },
    [8] = {
        ['Text'] = "Cooked Trout  - 1xRainbow Trout, 1xCrows_Garlic, 1xOleander Sage",
        ['SubText'] = "",
        ['Desc'] = "",
        ['Param'] = {
            ['Item'] = "a_c_fishrainbowtrout_01_ms",
            ['Item2'] = "Crows_Garlic",
            ['Item3'] = "Oleander_Sage",
            ['Count'] = 1,
            ['Count2'] = 1,
            ['Count3'] = 1,
            ['Reward'] ={{ name = "consumable_trout", count = 1}},
            ['Job'] = 0, -- the job required
            ['prop'] = 0, -- 0 means any
            ['location'] = 0, 

        }
    },
    [9] = {
        ['Text'] = "Jerkied GameMeat - 1xGamey Meat, 2xSalt",
        ['SubText'] = "",
        ['Desc'] = "",
        ['Param'] = {
            ['Item'] = "Gamey_Meat",
            ['Item2'] = "salt",
            ['Item3'] = "",
            ['Count'] = 1,
            ['Count2'] = 2,
            ['Count3'] = 0,
            ['Reward'] ={{ name = "consumable_game", count = 1}},
            ['Job'] = 0, -- the job required
            ['prop'] = 0, -- 0 means any
            ['location'] = 0, 

        }
    },
    [10] = {
        ['Text'] = "Raspberry Water - 1xSugar, 1xWater, 1xRedRaspberry",
        ['SubText'] = "",
        ['Desc'] = "",
        ['Param'] = {
            ['Item'] = "sugar",
            ['Item2'] = "water",
            ['Item3'] = "Red_Raspberry",
            ['Count'] = 1,
            ['Count2'] = 1,
            ['Count3'] = 1,
            ['Reward'] ={{ name = "consumable_raspberrywater", count = 1}},
            ['Job'] = 0, -- the job required
            ['prop'] = 0, -- 0 means any
            ['location'] = 0, 

        }
    },
     [11] = {
        ['Text'] = "Cigarette - 1xIndian Tobbaco, 1xRolling paper",
        ['SubText'] = "",
        ['Desc'] = "",
        ['Param'] = {
            ['Item'] = "Indian_Tobbaco",
            ['Item2'] = "rollingpaper",
            ['Item3'] = "",
            ['Count'] = 1,
            ['Count2'] = 1,
            ['Count3'] = 0,
            ['Reward'] ={{ name = "cigarette", count = 1}},
            ['Job'] = 0, -- the job required
            ['prop'] = 0, -- 0 means any
            ['location'] = 0, 

        }
    },
    [12] = {
        ['Text'] = "Cigar - 2xIndian Tobbaco, 1xRolling paper",
        ['SubText'] = "",
        ['Desc'] = "",
        ['Param'] = {
            ['Item'] = "Indian_Tobbaco",
            ['Item2'] = "rollingpaper",
            ['Item3'] = "",
            ['Count'] = 2,
            ['Count2'] = 1,
            ['Count3'] = 0,
            ['Reward'] ={{ name = "cigar", count = 1}},
            ['Job'] = 0, -- the job required
            ['prop'] = 0, -- 0 means any
            ['location'] = 0, 

        }
    },
    [13] = {
        ['Text'] = "Caramel - 2xSugar and 2xMilk",
        ['SubText'] = "",
        ['Desc'] = "",
        ['Param'] = {
            ['Item'] = "sugar",
            ['Item2'] = "milk",
            ['Item3'] = "",
            ['Count'] = 2,
            ['Count2'] = 2,
            ['Count3'] = 0,
            ['Reward'] ={{ name = "Caramel", count = 5}},
            ['Job'] = 0, -- the job required
            ['prop'] = 0, -- 0 means any
            ['location'] = 0, 

        }
    },
    [14] = {
        ['Text'] = "Heroin - 2xMorphine 2xAcid and 2xBlood Flower",
        ['SubText'] = "",
        ['Desc'] = "",
        ['Param'] = {
            ['Item'] = "morphine",
            ['Item2'] = "acid",
            ['Item3'] = "Blood_Flower",
            ['Count'] = 2,
            ['Count2'] = 2,
            ['Count3'] = 2,
            ['Reward'] ={{ name = "heroin", count = 1}},
            ['Job'] = 0, -- the job required
            ['prop'] = 0, -- 0 means any
            ['location'] = 0, 

        }
    },
    [15] = {
        ['Text'] = "GoldBar - 15xGold nugget",
        ['SubText'] = "",
        ['Desc'] = "",
        ['Param'] = {
            ['Item'] = "goldnugget",
            ['Item2'] = "",
            ['Item3'] = "",
            ['Count'] = 15,
            ['Count2'] = 0,
            ['Count3'] = 0,
            ['Reward'] ={{ name = "goldbar", count = 1}},
            ['Job'] = 0, -- the job required
            ['prop'] = 0, -- 0 means any
            ['location'] = 0, 

        }
    },
    [16] = {
        ['Text'] = "Pipe - 2xWood, 1xIron and 2xCopper",
        ['SubText'] = "",
        ['Desc'] = "",
        ['Param'] = {
            ['Item'] = "wood",
            ['Item2'] = "clay",
            ['Item3'] = "copper",
            ['Count'] = 2,
            ['Count2'] = 1,
            ['Count3'] = 2,
            ['Reward'] ={{ name = "pipe", count = 1}},

            ['Job'] = 0, -- the job required
            ['prop'] = 0, -- 0 means any
            ['location'] = 0, 

        }
    },
    [17] = {
        ['Text'] = "Beer - 2xBitterWeed and 1xAlcohol",
        ['SubText'] = "",
        ['Desc'] = "",
        ['Param'] = {
            ['Item'] = "Bitter_Weed",
            ['Item2'] = "alcohol",
            ['Item3'] = "",
            ['Count'] = 2,
            ['Count2'] = 1,
            ['Count3'] = 0,
            ['Reward'] ={{ name = "beer", count = 1}},
            ['Job'] = {"saloon","bastille"}, -- the job required
            ['prop'] = 0, -- 0 means any
            ['location'] = 0, 

        }
    },
    [18] = {
        ['Text'] = "Wine - 2xBlackberry and 1xAlcohol",
        ['SubText'] = "",
        ['Desc'] = "",
        ['Param'] = {
            ['Item'] = "Black_Berry",
            ['Item2'] = "alcohol",
            ['Item3'] = "",
            ['Count'] = 2,
            ['Count2'] = 1,
            ['Count3'] = 0,
            ['Reward'] ={{ name = "wine", count = 1}},
            ['Job'] = {"saloon","bastille"}, -- the job required
            ['prop'] = 0, -- 0 means any
            ['location'] = 0, 

        }
    },
    [19] = {
        ['Text'] = "Blackberry Water - 1xSugar, 1xWater, 1xBlackBerry",
        ['SubText'] = "",
        ['Desc'] = "",
        ['Param'] = {
            ['Item'] = "sugar",
            ['Item2'] = "water",
            ['Item3'] = "Black_Berry",
            ['Count'] = 1,
            ['Count2'] = 1,
            ['Count3'] = 1,
            ['Reward'] ={{ name = "consumable_raspberrywater", count = 1}},
            ['Job'] = 0, -- the job required
            ['prop'] = 0, -- 0 means any
            ['location'] = 0, 

        }
    },
    [20] = {
        ['Text'] = "Snake Oil - 1xSnakeSkin, 1xAcid, 2xBitter Weed",
        ['SubText'] = "",
        ['Desc'] = "",
        ['Param'] = {
            ['Item'] = "SnakeSkin",
            ['Item2'] = "acid",
            ['Item3'] = "Bitter_Weed",
            ['Count'] = 1,
            ['Count2'] = 1,
            ['Count3'] = 2,
            ['Reward'] ={{ name = "Snake_Poison", count = 1}},
            ['Job'] = 0, -- the job required
            ['prop'] = 0, -- 0 means any
            ['location'] = 0, 

        }
    },
    [21] = {
        ['Text'] = "Herbal Med - 2xParasolMushroom, 2xEnglishMace, 2xCreepingThyme",
        ['SubText'] = "",
        ['Desc'] = "",
        ['Param'] = {
            ['Item'] = "Parasol_Mushroom",
            ['Item2'] = "English_Mace",
            ['Item3'] = "Creeking_Thyme",
            ['Count'] = 2,
            ['Count2'] = 2,
            ['Count3'] = 2,
            ['Reward'] ={{ name = "herbmed", count = 1}},
            ['Job'] = 0, -- the job required
            ['prop'] = 0, -- 0 means any
            ['location'] = 0, 

        }
    },

    [22] = {
        ['Text'] = "BlackBerry Ale - 1xBitterWeed, 2xBlackBerry 1xAlcohol",
        ['SubText'] = "",
        ['Desc'] = "",
        ['Param'] = {
            ['Item'] = "Bitter_Weed",
            ['Item2'] = "Black_Berry",
            ['Item3'] = "alcohol",
            ['Count'] = 1,
            ['Count2'] = 2,
            ['Count3'] = 1,
            ['Reward'] ={{ name = "blackberryale", count = 1}},
            ['Job'] = {"saloon","bastille"}, -- the job required
            ['prop'] = 0, -- 0 means any
            ['location'] = 0, 

        }
    },

    [23] = {
        ['Text'] = "Raspberry Ale - 1xBitterWeed, 2xRedRaspberry 1xAlcohol",
        ['SubText'] = "",
        ['Desc'] = "",
        ['Param'] = {
            ['Item'] = "Bitter_Weed",
            ['Item2'] = "Red_Raspberry",
            ['Item3'] = "alcohol",
            ['Count'] = 1,
            ['Count2'] = 2,
            ['Count3'] = 1,
            ['Reward'] ={{ name = "raspberryale", count = 1}},
            ['Job'] = {"saloon","bastille"}, -- the job required
            ['prop'] = 0, -- 0 means any
            ['location'] = 0, 

        }
    },

    [24] = {
        ['Text'] = "Syn - 1x Synpackage",
        ['SubText'] = "",
        ['Desc'] = "",
        ['Param'] = {
            ['Item'] = "synpackage",
            ['Item2'] = "",
            ['Item3'] = "",
            ['Count'] = 1,
            ['Count2'] = 0,
            ['Count3'] = 0,
            ['Reward'] ={{ name = "syn", count = 5}},
            ['Job'] = {"saloon","bastille"}, -- the job required
            ['prop'] = 0, -- 0 means any
            ['location'] = 0, 

        }
    },
    
    [25] = {
        ['Text'] = "Breakfast  - 2xEgg, 2xmeat, 1xsalt",
        ['SubText'] = "",
        ['Desc'] = "",
        ['Param'] = {
            ['Item'] = "eggs",
            ['Item2'] = "meat",
            ['Item3'] = "salt",
            ['Count'] = 2,
            ['Count2'] = 2,
            ['Count3'] = 1,
            ['Reward'] ={{ name = "consumable_breakfast", count = 1}},
            ['Job'] = 0, -- the job required
            ['prop'] = 0, -- 0 means any
            ['location'] = 0, 

        }
    },
    [26] = {
        ['Text'] = "Edible Veggies - 1xCrowsGarlic, 1xParasolMushroom, 1xWildCarrot",
        ['SubText'] = "",
        ['Desc'] = "",
        ['Param'] = {
            ['Item'] = "Crows_Garlic",
            ['Item2'] = "Parasol_Mushroom",
            ['Item3'] = "Wild_Carrot",
            ['Count'] = 1,
            ['Count2'] = 1,
            ['Count3'] = 1,
            ['Reward'] ={{ name = "consumable_veggies", count = 1}},
            ['Job'] = 0, -- the job required
            ['prop'] = 0, -- 0 means any
            ['location'] = 0, 

        }
    },

    [27] = {
        ['Text'] = "Bottled Water - 1xGlass Bottle, 1xFull Water Bucket",
        ['SubText'] = "",
        ['Desc'] = "",
        ['Param'] = {
            ['Item'] = "glassbottle",
            ['Item2'] = "wateringcan",
            ['Item3'] = "",
            ['Count'] = 1,
            ['Count2'] = 1,
            ['Count3'] = 0,
            ['Reward'] ={{ name = "water", count = 1},{ name = "wateringcan_empty", count = 1}},
            ['Job'] = 0, -- the job required
            ['prop'] = 0, -- 0 means any
            ['location'] = 0, 

        }
    },

    [28] = {
        ['Text'] = "Ginseng Tea - 1xWater, 1xSugar, 1xAmericanGinseng ",
        ['SubText'] = "",
        ['Desc'] = "",
        ['Param'] = {
            ['Item'] = "water",
            ['Item2'] = "sugar",
            ['Item3'] = "American_Ginseng",
            ['Count'] = 1,
            ['Count2'] = 1,
            ['Count3'] = 1,
            ['Reward'] ={{ name = "ginsengtea", count = 1}},
            ['Job'] = 0, -- the job required
            ['prop'] = 0, -- 0 means any
            ['location'] = 0, 

        }
    },

    

}