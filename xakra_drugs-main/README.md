# xakra_drugs
## Requirements
- [vorp_core](https://github.com/VORPCORE/vorp-core-lua)
- [vorp_inventory](https://github.com/VORPCORE/vorp_inventory-lua)

## Description
With this script you will be able to add drug effects to your items:
- Mushroom: The character will eat a mushroom, the screen will turn purple, and the character will fall to the ground. Little by little the camera will rise to the sky, a random game scene will start (as if the character was looking at the sky). And suddenly there will be a rain of peds, shortly after our character will get up and return to normal.
- Opium: It would be necessary to have a pipe to consume the opium. Our character will smoke the pipe and start to see humans and giant animals for a while.
- Joint: Our character will smoke a joint, the vorp_metabolism hunger will go down a bit, and for a short time he will have a screen effect of a slightly closed eye. It will recover the core of life in gold. If he smokes more than the joints that you indicate in the configuration, the character will fall asleep on the ground without being able to move.

Images of the items in the 'img' folder.

In the Config file you can change:
- Name of drug items.
- Limit of joints until you are knocked to the ground and the time to recover.
- Effects time.
- The opium texts.
- List i quantity of peds that will appear in the drugs of the mushroom and opium.

## Instructions to incorporate script
- Copy the script into a folder (to choose) from the 'resources' folder.
- Add 'ensure xakra_drugs' in the 'Resources.cfg' document
- Create the necessary items in your database or change the names in the 'config.lua' file.

Video: https://youtu.be/W9SlGFGByBQ
