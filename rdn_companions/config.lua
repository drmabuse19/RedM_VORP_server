-- Based on Malik's and Blue's animal shelters and vorp animal shelter, hunting/raising/tracking system added by HAL


Config = {}

Config.Locale = "en"

Config.Framework = "vorp" -- IMPORTANT: Put either "redem" or "vorp" depending on your framework. VORP users need to also change the Convar in .fxmanifest !!

Config.CallPetKey = true --Set to true to use the CallPet hotkey below

Config.TriggerKeys = {
    OpenShop = 'G',
    CallPet = 'U'
}

--The attack command sets your animal to attack a target
Config.AttackCommand = true -- Set true to be able to send your pet to attack a target you are locked on (holding right-click on them)

--<<Only have one of these 3 be true or all 3 false if you want the attack prompt on all targets
Config.AttackOnlyPlayers = false -- The attack command works on only player peds
Config.AttackOnlyAnimals = false -- The attack command works on animal types, not players/peds
Config.AttackOnlyNPC = false -- If this is enabled, you can attack NPC peds and animals but not people
-->>

--The track command sets your animal to follow the selected target 
Config.TrackCommand = true -- If this is enabled, you can send pets to track a target you are locked on

--<<Only have one of these 3 be true or all 3 false if you want the track prompt on all targets
Config.TrackOnlyPlayers = false -- The track command works on only player peds
Config.TrackkOnlyAnimals = false -- The track command works on animal types, not players/peds
Config.TrackOnlyNPC = false -- If this is enabled, you can track NPC peds and animals but not people
-->>


Config.DefensiveMode = true --If set to true, pets will become hostile to anything you are in combat with


Config.NoFear = true --Set this to true if you are using Bears/Wolves as pets so that your horses won't be in constant fear and wont get stuck on the eating dead body animation.


Config.AnimalTrackingJobOnly = false -- If true only people with the jobs below can use the tracking option
Config.AnimalTrackingJobs = {
	[1] = 'police',
	[2] = 'hunter',
}

Config.SearchRadius = 50.0 -- How far the pet will search for a hunted animal. Always a float value i.e 50.0
Config.FeedInterval = 1 -- How often in seconds the pet will want to be fed

Config.RaiseAnimal = false -- If this is enabled, you will have to feed your animal for it to gain XP and grow. Only full grown pets can use commands (halfway you get the Stay command)

Config.FullGrownXp = 200 -- The amount of XP that it is fully grown. At the halfway point the pet will grow to 50% of max size.
Config.XpPerFeed = 20 -- The amount of XP every feed gives
Config.NotifyWhenHungry = true -- Puts up a little notification letting you know your pet can be fed. 
Config.AnimalFood = 'meat' -- The item required to feed and/or level up your pet


Config.Shops = {
    {
        Name = 'Animal Shelter',
        Ring = false,
        ActiveDistance = 5.0,
        Coords = {
            vector3(-273.51,689.26,112.45)
        },
        Spawndog = vector4( -284.09, 685.34, 113.59, 234.45 ),
        Blip = { sprite = -1646261997, x = -273.51, y = 689.26, z = 113.41 }
    },
{
        Name = 'Animal Shelter',
        Ring = false,
        ActiveDistance = 5.0,
        Coords = {
           vector3(2442.02, -1296.57, 45.84)
        },
        Spawndog =vector4(2449.06, -1301.78, 45.84, 245.78),
        Blip = { sprite = -1646261997, x = 2441.94, y = -1298.6, z = 45.84 }
    }

}

Config.PetAttributes = {
    FollowDistance = 5,
    Invincible = false,
    SpawnLimiter = 0, -- Set this to limit how often a pet can be spawned or 0 to disable it
    DeathCooldown = 0 -- Time before a pet can be respawned after dying
}


