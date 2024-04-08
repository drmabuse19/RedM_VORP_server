# xakra_peyote
## Requirements
- [vorp_core](https://github.com/VORPCORE/vorp-core-lua)
- [vorp_inventory](https://github.com/VORPCORE/vorp_inventory-lua)
- [vorp_metabolism](https://github.com/VORPCORE/vorp_metabolism-lua)

## Description
This script reads a list of items to transform into a random animal from an editable list, a specific time that can also be edited in the file 'config.lua'. Make various animations throughout the process, trying to be 'realistic', with different animations for men and women. There is a 1/3 chance of dying when consuming the item.

## Instructions to incorporate script
- Copy the script into a folder (to choose) from the 'resources' folder.
- Add 'ensure xakra_peyote' in the 'Resources.cfg' document
- Add a new row in the database, in the 'items' table, we will call the item 'peyote' or add the existing items in the 'config.lua' file.
- Review the list of animals that the consumer can transform into.
- You will need to add an image called 'item_name.png' (with png format) in the 'vorp_inventory/html/items' folder.

Video (The transformation time has been reduced to 20 seconds for the video):
https://youtu.be/EitObGD3f-Q


