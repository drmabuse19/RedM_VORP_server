# RedM-Witnesses
A script that will transform an NPC into a witness when you shoot at other NPCs or players and notify law enforcement. 

**Dependencies**

- [RedEM-RP](https://github.com/RedEM-RP/redem_roleplay)

**Instructions**

- Extract download into your resources folder
- Start the resource in your server.cfg

**VORPCore**

Do you use VORP core instead of RedemRP? Open the server.lua and replace lines 1-10 with the following event:

```
RegisterNetEvent("Witness:CheckJob")
AddEventHandler("Witness:CheckJob", function(players, coords)
    for each, player in ipairs(players) do
        TriggerEvent("vorp:getCharacter", player, function(user)
            if user ~= nil then
				if user.job == 'police' then
					TriggerClientEvent("Witness:ToggleNotification", player, coords)
				end
            end
        end)
    end
end)
```
...and open client.lua and replace line 5 with the following:

```
TriggerEvent("vorp:Tip", 'A witness needs help!', 3000)
```

# License 

You are free to use and edit the source code as you want for personal use.
