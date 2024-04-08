#  Red Dead Nation Companions - A script for RedEM and VORP

## IMPORTANT: VORP users remember to set your framework in config.lua *and* .fxmanifest.lua

Join the [Red Dead Nations Discord](https://discord.gg/ArKcgAWACK) for support!


Watch me [stream while I code/play on Twitch](https://www.twitch.tv/halvandal)

## Preview
https://streamable.com/e4zzz2

## Description

With this script players are able to own pets that can retrieve hunted prey, track targets or even attack your enemies. Pets need to be raised as well as require food every so often and won't retrieve hunted prey if they are hungry. Pets can be set to automatically hostile targets that attack you as well. Simply look at your pet and hold right-click to access the many different options. Doing the same on other targets will show you their attack/track prompts.

## Features

• Purchase pets

• Raise pets by feeding them when they're hungry

• Pets will grow in size as they get older

• Full grown pets gain new abilities

• Give commands like sit and follow

• Pets can retrieve hunted animals (Hunt Mode)

• Pets can be set to track targets

• Pets can be set to attack targets

• Pets will hostile anyone in combat with owner

• Hungry pets won't retrieve

• /callpet to spawn your pet

• /fleepet to make your pet flee

• Optimized - Idles at 0.01ms with pet out	

• Almost everything can be toggled in the config

• Locale config.
    - Currently supports [en]


## How to Install
1. Put rdn_companions in your `resources` folder
2. Enter `ensure rdn_companions` in your server.cfg
3. Import the `companions.sql`
4. Go through `config.lua` before restarting your server

## Dependencies
• RedEM:RP
redemrp inventory 2.0

• VORP
vorp_inventory

## TODO
• Add human peds with the ability to outfit them, make them guard areas, etc

## Disclaimers and Credits
- This is a heavy modification of [bwrp_animalshelter](https://github.com/nerakhon/bwrp_animalshelter) (Made by nerakhon)]
