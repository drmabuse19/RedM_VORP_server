Config = {}

Config.PlayerWakeUpCoords = {x = 394.45, y = -1262.09, z = 41.25} --this is where the player will wake up after doing the drug!
Config.SmokeOnNpcSpawn = true --if true when npcs spawn a smoke cloud/bomb effect when they spawn
Config.AnimalTransformationModel = 'A_C_Buck_01' --this is the model of the ped the player will change into during the trip
Config.TimeAsAnimal = 10000 --time that will be spent as an animal (cahnge to whatever you want I would personally reccomend 30 seconds or less)
Config.SmokeExplosionDuringPedChange = true --if true the smoke cloud/bomb effect will play on the player when the ped is changed

Config.RandomDrugChance = false --if true it will enable random chance(if enabled there will be a 1 in 4 chance of the "Bad Trip" happening) if false a bad trip will occur every time

--This is the drug items setup you can have as many or as few drug items as you want
Config.DrugItems = {
    { name = 'LSD', effectime = 60000 } --name is the items name in database, effect time is the time in ms you want the screen effect to go for if it is a good trip
    }

--Wave 1 npc spawn setup add or remove as many as you want
Config.PedSpawnCoordsWave1 = {
    {x = 413.15, y = -1238.36, z = 44.65},
    {x = 424.94, y = -1243.5, z = 44.65},
    {x = 430.14, y = -1237.09, z = 44.97},
    {x = 406.88, y = -1230.11, z = 44.84},
    {x = 385.46, y = -1220.27, z = 44.22},
    {x = 376.21, y = -1218.14, z = 44.13},
}

--Wave 2 npc spawn setup add or remove as many as you want
Config.PedSpawnCoordsWave2 = {
    {x = 388.59, y = -1216.43, z = 44.41},
    {x = 387.75, y = -1254.7, z = 41.72},
    {x = 375.84, y = -1264.97, z = 43.34},
    {x = 422.36, y = -1262.55, z = 42.2},
    {x = 433.83, y = -1253.2, z = 44.83},
    {x = 435.9, y = -1232.98, z = 44.89},
    {x = 438.16, y = -1224.64, z = 44.49},
}

--Wave 3 npc spawn setup add or remove as many as you want
Config.PedSpawnCoordsWave3 = {
    {x = 405.98, y = -1261.84, z = 41.59},
    {x = 404.68, y = -1255.51, z = 41.8},
    {x = 393.99, y = -1246.2, z = 42.46},
    {x = 383.75, y = -1237.73, z = 45.19},
}

--This is where you will wake up once the mission is over the script randomly chooses one location from the set below add or remove as many as you want
Config.WakeUpLocations = {
    {x = -1047.19, y = 450.55, z = 56.81, h = 178.68},
    {x = -1308.82, y = 395.05, z = 95.38, h = 95.98},
    {x = -2698.67, y = -1500.59, z = 152.03, h = 294.63},
    {x = -1447.93, y = -2297.07, z = 43.37, h = 229.05},
}