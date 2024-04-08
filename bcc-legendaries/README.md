# bcc-legendaries

> This is a simple easily configurable Legendary Animal Hunting Script for RedM.

## Features
- Menu for the hunts!
- Can create your own hunts!
- Gives rewards when the player skins the animal!
- Can enable or disable enemy npcs during the hunt!
- Individual hunt cooldowns!
- Can enable or disable extra animals to spawn and fight you when you find the legendary animal!
- Easy to translate via Config.language in the config.lua file!
- Everything is easily configurable in the Config.lua!
- Leveling system! (optional can be enabled or disabled via config.lua)
- Leveling system allows you to create an infinite number of levels, and at intervals you set will decrease the hint price by an amount you set (all done through config.lua)
- Version check system to help you keep up to date on new features and bug fixes!

## How it works
- You can set up the hunter(the location you go to start hunts) coordinates in the Config.lua and when you go there you will find an npc and some text. Do what the text says to open the hunt menu.
- Leveling system works by each hunt you successfully do, your level increases by a set amount(set in config) and the higher level you are the cheaper the hints are!

## Why use it
- It has alot of cool features too it. 
- I will offer as much support as I can for it. 
- Will add some more stuff to do in your RedM server. 
- Is a overall fun quest style hunt.

## Requirements
- VORP Core
- VORP Utils
- Menu Api
- VORP Inventory
- bcc-utils

## Installation Steps
- Add the file to your resource file
- Add ensure 'bcc-legendaries' to your resources.cfg
- Run the sql file
- Can not change name from 'bcc-legendaries' otherwise script will break

## Side notes
- Credit to vorp_hunting that is where i pulled the skinned.js and skinned.lua from and modified it to do what I want here.
- If you are adding new hunts in the config.lua please only use Legendary Animal models otherwise it could lead to duping bug
- This has a built in skinning system so if you have legendary animals setup in your hunting script remove them from the hunting script
- I will offer support for this, however do note it is not garunteed
- I really hope you enjoy the script thanks for trying it!
- I have optimized this code quite alot, but if you see any code that can be optimized further please open a pull request and I will take a look if it works I will merge it. Or just tell me lol.
- You can edit the code obviously. All I ask is that you release the edits to the community freely.
- The level system automatically creates a table in your database if you set it too true in the config. So there is no sql file to run!
