----------------------------------------------------------------------------------------------------
--------------------------------------- CONFIG -----------------------------------------------------
-- VORP INVENTORY LUA*

Lang = "English"

Config = {
	--======================= DEVELOPMENT ==============================--
	Debug                    = false, -- if your server is live set this to false.  to true only if you are testing things
	DevMode                  = true, -- if your server is live set this to false.  to true only if you are testing things (auto load inventory when script restart and before character selection. Alos add /getInv command)
	dbupdater                = true,
	--======================= CONFIGURATION =============================--
	ShowCharacterNameOnGive  = true, -- when giving an item, show the character name of nearby players instead of their player ID. if set to false, show the player ID
	DoubleClickToUse         = true, -- if toggled to false, items in inventory will right click then left click "use"
	NewPlayers               = true, --- if you dont want new players to give money or items then set to true. this can avoid cheaters giving stuff on first join
	-- GOLD ITEM LIKE DOLLARS
	UseRolItem               = false, -- to show rol in inventory
	UseGoldItem              = false,
	AddGoldItem              = false, -- Should there be an item in inventory to represent gold
	AddDollarItem            = true, -- Should there be an item in inventory to represent dollars
	AddAmmoItem              = false, -- Should there be an item in inventory to represent the gun belt
	InventorySearchable      = true, -- Should the search bar appear in inventories
	InventorySearchAutoFocus = true, -- Search autoofocuses when you type
	-- DEATH FUNCTIONS
	DisableDeathInventory    = true, -- prevent the ability to access inventory while dead
	--{ I } OPEN INVENTORY
	OpenKey                  = 0xC1989F95,
	--RMB mouse PROMPT PICKUP
	PickupKey                = 0xF84FA74F,
	discordid                = true, -- turn to true if ur using discord whitelist
	DeleteOnlyDontDrop       = false, -- if true then dropping items only deletes from inventory and box on the floor is not created


	-- =================== CLEAR ITEMS WEAPONS MONEY GOLD =====================--


	UseClearAll     = false, -- if you want to use the clear item function if false will use DropOnDeath function
	OnPlayerRespawn = {
		Money = {
			JobLock         = { "police", "doctor" },
			ClearMoney      = true, -- if true then removes all money from player
			MoneyPercentage = false, -- if false wont use percentage if you add number   0.1 = 10% of money user have instead of all
		},
		Items = {
			JobLock       = { "police", "doctor" },
			itemWhiteList = { "consumable_raspberrywater", "ammorevolvernormal" }, -- if you dont want an item a user could have to be deleted
			AllItems      = true,                                         -- if true then removes all items from player
		},
		Weapons = {
			JobLock           = { "police", "doctor" },
			WeaponWhitelisted = { "WEAPON_MELEE_KNIFE", "WEAPON_BOW" }, -- if you dont want a weapon a user could have to be deleted
			AllWeapons        = true,                          -- if true then removes all weapons from player
		},
		Ammo = {
			JobLock = { "police", "doctor" },
			AllAmmo = true, -- if true then removes all ammo from player
		},
		Gold = {
			JobLock        = { "police", "doctor" },
			ClearGold      = false, -- if false wont remove any Gold
			GoldPercentage = false, -- if true and above false then it uses apercentage  0.1 = 10% of Gold user have instead of all
		}
	},

	-- =================== DROP ON DEATH =====================--

	DropOnRespawn   = {
		AllMoney       = true,
		PartMoney      = false,
		PartPercentage = 25,
		Gold           = false, -- TRUE ONLY IF UseGoldItem = true
		Weapons        = true,
		Items          = true
	},


	-- HOW MANY WEAPONS AND ITEMS ALLOWED PER PLAYER
	MaxItemsInInventory = {
		Weapons = 10,
		Items = 500,
	},
	-- HERE YOU CAN SET THE MAX AMOUNT OF WEAPONS PER JOB (IF YOU WANT)
	JobsAllowed         = {
		police = 20 -- job name and max weapons allowed dont allow less than the above
	},
	-- FIRST JOIN
	startItems          = {
		water = 2, --ITEMS SAME NAME AS IN DATABASE
		ammorevolvernormal = 1   --AMMO SAME NAME AS I NTHE DATABASE
	},

	startWeapons        = {
		"WEAPON_MELEE_KNIFE" --WEAPON HASH NAME
	},

	-- items that dont get added up torwards your max weapon count
	notweapons          = {
		"WEAPON_KIT_BINOCULARS_IMPROVED",
		"WEAPON_KIT_BINOCULARS",
		"WEAPON_FISHINGROD",
		"WEAPON_KIT_CAMERA",
		"WEAPON_kIT_CAMERA_ADVANCED",
		"WEAPON_MELEE_LANTERN",
		"WEAPON_MELEE_DAVY_LANTERN",
		"WEAPON_MELEE_LANTERN_HALLOWEEN",
		"WEAPON_KIT_METAL_DETECTOR",
		"WEAPON_MELEE_HAMMER",
		"WEAPON_MELEE_KNIFE",
	},
	-- weapons that are considered non throwables
	nonAmmoThrowables   = {
		"WEAPON_MELEE_CLEAVER",
		"WEAPON_MELEE_HATCHET",
		"WEAPON_MELEE_HATCHET_HUNTER"
	},
	-- weapons that dont need serial numbers
	noSerialNumber      = {
		"WEAPON_MELEE_CLEAVER",
		"WEAPON_MELEE_HATCHET",
		"WEAPON_MELEE_HATCHET_HUNTER",
		"WEAPON_MELEE_KNIFE",
		"WEAPON_KIT_BINOCULARS_IMPROVED",
		"WEAPON_KIT_BINOCULARS",
		"WEAPON_FISHINGROD",
		"WEAPON_KIT_CAMERA",
		"WEAPON_kIT_CAMERA_ADVANCED",
		"WEAPON_MELEE_LANTERN",
		"WEAPON_MELEE_DAVY_LANTERN",
		"WEAPON_MELEE_LANTERN_HALLOWEEN",
		"WEAPON_KIT_METAL_DETECTOR",
		"WEAPON_MELEE_HAMMER",
		"WEAPON_BOW",
		"WEAPON_BOW_IMPROVED",
		"WEAPON_LASSO",
		"WEAPON_LASSO_REINFORCED",
	}

}