Config.Animals = { --These are the animals the dogs will retrieve
	 --Hash ID must be the ID of the table
	[-1003616053] =  {["name"] = "Duck", },
    [1459778951] =  {["name"] = "Eagle", },
	[-164963696] = {["name"] = "Herring Seagull",},
	[-1104697660] = {["name"] = "Vulture",},
	[-466054788] = {["name"] = "Wild Turkey",},
    [-2011226991] = {["name"] = "Wild Turkey",},
    [-166054593] = {["name"] = "Wild Turkey",},
	[-1076508705] =  {["name"] = "Roseate Spoonbill",},
	[-466687768] =  {["name"] = "Red-Footed Booby",},
	[-575340245] =  {["name"] = "Wester Raven",},
	[1416324601] =  {["name"] = "Ring-Necked Pheasant",},
	[1265966684] =  {["name"] = "American White Pelican",},
	[-1797450568] =  {["name"] = "Blue And Yellow Macaw",},
	[-2073130256] =  {["name"] = "Double-Crested Cormorant",},
	[-564099192] =  {["name"] = "Whooping Crane",},
	[723190474] =  {["name"] = "Canada Goose",},
	[-2145890973] =  {["name"] = "Ferruinous Hawk",},
	[1095117488] =  {["name"] = "Great Blue Heron",},
	[386506078] =  {["name"] = "Common Loon",},
	[-861544272] =  {["name"] = "Great Horned Owl",},
}

-- Pets availability will only be limited if the object exists in the pet config.
Config.Pets = {
    {
        Text = "$200 - Husky",
        SubText = "",
        Desc = "Best pet you'll ever have",
        Param = {
            Price = 200,
            Model = "A_C_DogHusky_01",
            Level = 1
        }
    },
    {
        Text = "$50 - Mutt",
        SubText = "",
        Desc = "Best pet you'll ever have",
        Param = {
            Price = 50,
            Model = "A_C_DogCatahoulaCur_01",
            Level = 1
        }
    },
    {
        Text = "$100 - Labrador Retriever",
        SubText = "",
        Desc = "Best pet you'll ever have",
        Param = {
            Price = 100,
            Model = "A_C_DogLab_01",
            Level = 1
        }
    },
    {
        Text = "$100 - Rufus",
        SubText = "",
        Desc = "Best pet you'll ever have",
        Param = {
            Price = 100,
            Model = "A_C_DogRufus_01",
            Level = 1
        }
    },
    {
        Text = "$150 - Coon Hound",
        SubText = "",
        Desc = "Best pet you'll ever have",
        Param = {
            Price = 150,
            Model = "A_C_DogBluetickCoonhound_01",
            Level = 1
        }
    },
        {
        Text = "$150 - Hound Dog",
        SubText = "",
        Desc = "Best pet you'll ever have",
        Param = {
            Price = 150,
            Model = "A_C_DogHound_01",
            Level = 1
        }
    }, 
    {
        Text = "$200 - Border Collie",
        SubText = "",
        Desc = "Best pet you'll ever have",
        Param = {
            Price = 200,
            Model = "A_C_DogCollie_01",
            Level = 1
        }
    },
    {
        Text = "$200 - Poodle",
        SubText = "",
        Desc = "Best pet you'll ever have",
        Param = {
            Price = 200,
            Model = "A_C_DogPoodle_01",
            Level = 1
        }
    },
    
    {
        Text = "$100 - Foxhound",
        SubText = "",
        Desc = "Best pet you'll ever have",
        Param = {
            Price = 100,
            Model = "A_C_DogAmericanFoxhound_01",
            Level = 1
        }
    },
    {
        Text = "$100 - Australian Shephard",
        SubText = "",
        Desc = "Best pet you'll ever have",
        Param = {
            Price = 100,
            Model = "A_C_DogAustralianSheperd_01",
            Level = 1
        }
    },
}

Config.Keys = { ['G'] = 0x760A9C6F, ["B"] = 0x4CC0E2FE, ['S'] = 0xD27782E3, ['W'] = 0x8FD015D8, ['H'] = 0x24978A28, ['U'] = 0xD8F73058, ["R"] = 0x0D55A0F0, ["ENTER"] = 0xC7B5340A, ['E'] = 0xDFF812F9, ["J"] = 0xF3830D8E }
