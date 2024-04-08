# bcc-posse
The bcc-posse RedM script offers exciting functionalities to create and manage posses in the wild west. With this script, players can form their own gangs, invite members, and embark on immersive multiplayer adventures together.

## Installation
1. Ensure that you have RedM installed and running.
2. Download the bcc-posse script files.
3. Place the bcc-posse script folder into the resources directory of your RedM server.
4. Add ensure `bcc-posse` to your server.cfg file to start the script on server startup.
Usage

## Posse Formation
To form a posse, players can use the in-game command /posse. This command will allow them to create a new posse and become the posse leader.

## Posse Area Check
To check if any individuals within a specific area are part of your posse, you can utilize the following export function:

```lua
local posseMembers, posseSize = exports['bcc-posse']:CheckPosseArea(coords, radius)
```

This export function will retrieve the server IDs of all posse members present within the designated radius. Additionally, it returns the length of the table containing the IDs, which can be useful for implementing reward systems.

## Reward System Integration
The bcc-posse script supports the integration of reward systems based on posse size. You can customize rewards using the following code:

```lua
Character.addCurrency(0, 100 * posseSize) -- Assuming 'vorp' is the currency system being used
```

By multiplying the base reward amount (100 in this example) with the posse size, you can dynamically adjust the rewards according to the number of posse members.

Please note that the script is designed to work seamlessly with the VORP currency system, ensuring a smooth experience for your posse members.

## Cotributing
Contributions to the bcc-posse script are welcome! If you have any bug fixes, improvements, or new feature suggestions, feel free to open a pull request on the GitHub repository.
