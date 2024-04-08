Config = {}
Config.debug = false
Config.UpdateTime = 5 -- refresh database house in * minute
Config.defaultlang = "en"
Config.MyKey = "myHouseKey" -- command to get your house key if you lot it or give it to someones
Config.SellHouse = "sellHouse" -- command sell near house
Config.SellPrice = 0.5 -- percent retrun house price when selling house . 1.0 is 100%.  
Config.Rooms = {
    {
        Id        = 1, -- must be unique
        Name      = "Room 2A", --blip name 
        key       = "hk_1", -- must be unique
        Price     = 6000,
        text      = vector3(-322.77, 767.2, 122.0),
        Inventory = vector3(-327.3, 764.14, 121.63),
        Doors     = {
            {
                object    = 3765902977,
                objCoords = vector3(-322.77, 767.2, 121.66),
                objYaw    = 100.0,
                locked    = true
            }
        },
        sell = true , -- if set false player cannot sell this house
		MaxWeight = 100 -- inventory slots.
    },
    {
        Id        = 2,
        Name      = "Room 2B",
        key       = "hk_2",
        Price     = 6000,
        text      = vector3(-321.91, 762.08, 122.0),
        Inventory = vector3(-326.44, 759.42, 121.63),
        Doors     = {
            {
                object    = 238680582,
                objCoords = vector3(-321.91, 762.08, 121.66),
                objYaw    = 280.0,
                locked    = true
            }
        },
        sell = true , -- if set false player cannot sell this house
		MaxWeight = 100
    },
    {
        Id        = 3,
        Name      = "Room 3B",
        key       = "hk_3",
        Price     = 6000,
        text      = vector3(-324.2, 774.19, 122.0),
        Inventory = vector3(-328.22, 772.66, 121.63),
        Doors     = {
            {
                object    = 3049177115,
                objCoords = vector3(-324.2, 774.19, 121.63),
                objYaw    = 100.0,
                locked    = true
            }
        },
        sell = true , -- if set false player cannot sell this house
		MaxWeight = 100
    },
  {
        Id        = 4, -- must be unique
        Name      = "Room 1A", --blip name 
        key       = "hk_1A", -- must be unique
        Price     = 5000,
        text      =vector3(-321.96, 765.38, 117.45),
        Inventory = vector3(-325.4, 766.4, 117.43),
        Doors     = {
            {
                object    = 3693364451,
                objCoords = vector3(-321.96, 765.38, 117.45),
                objYaw    = 100.0,
                locked    = true
            }
        },
        sell = true , -- if set false player cannot sell this house
		MaxWeight = 100 -- inventory slots.
    },
 {
        Id        = 5, -- must be unique
        Name      = "Room 1B", --blip name 
        key       = "hk_1B", -- must be unique
        Price     = 5000,
        text      = vector3(-321.54, 762.22, 117.45),
        Inventory =vector3(-323.6, 759.58, 117.44),
        Doors     = {
            {
                object    = 183181940,
                objCoords = vector3(-321.54, 762.22, 117.45),
                objYaw    = 100.0,
                locked    = true
            }
        },
        sell = true , -- if set false player cannot sell this house
		MaxWeight = 100 -- inventory slots.
    },

}


