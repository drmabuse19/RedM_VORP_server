# vorp_goldexchange
Edited / Forked Version of [vorp_goldexchange](https://discord.com/channels/704317931453939803/717693682995691521/948742125296685097) by Mobius#1313  
in the [VorpCore Discord](https://discord.vorpcore.com)

This script is provided as-is. Your performance may vary.

## Features
- Updated Language text so its more dynamic using config options
- Gold Currency can be traded for Gold Bars
- Added ability to adjust how much gold currency each Gold Bar is exchanged for
- Added ability to charge cash for exchanging gold bars
- Adjustable Rate at which Gold bars can be exchanged
- Config option for setting Ped model added
- Checks if you have enough money/gold bars/inventory space to do the exchange (No negative balances)
- Toggle Blips on/off depending on needs

## Dependencies:
- [VORP-CORE](https://github.com/VORPCORE/VORP-Core)
- [VORP-Inventory](https://github.com/VORPCORE/VORP-Inventory)

## Installation
- Stop your CFX Server (*NOT required*)
- Go to your Resources Folder in Terminal  
**Windows** `cd C:\redm\server-data\resources\`  
**Linux** `cd ~/redm/server-data/resources/`
- Create a Folder named `vorp_goldexchange`
- Clone this Repository into the folder  
`git clone https://github.com/Hailey-Ross/vorp_goldexchange .`  
*Keep the period at the end!*
- Add `ensure vorp_goldexchange` to your `server.cfg` file
- Change any desired settings in `config.lua` file
- Restart / Start your server
  
  
=================================================  
## Original README FILE
=================================================  

Black Market Items Buyer

This is heavily based on the beautiful Nerakhon's and Blue's bwrp_animalshelter script menu and location system, I added all the Fence Vendors locations and options to sell stuff there

=================================================

Usage : 

1. Go to a fence vendor location on the map, press (E) to open menu, select items to sell

You can modify items and prices in config.lua

=================================================

Recreated from:
HORSE SHOP FOR REDEM 0.1v by #mrlupo# / #Proky# / #Plouffe#  

https://github.com/Nerakhon<br>
https://github.com/Proky0<br>
https://github.com/mrlupo<br>
https://github.com/mrlupo/elrp_horsedealer<br>
https://github.com/kamelzarandah/pets-edit<br>
