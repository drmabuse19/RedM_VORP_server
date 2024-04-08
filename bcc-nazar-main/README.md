# bcc-nazar

> This script is a simple easy to use and configure Madam Nazar for RedM!

## Features
- Creates Madam Nazar in your RedM server!
- Spawns Madam Nazar at one of 4 random locations
- Can enable or disable a blip on Madam Nazar's location
- Madam Nazar can give the player a treasure chest to go find, and gain rewards
- The chests are on a global cooldown meaning once someone does it no one can start a new hunt for a certain set time
- Madam Nazar can buy, and sell things to the player, making her a good option for a black market that moves automaticall every server restart.
- Can create as many treasure hunt's as you want
- In depth webhooking
- Config Option too have a wagon spawn with nazar or not!
- Version check to help you keep up to date on new features and bug fixes!
- Option to set the type of currency for items in nazars shop!
- Option to enable her music from RDO to play when near!
- Card Collecting Added! (Spawns cards around the map at set coords. Use a card in inventory to view in your hand.)

## How it works
- It creates Madam Nazar in your RedM server! Walk upto her and read the text that shows. Hit 'G' on your keyboard to open up her menu. From there you can choose to buy a hint for a treasure chest, sell items to her, or buy items from her.

## Why use it
- It has alot of cool features too it. 
- Can be used as a automated moving black market.
- Unlimited amount of treasure hunts
- Gives your RedM server more depth, and content to do

## Requirements
- [vorp_core](https://github.com/VORPCORE/vorp-core-lua)
- [vorp_inventory](https://github.com/VORPCORE/vorp_inventory-lua)
- [vorp_inputs](https://github.com/VORPCORE/vorp_inputs-lua)
- [vorp_menu](https://github.com/VORPCORE/vorp_menu)
- [bcc-utils](https://github.com/BryceCanyonCounty/bcc-utils)

## Installation Steps
- Make sure dependencies are installed and updated
- Add `bcc-nazar` folder to your resources folder
- Add `ensure bcc-nazar` to your resources.cfg
- Run the included database file `nazar.sql`
- Add `collector_card` image to: `...\vorp_inventory\html\img`
- Restart server

## Side notes
- If you have any suggestions please be sure to let me know
- I will offer support for this, however do note it is not garunteed
- I really hope you enjoy the script thanks for trying it!
- I have optimized this code quite alot, but if you see any code that can be optimized further please open a pull request and I will take a look if it works I will merge it. Or just tell me lol.
- You can edit the code obviously. All I ask is that you release the edits to the community freely.
- Credit to Mr Terabyte for the menu overhaul absolutely awsome!