Config.Houses = {
    {
        Id        = 101, -- must be unique
        Name      = "Cabin at Braithwaite Manor", --blip name   
        Price     = 20000.0,
        key       = "hk_101", -- must be unique
        text      = vector3(1115.7, -1989.18, 55.75),
        Inventory = vector3(1119.16, -1985.74, 55.35),
        Doors     = {
            {
                object    = 3921310299,
                objCoords = vector3(1115.7, -1989.18, 55.35),
                objYaw    = 120.0,
                locked    = true
            }
        },
        sell = true , -- if set false player cannot sell this house
		MaxWeight = 1000 -- inventory slots.
    },
    {
        Id        = 102,
        Name      = "House near the Kamassa River",
        Price     = 10000.0,
        key       = "hk_102",
        text      = vector3(1791.9, -83.9, 57.22),
        Inventory = vector3(1789.98, -85.22, 60.45),
        Doors     = {
            {
                object    = 1928053488,
                objCoords = vector3(1791.9, -83.9, 56.82),
                objYaw    = -95.0,
                locked    = true
            }
        },
        sell = true , -- if set false player cannot sell this house
		MaxWeight = 500
    },
    {
        Id        = 103,
        Name      = "Window Rock Farm",
        Price     = 20000.0,
        key       = "hk_103",
        text      = vector3(-398.05, 1722.65, 216.83),
        Inventory = vector3(-400.64, 1726.37, 216.43),
        Doors     = {
            {
                object    = 4070066247,
                objCoords = vector3(-398.05, 1722.65, 216.43),
                objYaw    = 25.0,
                locked    = true
            }
        },
        sell = true , -- if set false player cannot sell this house
		MaxWeight = 1000
    },
    {
        Id        = 104,
        Name      = "House on the Lannahechee River",
        Price     = 25000.0,
        key       = "hk_104",
        text      = vector3(1322.81, -2279.74, 50.95),
        Inventory = vector3(1313.8, -2278.6, 50.54),
        Doors     = {
            {
                object    = 3184160386,
                objCoords = vector3(1322.81, -2279.74, 50.55),
                objYaw    = -55.0,
                locked    = true
            }
        },
        sell = true , -- if set false player cannot sell this house
		MaxWeight = 1000
    },
    {
        Id        = 105,
        Name      = "Cabin at Lake O'Creagh's",
        Price     = 10000.0,
        key       = "hk_105",
        text      = vector3(1697.4, 1508.9, 148.28),
        Inventory = vector3(1701.39, 1509.32, 147.87),
        Doors     = {
            {
                object    = 868379185,
                objCoords = vector3(1697.4, 1508.9, 147.88),
                objYaw    = 100.0,
                locked    = true
            }
        },
        sell = true , -- if set false player cannot sell this house
		MaxWeight = 700
    },
    {
        Id        = 106,
        Name      = "Cabin on the Southfield Plains",
        Price     = 30000.0,
        key       = "hk_106",
        text      = vector3(1136.52, -977.21, 69.79),
        Inventory = vector3(1133.86, -981.41, 69.4),
        Doors     = {
            {
                object    = 3929468747,
                objCoords = vector3(1136.52, -977.21, 69.39),
                objYaw    = 148.0,
                locked    = true
            }
        },
        sell = true , -- if set false player cannot sell this house
		MaxWeight = 1500
    },
    {
        Id        = 107,
        Name      = "Mansion in the swamp",
        Price     = 30000.0,
        key       = "hk_107",
        text      = vector3(1891.44, -1858.21, 43.35),
        Inventory = vector3(1906.57, -1862.69, 43.14),
        Doors     = {
            {
                object    = 560870147,
                object2   = 867489680,
                objCoords = vector3(1891.44, -1858.21, 43.15),
                objYaw    = 50.0,
                objYaw2   = -50.0,
                locked    = true
            }
        },
        sell = true , -- if set false player cannot sell this house
		MaxWeight = 3000
    },
    {
        Id        = 108,
        Name      = "Cabin in the Roanoke Valley",
        Price     = 8000.0,
        key       = "hk_108",
        text      = vector3(2628.11, 1693.7, 116.1),
        Inventory = vector3(2624.16, 1696.37, 115.7),
        Doors     = {
            {
                object    = 1574473390,
                objCoords = vector3(2628.11, 1693.7, 115.7),
                objYaw    = 255.0,
                locked    = true
            }
        },
        sell = true , -- if set false player cannot sell this house
		MaxWeight = 500
    },
    {
        Id        = 109,
        Name      = "Cabin in Rhodes",
        Price     = 30000.0,
        key       = "hk_109",
        text      = vector3(1114.1, -1305.33, 66.84),
        Inventory = vector3(1116.11, -1297.73, 66.38),
        Doors     = {
            {
                object    = 1485561723,
                objCoords = vector3(1114.1, -1305.33, 66.44),
                objYaw    = 190.0,
                locked    = true
            },
            {
                object    = 3544613794,
                objCoords = vector3(1111.9, -1297.57, 66.41),
                objYaw    = 15.0,
                locked    = true,
            }
        },
        sell = true , -- if set false player cannot sell this house
		MaxWeight = 1500
    },
    {
        Id        = 110,
        Name      = "Cabin in the snow town",
        Price     = 15000.0,
        key       = "hk_110",
        text      = vector3(-1347.75, 2435.64, 308.81),
        Inventory = vector3(-1354.7, 2443.43, 308.42),
        Doors     = {
            {
                object    = 2183007198,
                objCoords = vector3(-1347.75, 2435.64, 308.41),
                objYaw    = 70.0,
                locked    = true
            },
            {
                object    = 4288310487,
                objCoords = vector3(-1348.78, 2447.13, 308.41),
                objYaw    = 160.0,
                locked    = true
            }
        },
        sell = true , -- if set false player cannot sell this house
		MaxWeight = 1300
    },
    {
        Id        = 111,
        Name      = "Cabin in the snow",
        Price     = 15000.0,
        key       = "hk_111",
        text      = vector3(-556.81, 2699.28, 320.82),
        Inventory = vector3(-553.28, 2701.43, 320.42),
        Doors     = {
            {
                object    = 872775928,
                objCoords = vector3(-556.81, 2699.28, 320.42),
                objYaw    = 150.0,
                locked    = true
            },
            {
                object    = 2385374047,
                objCoords = vector3(-558.1, 2708.5, 320.42),
                objYaw    = 240.0,
                locked    = true
            }
        },
        sell = true , -- if set false player cannot sell this house
		MaxWeight = 1300
    },
    {
        Id        = 112,
        Name      = "Cabin in Valentine",
        Price     = 30000.0,
        key       = "hk_112",
        text      = vector3(778.95, 848.93, 119.32),
        Inventory = vector3(777.36, 850.29, 118.91),
        Doors     = {
            {
                object    = 4123766266,
                objCoords = vector3(778.95, 848.93, 118.92),
                objYaw    = 285.0,
                locked    = true
            },
            {
                object    = 417362979,
                objCoords = vector3(773.17, 841.39, 118.91),
                objYaw    = 20.0,
                locked    = true
            }
        },
        sell = true , -- if set false player cannot sell this house
		MaxWeight = 1500
    },
    {
        Id        = 113,
        Name      = "Cabin on the Dakota River",
        Price     = 20000.0,
        key       = "hk_113",
        text      = vector3(-692.2, 1042.43, 135.43),
        Inventory = vector3(-688.45, 1041.78, 135.13),
        Doors     = {
            {
                object    = 1434140379,
                objCoords = vector3(-692.2, 1042.43, 135.03),
                objYaw    = 310.0,
                locked    = true
            }
        },
        sell = true , -- if set false player cannot sell this house
		MaxWeight = 1500
    },
    {
        Id        = 114,
        Name      = "House on the Dakota River",
        Price     = 20000.0,
        key       = "hk_114",
        text      = vector3(-608.98, -26.24, 86.4),
        Inventory = vector3(-614.57, -37.49, 85.97),
        Doors     = {
            {
                object    = 906448125,
                objCoords = vector3(-608.98, -26.24, 85.99),
                objYaw    = 110.0,
                locked    = true
            }
        },
        sell = true , -- if set false player cannot sell this house
		MaxWeight = 1500
    },
    {
        Id        = 115,
        Name      = "Big Valley Farm House",
        Price     = 15000.0,
        key       = "hk_115",
        text      = vector3(-2590.92, 457.36, 147.41),
        Inventory = vector3(-2593.98, 453.44, 147.0),
        Doors     = {
            {
                object    = 1535511805,
                objCoords = vector3(-2590.92, 457.36, 147.01),
                objYaw    = 260.0,
                locked    = true,
            }
        },
        sell = true , -- if set false player cannot sell this house
		MaxWeight = 1000
    },
    {
        Id        = 116,
        Name      = "Cabin in the Aurora Basin",
        Price     = 20000.0,
        key       = "hk_116",
        text      = vector3(-2590.92, 457.36, 147.41),
        Inventory = vector3(-2374.12, -1592.08, 154.7),
        Doors     = {
            {
                object    = 1171581101,
                objCoords = vector3(-2374.12, -1592.08, 154.3),
                objYaw    = 55.0,
                locked    = true
            }
        },
        sell = true , -- if set false player cannot sell this house
		MaxWeight = 1500
    },
    {
        Id        = 117,
        Name      = "House on the Little Creek River",
        Price     = 30000.0,
        key       = "hk_117",
        text      = vector3(-2182.45, 715.9, 123.0),
        Inventory = vector3(-2173.33, 715.48, 122.62),
        Doors     = {
            {
                object    = 2212914984,
                objCoords = vector3(-2182.45, 715.9, 122.62),
                objYaw    = 290.0,
                locked    = true
            }
        },
        sell = true , -- if set false player cannot sell this house
		MaxWeight = 1500
    },
    {
        Id        = 118,
        Name      = "House on the outskirts of Blackwater",
        Price     = 30000.0,
        key       = "hk_118",
        text      = vector3(-1645.71, -1367.46, 84.87),
        Inventory = vector3(-1643.92, -1352.86, 84.4),
        Doors     = {
            {
                object    = 1606546482,
                objCoords = vector3(-1645.71, -1367.46, 84.47),
                objYaw    = -30.0,
                locked    = true
            },
            {
                object    = 2310818050,
                objCoords = vector3(-1637.19, -1352.85, 84.46),
                objYaw    = -30.0,
                locked    = true,
            },
            {
                object    = 818583340,
                objCoords = vector3(-1648.81, -1358.75, 84.46),
                objYaw    = 45.0,
                locked    = true,
            }
        },
        sell = true , -- if set false player cannot sell this house
		MaxWeight = 1000
    },
    {
        Id        = 119,
        Name      = "Cabin on the Little Creek River",
        Price     = 30000.0,
        key       = "hk_119",
        text      = vector3(-1815.64, 654.56, 132.25),
        Inventory = vector3(-1816.13, 663.35, 128.86),
        Doors     = {
            {
                object    = 1195519038,
                objCoords = vector3(-1815.64, 654.56, 131.85),
                objYaw    = 210.0,
                locked    = true
            }
        },
        sell = true , -- if set false player cannot sell this house
		MaxWeight = 1000
    },
    {
        Id        = 120,
        Name      = "Cabin in the Cumberland Forest",
        Price     = 20000.0,
        key       = "hk_120",
        text      = vector3(-67.05, 1235.28, 171.2),
        Inventory = vector3(-65.82, 1238.26, 170.77),
        Doors     = {
            {
                object    = 7595016,
                objCoords = vector3(-67.05, 1235.28, 170.8),
                objYaw    = 210.0,
                locked    = true
            }
        },
        sell = true , -- if set false player cannot sell this house
		MaxWeight = 1500
    },
    {
        Id        = 122,
        Name      = "Cabin in Lakay",
        Price     = 20000.0,
        key       = "hk_122",
        text      = vector3(2235.02, -773.8, 43.94),
        Inventory = vector3(2231.65, -766.33, 43.48),
        Doors     = {
            {
                object    = 675165849,
                objCoords = vector3(2235.02, -773.8, 43.54),
                objYaw    = 90.0,
                locked    = true
            }
        },
        sell = true , -- if set false player cannot sell this house
		MaxWeight = 1500
    },
    {
        Id        = 123,
        Name      = "Little house near Emerald station",
        Price     = 15000.0,
        key       = "hk_123",
        text      = vector3(1887.62, 297.89, 77.46),
        Inventory = vector3(1887.13, 300.75, 77.07),
        Doors     = {
            {
                object    = 2821676992,
                objCoords = vector3(1887.6, 297.88, 77.06),
                objYaw    = 180.0,
                locked    = true
            }
        },
        sell = true , -- if set false player cannot sell this house
		MaxWeight = 1000
    },
    {
        Id        = 124,
        Name      = "House on the Don Julio river",
        Price     = 30000.0,
        key       = "hk_124",
        text      = vector3(-3551.85, -3011.82, 12.28),
        Inventory = vector3(-3555.5, -3011.92, 11.82),
        Doors     = {
            {
                object    = 1894337720,
                objCoords = vector3(-3551.85, -3011.82, 11.88),
                objYaw    = 10.0,
                locked    = true
            },
            {
                object    = 120764251,
                objCoords = vector3(-3554.88, -3007.8, 11.86),
                objYaw    = 10.0,
                locked    = true
            }
        },
        sell = true , -- if set false player cannot sell this house
		MaxWeight = 1500
    },
    {
        Id        = 125,
        Name      = "House in Cholla Springs",
        Price     = 25000.0,
        key       = "hk_125",
        text      = vector3(-4366.23, -2415.75, 20.42),
        Inventory = vector3(-4367.17, -2417.3, 20.4),
        Doors     = {
            {
                object    = 2047072501,
                objCoords = vector3(-4366.23, -2415.75, 20.42),
                objYaw    = 105.0,
                locked    = true
            }
        },
        sell = true , -- if set false player cannot sell this house
		MaxWeight = 1000
    },
    {
        Id        = 126,
        Name      = "North house in Tumbleweed",
        Price     = 25000.0,
        key       = "hk_126",
        text      = vector3(-5551.73, -2401.23, -8.31),
        Inventory = vector3(-5549.53, -2399.21, -8.74),
        Doors     = {
            {
                object    = 2715667864,
                objCoords = vector3(-5551.73, -2401.23, -8.71),
                objYaw    = 20.0,
                locked    = true
            },
            {
                object    = 1263476860,
                objCoords = vector3(-5555.82, -2397.49, -8.72),
                objYaw    = 240.0,
                locked    = true
            }
        },
        sell = true , -- if set false player cannot sell this house
		MaxWeight = 1000
    },
    {
        Id        = 127,
        Name      = "Cabin in Big Valley",
        Price     = 15000.0,
        key       = "hk_127",
        text      = vector3(-2371.38, 475.27, 132.64),
        Inventory = vector3(-2369.21, 473.67, 132.23),
        Doors     = {
            {
                object    = 1610014965,
                objCoords = vector3(-2371.38, 475.27, 132.24),
                objYaw    = 0.0,
                locked    = true
            }
        },
        sell = true , -- if set false player cannot sell this house
		MaxWeight = 1500
    },
    {
        Id        = 128,
        Name      = "Brandywine Waterfall Cabin",
        Price     = 15000.0,
        key       = "hk_128",
        text      = vector3(2988.89, 2193.33, 167.14),
        Inventory = vector3(2984.43, 2184.94, 166.75),
        Doors     = {
            {
                object    = 344028824,
                objCoords = vector3(2988.89, 2193.33, 166.74),
                objYaw    = 250.0,
                locked    = true
            }
        },
        sell = true , -- if set false player cannot sell this house
		MaxWeight = 1000
    },
    {
        Id        = 129,
        Name      = "Cabin in the Eris Fields Forest",
        Price     = 10000.0,
        key       = "hk_129",
        text      = vector3(1626.6, -366.16, 76.3),
        Inventory = vector3(1619.16, -363.36, 75.9),
        Doors     = {
            {
                object    = 3468185317,
                objCoords = vector3(1626.6, -366.16, 75.9),
                objYaw    = 180.0,
                locked    = true
            }
        },
        sell = true , -- if set false player cannot sell this house
		MaxWeight = 1000
    },
    {
        Id        = 130,
        Name      = "House at Cumberland Waterfall",
        Price     = 30000.0,
        key       = "hk_130",
        text      = vector3(-818.06, 351.04, 98.51),
        Inventory = vector3(-817.12, 357.66, 98.08),
        Doors     = {
            {
                object    = 1915887592,
                objCoords = vector3(-818.06, 351.04, 98.11),
                objYaw    = -10.0,
                locked    = true
            }
        },
        sell = true , -- if set false player cannot sell this house
		MaxWeight = 1500
    },
    {
        Id        = 131,
        Name      = "Mansion Braithwaite",
        Price     = 80000.0,
        key       = "hk_131",
        text      = vector3(1011.28, -1762.12, 48.0),
        Inventory = vector3(1007.08, -1777.2, 52.0),
        Doors     = {
            {
                object    = 1439227364,
                object2   = 1595076728,
                objCoords = vector3(1011.28, -1762.12, 47.6),
                objYaw    = 0.0,
                objYaw2   = 0.0,
                locked    = true
            },
            {
                object    = 530930529,
                object2   = 1299101427,
                objCoords = vector3(1000.25, -1765.15, 47.62),
                objYaw    = -90.0,
                objYaw2   = -90.0,
                locked    = true
            },
            {
                object    = 23338719,
                object2   = 785447352,
                objCoords = vector3(1000.1, -1768.39, 47.65),
                objYaw    = -90.0,
                objYaw2   = -90.0,
                locked    = true
            },
            {
                object    = 1913469935,
                object2   = 1606293329,
                objCoords = vector3(999.84, -1772.57, 47.64),
                objYaw    = -90.0,
                objYaw2   = -90.0,
                locked    = true
            },
            {
                object    = 1620578985,
                object2   = 3222102077,
                objCoords = vector3(1011.19, -1779.47, 47.6),
                objYaw    = .0,
                objYaw2   = 0.0,
                locked    = true
            },
            {
                object    = 3330577590,
                object2   = 825059846,
                objCoords = vector3(1022.5, -1777.08, 47.66),
                objYaw    = 90.0,
                objYaw2   = -90.0,
                locked    = true
            },
            {
                object    = 248030525,
                object2   = 606588923,
                objCoords = vector3(1022.68, -1773.94, 47.64),
                objYaw    = 90.0,
                objYaw2   = 90.0,
                locked    = true,
            },
            {
                object    = 2919540021,
                object2   = 2630222520,
                objCoords = vector3(1022.53, -1768.53, 47.66),
                objYaw    = 90.0,
                objYaw2   = 90.0,
                locked    = true
            },
            {
                object    = 1970779164,
                object2   = 2276841624,
                objCoords = vector3(1022.61, -1764.95, 47.65),
                objYaw    = 90.0,
                objYaw2   = 90.0,
                locked    = true
            }

        },
        sell = true , -- if set false player cannot sell this house
		MaxWeight = 3000
    },
    {
        Id        = 132,
        Name      = "Dodge Ranch",
        Price     = 40000.0,
        key       = "hk_132",
        text      = vector3(1789.13, 464.2, 113.44),
        Inventory = vector3(1784.89, 460.19, 113.04),
        Doors     = {
            {
                object    = 2472180395,
                objCoords = vector3(1779.23, 461.57, 113.04),
                objYaw    = 100.0,
                locked    = true
            }
        },
        sell = true , -- if set false player cannot sell this house
		MaxWeight = 2000
    },
    {
        Id        = 133,
        Name      = "Clary Ranch",
        Price     = 40000.0,
        key       = "hk_133",
        text      = vector3(1375.84, -872.72, 70.43),
        Inventory = vector3(1374.52, -875.87, 70.13),
        Doors     = {
            {
                object    = 1282705079,
                objCoords = vector3(1375.84, -872.72, 70.13),
                objYaw    = 105.0,
                locked    = true
            },
            {
                object    = 1511858696,
                objCoords = vector3(1365.67, -873.33, 70.13),
                objYaw    = -73.0,
                locked    = true
            }
        },
        sell = true , -- if set false player cannot sell this house
		MaxWeight = 2000,

    },
    {
        Id        = 134,
        Name      = "Bluewater Farm",
        Price     = 30000.0,
        key       = "hk_134",
        text      = vector3(2237.55, -141.98, 48.03),
        Inventory = vector3(2237.8, -145.16, 47.63),
        Doors     = {
            {
                object    = 2689340659,
                objCoords = vector3(2235.26, -146.58, 47.63),
                objYaw    = 130.0,
                locked    = true
            },

            {
                object    = 1762076266,
                objCoords = vector3(2237.44, -142.07, 47.62),
                objYaw    = -50.0,
                locked    = true
            },
        },
        sell = true , -- if set false player cannot sell this house
		MaxWeight = 1500,
    },
}
