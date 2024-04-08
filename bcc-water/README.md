# bcc-water

#### Description
Water script for RedM servers using the [VORP](https://github.com/VORPCORE) framework.
Add the canteen and bucket items to a store or crafting station for players to buy or make. Fill your canteen and buckets at waterpumps while in town or **crouch and hold still** in wild waters to show drink, wash and fill prompts. See features for more details.

#### Features
- Carry a canteen of water to drink
- Drink 4 times from a full canteen
- Quenches thirst when using supported metabolism scripts
- Refill canteen and buckets at waterpumps, rivers and lakes
- Drink directly from rivers and lakes to save the water in your canteen
- Separate health, stamina and thirst config values for drinking from canteen and wild waters
- Players can wash in rivers and lakes
- Players can take damage from drinking wild water

#### Dependencies (Make sure these are updated)
- [vorp_core](https://github.com/VORPCORE/vorp-core-lua)
- [vorp_inventory](https://github.com/VORPCORE/vorp_inventory-lua)

#### Supported Metablolism Scripts
- VORP Metabolism
- Fred Metabolism
- Outsider Needs Metabolism
- RSD Metabolism
- NXT Metabolism
- Andrade Metabolism
- FX-HUD

#### Installation
- Add `bcc-water` folder to your resources folder
- Add `ensure bcc-water` to your `resources.cfg`
- Ensure this script *after* your metabolism script
- Run the included database file `water.sql`
- Add images to: `...\vorp_inventory\html\img`
- Add items to a store or crafting station for player use
- Set your metabolism script in the `config.lua` file
- Restart server

#### Credits
- green_canteen

#### GitHub
- https://github.com/BryceCanyonCounty/bcc-water
