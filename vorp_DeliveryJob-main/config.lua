Config = {}

-- Language
Config.Locale = "en"

--Blips
Config.MainSprite = 486881925 -- Job Blip sprite
Config.DeliverySprite = -570710357 -- Point Sprite
Config.ShowBlips = true -- Show Point blips

--Messages
-- Config.Deliver = "Press (X) to make a delivery" -- Start Gathering Message

--Timer and zone size
Config.ZoneSize = 2.0 -- Sizes of the zones

--Point specifics

--Valentine to Bacchus Station
Config.MainJob = {
    {job =1,x = 2736.57, y = -1402.27, z = 46.18}, -- Rhodes Train Station
}

Config.FinishJob = {
    {x=570.52,y=1676.26,z=186.48},
    {x=1420.15,y=383.93,z=90.33},
    {x=-1792.18,y=-391.68,z=43.88},
    {x=-3686.81,y=-2627.33,z=13.43},
    {x=-883.62,y=-1300.45,z=43.30}, -- Blackwater Construction
}


-- Job1 Position Valentine
Config.Point1 = {x=570.52,y=1676.26,z=186.48} -- Point 1 location Bacchus Station
Config.Cart1 = {x = 2674.84, y = -1441.96, z = 46.18} -- Cart spawn point
Config.StartWorking1 = "Bacchus Station." -- Start Working Message
Config.Cash1 = 120.0 -- Cash payout
Config.Exp1 = 0 -- EXP payout
Config.Gold1 = 0 -- Gold payout 

--Annesburg to Emerald Ranch
Config.MainJob2 = {x=2939.25,y=1288.65,z=44.65} -- Job2 Position Annesburg
Config.Point2 = {x=1420.15,y=383.93,z=90.33} -- Point 2 location Emerald Ranch
Config.StartWorking2 = "Emerald Ranch." -- Start Working Message
Config.Cart2 = {x = 2674.84, y = -1441.96, z = 46.18} -- Cart spawn point
Config.Cash2 = 120.0 -- Cash payout
Config.Exp2 = 0 -- EXP payout
Config.Gold2 = 0 -- Gold payout

--Blackwater to Strawberry
Config.MainJob3 = {x=-778.33,y=-1323.44,z=43.88} -- Job3 Position Blackwater
Config.Point3 = {x=-1789.4,y=-376.68,z=159.1} -- Point 3 location Strawberry
Config.Cart3 = {x = 2674.84, y = -1441.96, z = 46.18} -- Cart spawn point
Config.StartWorking3 = "Strawberry." -- Start Working Message
Config.Cash3 = 150.0 -- Cash payout
Config.Exp3 = 0 -- EXP payout
Config.Gold3 = 0 -- Gold payout

--MacFarland Ranch to Armadillo
Config.MainJob4 = {x=-2324.89,y=-2406.17,z=63.85} -- Job4 Position MacFarland
Config.Point4 = {x=-3686.81,y=-2627.33,z=-13.43} -- Point 4 location Armadillo
Config.Cart4 = {x = 2674.84, y = -1441.96, z = 46.18} -- Cart spawn point
Config.StartWorking4 = "Armadillo." -- Start Working Message
Config.Cash4 = 300.0 -- Cash payout
Config.Exp4 = 10 -- EXP payout
Config.Gold4 = 0 -- Gold payout

--Rhodes Train Station to Blackwater Construction
Config.MainJob5 = {x=1231.27,y=-1299.57,z=77.39} -- Job5 Position Rhodes Train Station
Config.Point5 = {x=-883.62,y=-1300.45,z=43.30} -- Point 5 location Blackwater
Config.Cart5 = {x = 2674.84, y = -1441.96, z = 46.18} -- Cart spawn point
Config.StartWorking5 = "Blackwater." -- Start Working Message
Config.Cash5 = 90.0 -- Cash payout
Config.Exp5 = 0 -- EXP payout
Config.Gold5 = 0 -- Gold payout
