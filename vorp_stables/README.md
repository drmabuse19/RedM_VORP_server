# vorp_stables-lua

**based on stables from C# version**

It is with great pleasure that I will introduce you to this plugin. The goal of it's making was to allow an easier workflow on vorp_stables, and to add a few features.

### TL;DR
- [For tips on how to use this plugin in-game](#Usage)
- [For directions on the Config files](#Config)
- [For developper info](#Developpers)
- **[To keep the inventory from Vorp_Stables](#Migration)**


## New features
- **Hard death** : You can now choose to activate a hard death for horses. On each death they will suffer long-term damages and when a threshold is reached, they are permanently dead. Everything is configurable.
- **Custom vendor inventories** : you can now chose to limit the horses, carts and equipment a vendor sells.
- **Inventory system change** : The horses inventories are now controlled by vorp_inventory rather than the plugin itself (cf. migration)

## Upcoming features
- **Groom job** : the goal will be to buy/sell wild horses and train them to get a full groom RP experience.

## Usage
Keys aren't customizable yet, but might be in a future update.

### Basic Interactions

- **G** : Open stable vendor when in range
- **U** : Open ride inventory when in range (5)
- **H** : Call default horse
- **J** : Call default carriage
- **SPACEBAR** : Your horse stops following you
- **Ctrl + Spacebar** : Prance when mounted

### Focus Interactions
Focus on horse to activate those (**right click**)
- **B** : Brush horse (removes dirt)
- **F** : Horse flees and despawns
- **E** : Your horse now follows you

### UI
- The UI is used with the mouse
- **When arrows left and right are shown, there's no clicking on it, use left and right on the keyboard !**

### Ride transfer
You can transfer a horse/carriage to any other player, with a price or not. Your offer will first be registered on the server, then when the player next goes to a vendor, they'll have the option to accept your offer or not.

### Equipment
When you buy equiment, it is then stored in your stable inventory, and you can access it from the "Change equipment Menu" **Noting prevents you from buying the same Item twice so just be careful !**

## Migration
The inventory system for horses and carriages has been modified. You will need to run the migration script to let your players keep their rides inventories.

To do so (linux): 
- cd PATH_TO_PLUGIN/Migrations
- npm i
- npm start
- Ctrl + C to quit if stalled (the script tends to not terminate by itself, even though the work has been done alright)

Note that you will need to have nodejs and npm installed on your machine
**Also you have to fill in your DB credentials in index.js, I'll make it easier in upcoming updates**

## Translation

Your previous translation file is now deprecated. You'll need to add your language to languages.lua (copy-paste En, change the key and do your thing)

Fr and En are already there, I'll take any PR with a new language.

## Config

The **job** related keys are unused for now, they might be in a future update.

| key | type | description |
| --- | ---- | ----------- |
| Lang | reference | Langs.YOUR_LANGUAGE (if defined)|
| StaticData | reference | Don't temper |
| MaxHorses | integer | The max number of horses a player can have in their stable |
| MaxCarts | integer | The max number of carriages a player can have in their stable |
| StableSlots | integer | The max number of carriages + horses a player can have in their stable |
| SecondsToRespawn | integer | When a horse dies, players will need to wait for so much seconds to call it back |
| DisableBuyOption | boolean | Set this to true so noone can buy a cart or horse whatsoever |
| JobRequired | boolean | Set this to true to enforce job checking before buying a ride |
| JobForHorseDealer | string | The name of the job required to buy horses (provided JobRequired is true) |
| JobForCartDealer | string | The name of the job required to buy carriages (provided JobRequired is true) |
| JobForAllDealer | string | The name of the job required to buy horses AND carriages (provided JobRequired is true) |
| HardDeath | boolean | Activate the hard death mechanism or not |
| LongTermHealth | integer | Upon dying, a horse loses LTH base on the values in `deathReason.lua`, when 0 is hit, the horse is deleted |
| ShowTagsOnHorse | boolean | Floating names above horses |
| HorseSkillPullUpFailPercent | integer | So much persent chances of falling when prancing |
| DistanceToTeleport | integer | If a horse/carriage is further away than this value, it wil be deleted and spawned again closer (granted nobody uses it) |
| Stables | StableConfig | [See below](#Stable-Config) |

## Stable Config

| key | type | description |
| --- | ---- | ----------- |
| Name | string | The name displayed in the prompt in-game |
| BlipIcon | integer | Should be hardcoded, don't touch |
| Enter stable | table[4] | The position at which the prompt should be displayed to open the stable, last number is the radius of effect |
| StableNPC | table[3] | The position of the ped |
| SpawnHorse | table[3] | The position of the horses for preview |
| SpawnCart | table[3] | The position of the carts for preview |
| CamHorse | table[5] | 4th parameter is rotation on x, 5th parameter is rotation on z |
| CamCart | table[5] | 4th parameter is rotation on x, 5th parameter is rotation on z |
| horses | table | [See Vendor config](#Vendor-Config)|
| carts | table | [See Vendor config](#Vendor-Config)|

## Vendor Config
This is a new feature, you can now define which horses and carts a vendor has to sell.
| key | type | description |
| --- | ---- | ----------- |
| key or default | `<string\|pair<string,number>>` | Two types are accepted here. Either `{"RIDE_NAME_HASH"}` or `{RIDE_NAME_HASH = price}`. the first retrieves the price defined in `Data[rideType]`, the latter defines a custom price for this vendor |

## Developpers
The UI is a vite+react app. Install the deps by running `npm i` in the UI folder, then run `npm run build` to apply any changes you make. If you want to test it in a dev environment you can run `npm run dev`, but you'll need to feed it with relevant data to view anything.


The lua code is currently lacking comments, I'll make sure to add more as time and commits goes.

# Credits 

Author : [CrimsonFreak](https://github.com/CrimsonFreak) 
