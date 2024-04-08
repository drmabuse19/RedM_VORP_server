Config = {}

Config.MenuPos = "left" -- 2 options: "right" or "left"

Config.SellShops = {
    [1] = { name = 'Rhodes Fence', sprite = 90287351, x= 1320.9952392578, y = -1142.3826904297, z = 82.334190368652 , blip = false}, --[1] is shopid
    [2] = { name = 'Wapiti Fence', sprite = 90287351, x= 432.06576538086, y = 2197.7985839844, z = 246.37657165527, blip = true }, --[2] is shopid
    [3] = { name = 'Pantelaner', sprite = 90287351, x = -175.17, y = 641.46, z = 114.09, blip = true}, --[1] is shopid

}

Config.sellItems = {
    [1] = { --[1] is shopid, items in shop #1 (Rhodes Fence)
        {"Gold Nugget", "golden_nugget", 2}, -- label, itemname, price
        {"Pickaxe", "pickaxe", 40},
        {"Worm", "worm", 3},
    },
    [2] = { --[2] is shopid, items in shop #2 (Wapiti Fence)
        {"Golden Ring", "golden_ring", 50}, -- label, itemname, price
        {"Worm", "worm", 1},
    },
    [3] = { --[2] is shopid, items in shop #2 (Wapiti Fence)
        {"Golden Nugget", "golden_nugget", 2}, -- label, itemname, price
        {"Worm", "worm", 1},
    }

}

Config.Texts = {
    Sellitems = "Sell Items",
    Sellitem = "Sell Item",
    Selectsell = "Select and Sell",
    NotifTitle = "Shop: Sell",
    DontHave = "You dont have",
    ToSell = "to sell",
    YouSold = "You sold",
}