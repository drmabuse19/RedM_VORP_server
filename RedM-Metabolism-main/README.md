# RedM-Metabolism (v1.2.0)
 Adds a couple new status effects and gives your citizens reason to eat and drink

# Requirements
- [VorpCore](https://github.com/VORPCORE/VORP-Core)

# Discord
If you need any information about my script,<br>
if you found a bug, if you have an idea for the <br>
next version, or if you simply need some help.<br>
Feel free to join our [Discord](http://discord.gg/2gdypBhsye)

# Framework
Currently, this script only works with VORP. <br>
In the near future this script will also be <br>
compatible with RedEmRP.

# Description
Every second your hunger and thirst will drop           <br>
according to your moving status, and the settings       <br>
set in the config. If you are running you use more      <br>
water and food than when your idle, same thing for      <br>
walking. Once your hunger or thirst gets lower then     <br>
the set minimum threshold, you start to take damage    <br>
to the healths inner core. Once the heaths inner core   <br>
has been depleted, you start to take damage to your     <br>
healths outer core. This is also the moment when you    <br>
start to receive warnings about your vitals.            

# Features
- `Easy to configure config.`
- `Very Customizable`
- `Lower food and/or thirst when running.`
- `Lower food and/or thirst when walking.`
- `Lower food and/or thirst when standing idle.`
- `Set lower or higher value for hunger`
- `Set lower or higher value for thirst`
- `Set lower or higher value for Stamina`
- `Boost Stamina outer core (Gold)`
- `Boost Stamina inner core (Gold)`

# Events
```
TriggerEvent('DevDokus:Metabolism:C:Hunger', value)
TriggerEvent('DevDokus:Metabolism:C:Thirst', value)
TriggerEvent('DevDokus:Metabolism:C:Health', value)
TriggerEvent('DevDokus:Metabolism:C:Stamina', value)
TriggerEvent('DevDokus:Metabolism:C:StaminaInner', value)
TriggerEvent('DevDokus:Metabolism:C:StaminaOuter', value)
```

# Disclaimer
Although the basics of this plugin are finished, <br>
I am still working on expanding it in the coming <br>
months. If you want to be able to upgrade to the <br>
latest update, I would recommend leaving this    <br>
script unchanged. If you make changes, you have  <br>
to redo these changes if you update to the latest <br>
version of this script!                          <br>

Other than that you are free to use this script  <br>
and make changes to it. Just make sure you put   <br>
my name and GitHub link in your upload.          <br>

Have fun everyone :)

# Credits
[SirFreddie](https://github.com/SirFreddie) For the hud we use.

# My other RedM scripts
- [RedM Teleport]( https://github.com/DevDokus/RedM-Teleport)
- [RedM Stores](https://github.com/DevDokus/Redm-Stores)
- [RedM Usable Items](https://github.com/DevDokus/RedM-UsableItems)
- [RedM Metabolism](https://github.com/DevDokus/RedM-Metabolism)
