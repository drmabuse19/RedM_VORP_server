# RedM model_t script - STANDALONE

## About

RedM model_t is the port of a Gta-5-mod addon car along with script to make it functional for RedM servers. This modification was developed for an [educational tutorial](https://www.youtube.com/watch?v=sfuh_mFBspM).

## Key Features

- **Synchronization**: Workarounds were discovered to keep the car visible upon new player join when tested with two people
- **Capablility**: Config file includes top speed and acceleration speed lines to fine tune handling
- **Wheel Rotation** Realistic wheel behaviour - Press A or D to see the wheels turn in the corresponding direction

## Important/Issues
- Please ensure your Advanced Graphics setting is on **Vulkan** instead of DX12 in game. The model_t cannot render under DX12 and will crash
- Lights will display at night automatically when the engine is on
- Sounds using PMMS were removed, they can be re-enabled
- Use /fixme if others cannot see you after leaving the vehicle
## Installation

1. Drag and drop model_t into server resources
2. Ensure model_t


## Commands
Change select commands such as spawn command in the config.lua file

| Command | Description |
| --- | --- |
| `/modelt` | Spawns the model_t next to player |
| `/deletemodelt` | Deletes model_t |
| `/resetmodelt` | Resets model_t |
| `/fixme` | Manual toggle for player visibility de-sync - Teleports player to Mexico and back |
| `/fixmodelt` | Manual toggle for object visibility de-sync - Toggles model_t visibility |
| `/lock` | Preliminary idea for locking - Makes vehicle undriveable (wheels are likely to fall off/cannot be unlocked) |

# controls

Turn Engine on/off = Left Alt, 
 

## Screenshots

![greatscreenshot](https://github.com/Silonugget/Redm-model_t/assets/107784929/7097164e-c0df-4753-a178-73e7d0e21f49)

![screenshot2](https://github.com/Silonugget/Redm-model_t/assets/107784929/0aa912f5-6195-45ef-a27d-8ef60620b883)



## Credits
- johndoe968 / Mad Rodger  https://www.gta5-mods.com/vehicles/model_t-flivver-add-on
- Zelbeus for Script elements https://github.com/zelbeus/redm_car
- Thanks to Luman Studios for sharing knowledge that inspired the idea
