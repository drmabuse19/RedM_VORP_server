# BCC Minigames

> For developers looking to add some fun mini-games to their RedM project, this script is a great option. It features a collection of API-based games, including rock paper scissors, lock picking, and skill checks, which can be easily integrated into your RedM project. These mini-games can add an extra layer of interactivity and enjoyment to your project, and help engage your users in new and exciting ways. Give it a try and see how it can enhance your development process!

## Features
1. Rock paper scissors
2. Lock picking
3. skillcheck
4. HammerTime
5. Cow Milk

## Installation
1. Download the latest release `bcc-minigames.zip` at [/releases/latest](https://github.com/BryceCanyonCounty/bcc-minigames/releases/latest)
2. Extract and place `minigames` into your `resources` folder
3. Add `ensure minigames` to your `server.cfg` file
4. Restart your server (unless you have nightly restarts)

## API Docs 

### Hammer Time
Minigame that lets you hammer nails to a board

```lua
local MiniGame = exports['bcc-minigames'].initiate()

RegisterCommand('playgame', function(args, rawCommand)
    local cfg = {
        focus = true, -- Should minigame take nui focus (required)
        cursor = true, -- Should minigame have cursor  (required)
        nails = 15, -- How many nails to be hammered
        type = 'dark-wood' -- What color wood to display (light-wood, medium-wood, dark-wood)
    }

    MiniGame.Start('hammertime', cfg, function(result)
        print("Done!", result.result) -- true/false
    end)
end)
```

### Lockpicking

```lua
local MiniGame = exports['bcc-minigames'].initiate()

RegisterCommand('playgame', function(args, rawCommand)
    local cfg = {
        focus = true, -- Should minigame take nui focus
        cursor = true, -- Should minigame have cursor  (required for lockpick)
        maxattempts = 3, -- How many fail attempts are allowed before game over
        threshold = 10, -- +- threshold to the stage degree (bigger number means easier)
        hintdelay = 500, --milliseconds delay on when the circle will shake to show lockpick is in the right position.
        stages = {
            {
                deg = 25 -- 0-360 degrees
            },
            {
                deg = 0 -- 0-360 degrees
            },
            {
                deg = 300 -- 0-360 degrees
            }
        }
        
    }


    MiniGame.Start('lockpick', cfg, function(result)
        print("Unlocked?", result.unlocked) -- true/false
    end)
end)
```

### SkillCheck

```lua
local MiniGame = exports['bcc-minigames'].initiate()

RegisterCommand('playgame', function(args, rawCommand)
    local cfg = {
        focus = true, -- Should minigame take nui focus (required)
        cursor = false, -- Should minigame have cursor
        maxattempts = 3, -- How many fail attempts are allowed before game over
        type = 'bar', -- What should the bar look like. (bar, trailing)
        userandomkey = true, -- Should the minigame generate a random key to press?
        keytopress = 'B', -- userandomkey must be false for this to work. Static key to press
        keycode = 66, -- The JS keycode for the keytopress
        speed = 20, -- How fast the orbiter grows
        strict = false -- if true, letting the timer run out counts as a failed attempt
    }


    MiniGame.Start('skillcheck', cfg, function(result)
        print("Passed?", result.passed) -- true/false
    end)
end)
```

### Rock Paper Scissors

```lua
local MiniGame = exports['bcc-minigames'].initiate()

RegisterCommand('playgame', function(args, rawCommand)
    local cfg = {
        focus = true, -- Should minigame take nui focus
        cursor = true, -- Should minigame have cursor (required)
        allowretry = false --Allows use to start the minigame over.
    }


    MiniGame.Start('rps', cfg, function(result)
        print("Result?", result.result) -- win, lose, tie
    end)
end)
```

### Cow Milker

```lua
local MiniGame = exports['bcc-minigames'].initiate()
RegisterCommand('playgame', function(args, rawCommand)
    local cfg = {
        focus = true, -- Should minigame take nui focus (required)
        cursor = true, -- Should minigame have cursor  (required)
        timer = 30, -- The amount of seconds the game will run for
        minMilkPerSqueez = 0.1,
        maxMilkPerSqueez = 0.4
    }

    MiniGame.Start('cowmilker', cfg, function(result)
        print("Milk Collected!", result.collected) -- true/false
    end)
end)
```
