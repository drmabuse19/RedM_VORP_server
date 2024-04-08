# bcc-train

## Description
This is the best, full fledged train script for RedM! A multitude of features like built in track switching, train inventories, ownership and more!

## Features
- Buy and Sell trains at the train stations
- Track Switching
- Bacchus Bridge explodable
- Multiple train stations
- Station access can be limited by job and jobgrade
- Station hours may be set individually for each station or disabled to allow the station to remain open
- Purchased trains are stored in the database
- Can set a max number of trains a player can own
- Individual inventory size for each train model
- Config option to allow cruise control
- Configurable train speeds
- Trains need fuel to run
- Maintain the train to keep it functional
- Station blips are colored and changeable per stable location
- Blips can change color reflecting if station is open, closed or job locked
- Webhooks
- Distance-based NPC spawns
- Server-based delivery cooldown (persists through client relog)
- Exports for developers to use

## Dependencies
- [vorp_core](https://github.com/VORPCORE/vorp-core-lua)
- [vorp_inventory](https://github.com/VORPCORE/vorp_inventory-lua)
- [bcc-minigames](https://github.com/BryceCanyonCounty/bcc-minigames)
- [bcc-utils](https://github.com/BryceCanyonCounty/bcc-utils)

## Installation
- Download the latest release `bcc-train.zip` at [/releases/latest](https://github.com/BryceCanyonCounty/bcc-train/releases/latest)
- Add `bcc-train` folder to your resources folder
- Add `ensure bcc-train` to your `resources.cfg`
- Run the included database file `train.sql`
- Add images to: `...\vorp_inventory\html\img`
- Make sure dependencies are ensured above `bcc-train`
- Restart server

## How to use
- To refuel/repair train hold right click while near the driver seat to show prompts
- Press `U` to access train inventory
- Cruise control will disengage if conductor leaves engine seat
- Buy a train from a station, spawn it and have fun!

## Api
### Check if train spawned! (Server Side Use only)
- Returns true if a train has been spawned false if no train is spawned/in-use. Only 1 train should be spawned at a time on a server typically.
```Lua
local retval = exports['bcc-train']:CheckIfTrainIsSpawned()
```

### Get Train Entity (Server Side Use Only)
- If a train exists, this returns the train entity to be used on the client side, returns false if no train is spawned/in-use.
```Lua
local retval = exports['bcc-train']:GetTrainEntity()
```

### Check if Bacchus Bridge Destroyed (Server Side Use Only)
- Returns true if the bridge is destroyed false if not.
```Lua
local retval = exports['bcc-train']:BacchusBridgeDestroyed()
```

## Credits and Notes
- All imagery was provided by Lady Grey our in house designer
- Thanks sav for the nui
- Images for items can be found under the imgs/itemImages folder

## GitHub
- https://github.com/BryceCanyonCounty/bcc-train