Attempts to fix a number of issues with playing as an animal ped in RedM:

- By default, bird and fish peds cannot move at all.
- The control set for animals is very different and more limited than human peds, so scripts that listen for specific controls often don't work when playing as an animal.
- First person camera is glitchy on animals, and using it on certain animals causes the game to crash.
- Only a very limited number of animals can attack.

Fixes applied by this script:

- The control context is forced to `OnMount` when you switch to an animal ped:

  ```lua
  -- 0x2804658EB7D8A50B SET_CONTROL_CONTEXT
  SetControlContext(2, `OnMount`)
  ```
  
  This allows birds to move and fly and fish to swim, and also enables most of the same controls as human peds (specifically, it is the same control set as a human ped on a mount).
  
- While an animal, the first person camera is disabled.

- A custom attack system is added to allow more animals to attack with the attack button.

- Pressing the melee button allows you to "crouch" as an animal. Only the cougar and panther have a visual difference when crouched.
