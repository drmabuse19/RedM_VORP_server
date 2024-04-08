# Player Blips

### FEATURES

- **_Real Time Player Blips_** - Player blips update at a set interval and then are removed once the player is longer on the server.

### Known Issues:

- If you reload the script while in game the current blips will remain on the map until client reload.
- If you click on the blip and it moves away it shows blip_name as the target of your waypoint.

### Config Options

```lua
Config.Enable = true -- true enables player blips, false disables the script
Config.WaitTime = 0 -- Speed at which it updates the blips (Live update by default)
```

#### INSTALATION

- Copy `bcc-playerblips` to your `Resources` directory.
- add `ensure bcc-playerblips` to your file called `Resources.cfg`.
- restart server.

### DEPENDENCIES

- [VORP_CORE](https://github.com/VORPCORE/vorp-core-lua)

### Shout Outs

- [ByteSizd](https://github.com/AndrewR3K) - Huge shoutout to ByteSizd for MASSIVE optimization and a memory leak fix.

### Suggestions and Support

If you have any questions or suggestions please feel free to open an issue or message me in the VORP Framework's Discord.
