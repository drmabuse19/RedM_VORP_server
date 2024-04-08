# BCC - Job Alerts

> A RedM  job based alert/ping system for Vorp 

## Features
1. Commands that players can utilize to alerts a job + jobgrade
2. Police and Doctor preconfigured (/alertdoctor /alertpolice)
3. Alerts are fully customizable
    - Alert Icon
    - Message
    - Timinig
    - Delays
4. Custom Alerts are supported via the config!

## Installation
1. Download this repo/codebase
2. Extract and place `bcc-alerts` into your `resources` folder
3. Add `ensure bcc-alerts` to your `server.cfg` file
4. Restart your server (unless you have nightly restarts)

## How-to-use

### Medic/Doctor
1. You die, type `/alertdoctor` into chat
2. All users with the roll `medic` get alerted and a 30 second map blip appears where `/alertdoctor` was called

### Police
1. You are getting held up! Oh no, type `/alertpolice` into chat
2. All users with the roll `police` get alerted and a 30 second map blip appears where `/alertpolice` was called

## How-to-configure
All configurations available in `/config.lua`, including custom alerts!

## Developer Docs
```lua
-- Must register alerts as soon as server starts so that when players join, they can be properly registered for the job alert
local banker_alert = exports['bcc-job-alerts']:RegisterAlert({
    name = 'banker', --The name of the alert
    command = nil, -- the command, this is what players will use with /
    message = "Taxes need to be done!", -- Message to show to theh police
    messageTime = 40000, -- Time the message will stay on screen (miliseconds)
    job = "banker", -- Job the alert is for
    jobgrade = { 0, 1, 2, 3 }, -- What grades the alert will effect
    icon = "star", -- The icon the alert will use
    hash = -1282792512, -- The radius blip
    radius = 40.0, -- The size of the radius blip
    blipTime = 60000, -- How long the blip will stay for the job (miliseconds)
    blipDelay = 5000, -- Delay time before the job is notified (miliseconds)
    originText = "Hang tight, the bankers have been notified", -- Text displayed to the user who enacted the command
    originTime = 40000 --The time the origintext displays (miliseconds)
})

-- technically the above would register a command if command = name of command. but we set to nil, and have this command here to demonstrate programmatic usage of SendAlert(src)
RegisterCommand('TestBanker', function(src)
    banker_alert:SendAlert(src)
end)
```

## Dependency
 - bcc-utils
 - Vorp Core
