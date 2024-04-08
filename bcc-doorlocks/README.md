# bcc-doorlocks

> This is a optimized simple, and effective doorlock script! It allows server admins to create doors that can be locked and unlocked by players!

# Features
- Each door can have upto 3 jobs that can unlock it!
- Each door can have its own key item to open!
- Each door can be lockpicked with a lockpick item!
- Can set an unlimited amount of character ids allowed to lock and unlock doors!
- exports for other scripts to be able to create and delete doors!
- Commands for admins to create and delete doors!
- Menu for creating the doors!

# How to install
- Run the sql file
- ensure bcc-doorlocks in your resources file below all the required scripts

# How it works!
- Create a door by entering the /createDoor command then aim with a gun at the door you want put a lock on and press "G" you will then be created by the door creation menu!
- To delete a door simply enter the command /deleteDoor then aim at the door you wish to delete and press "G"!
- Once you have created a door simply walk upto it and you will see some prompt options on the bottom right of your screen!

### Requirements
- VORP Menu
- VORP inputs
- VORP Character
- VORP Inventory
- VORP utils
- VORP Core
- bcc-utils
- bcc-minigames

# API
### Create door
```Lua
RegisterCommand('test50', function()
    local door = exports['bcc-doorlocks']:createDoor() --will create a lock on the door and retrun the doors table from doorhashes.lua for future deletion or storage
end)
```
### Delete Door
```Lua
RegisterCommand('test50', function()
    exports['bcc-doorlocks']:deleteDoor() --will delete a door that you aim at and confirm
end)
```

### Delete Specific Door
```Lua
RegisterCommand('test50', function()
    exports['bcc-doorlocks']:deleteSpecificDoor(doorTable) --Door table is required this is retrieved when using the createdoor export
end)
```