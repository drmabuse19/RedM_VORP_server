# A Battlehorns improved version of the syn_river plugin
With this plugin, you are able to fill durty water from river, and somehow boil the water on fire to create clean water to drink.
Empty Canteens are required to fill from river, as well the empty buckets, so, try to add them into some stores or any NPC you may have.
Fred_metabolism was changed to be able to add items while drinking, so you can be able to see canteen drop 20% of the water each time you drink it, and become empty when you drink it 5 times.
All the sequence images are on the ```img``` folder here. Those do the magic :D

## Requirements
- [bh_metabolism](https://github.com/battlehorns3296/bh_metabolism)
- [fred_hud](https://github.com/battlehorns3296/fred_hud)
- [VORP_Inventory](https://github.com/VORPCORE/vorp_inventory-lua)
- And all requirements from the above required Plugins

## Additional
- [Vorp_crafting](https://github.com/VORPCORE/vorp_crafting)
To be able to craft clean water canteens

## Preview

[![CLICK TO WATCH THE VIDEO](https://img.youtube.com/vi/NTYyQLcEcwc/0.jpg)](https://www.youtube.com/watch?v=NTYyQLcEcwc)

## How to install
* Download the lastest release version of bh_river
(If you dont use the release versions, your could get errors from it.
Use it as your own risk)
* Copy and paste ```bh_river``` folder inside ```resources``` folder or any folder with ```[]``` name in it
* Copy ```img``` folder content into ```vorp_inventory/html/img/``` folder
* Import the SQL file inside ```sql``` folder into your database
If you got erros on the SQL import, please check if you dont have already a duplicated record on your ```items``` MySQL table
* Add all the items to for you be able to consume apart from the ```empty``` one(that should not be used as drinkable) into your metabolism plugin config file
* Edit those items on Metabolism plugin to your needs
* Finally add ```ensure bh_river``` to your ```resource.cfg``` or ```server.cfg``` file depending where you have your resources to be loaded.

* To edit the languages go to ```languages``` folder
* To add new languages just duplicate the files already there and edit the name of the new one relative to the config file.

## Example

from
```lua
Locales["en"] = {
  fill_Canteen_Button     = "Fill Canteen",       --Button Names
  fill_Bucket_Button      = "Fill Bucket",        -- ""
.....
```
into
```lua
Locales["xx"] = {
  fill_Canteen_Button     = "Fill Canteen in XX language",       --Button Names
  fill_Bucket_Button      = "Fill Bucket in XX language",        -- ""
.....
```
config.lua
```lua
Config = {}

-- Active language/locale
Config.defaultlang = "xx"
```

## Features
* Small drink amount from the river
* Fill Canteen from river (durty water)
* Fill Bucket from river
* Drink from Canteen reduce 20% of the Canteen content
* You dont need to drink the full content of the Canteen to refill it from the river
* You can quick refresh yourself from the river
* Options to Enable/Disable Features on Config file
## TODO
* Add items to the Character hands while on the animation
* Add more Config options into the ```config.lua``` file
* And more...

## Credits
- to [blue](https://github.com/kamelzarandah) for the initial work on the syn_river plugin

## Our Community
[MORE FROM ME](https://github.com/battlehorns3296)
[WEBSITE](https://www.battlehorns.net) 
[DISCORD](https://discord.gg/59pmYGHEtD) 
