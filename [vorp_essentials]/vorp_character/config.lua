Config = {}

Config.DevMode = false
Config.Align = "top-left" -- menu

-- check translation file to see if your language is available or add it.
Lang = "English"

--* when player choosing a name  make sure it doesn't contain any of the words in the list below
Config.BannedNames = { "Arthur", "Marshton", "Shit", "Dick" } --* you can add more words

Config.AllowPlayerDeleteCharacter = true

-- after creating character player will spawn here
Config.SpawnCoords = {
    position = vector3(2563.02, -1202.64, 53.92),
    heading = 84.11}

Config.ShowGold = true -- this will show gold next to money in character selection

Config.Webhook = {
    deleteCharacter = ''
}
-- in here you can add multiple checks from other script to prevent players from using Rc command
Config.CanRunReload = function()
    -- callback ?
    -- statbebag ?
    return true -- dont touch
end

-- * PLAYER SELECTION MENU * --
-- loactions will be random each restart
-- max characters in vorp core will have to match the number of positions
Config.SpawnPosition = {
    -- Vanhorn
    {
        options = {
            timecycle = { name = "teaser_trainShot", strenght = 1.0 },                                         -- you can find more in RDR3 discoveries github
            music = "REHR_START",                                                                              -- you can find more in RDR3 discoveries github
            weather = { type = "sunny", transition = 10, snow = false },                                       -- weather to choose
            time = { hour = 12, transition = 10 },                                                             -- time to choose
            playerpos = vector3(2967.38, 488.73, 47.21),                                                       -- player spawn for textures to load in
            mainCam = { x = 2967.38, y = 488.73, z = 47.21, rotx = 0.0, roty = 0.0, rotz = 105.0, fov = 60.0 } -- main
        },
        positions = {
            {
                spawn = vector4(2959.76, 483.66, 47.39, 282.33),                                                 --location of ped
                camera = { x = 2963.62, y = 484.0, z = 47.87, rotx = 0.0, roty = 0.0, rotz = 90.0, fov = 60.0 }, --camera to look at ped
                scenario = {
                    -- animations will be random every time you join will choose one from the list
                    mp_female = {
                        "WORLD_HUMAN_SMOKE_CARRYING",
                        "MP_LOBBY_SCENARIO_08",
                        "WORLD_HUMAN_SMOKE_CARRYING"
                    },
                    mp_male = {
                        "WORLD_HUMAN_SMOKE_CARRYING",
                        "MP_LOBBY_SCENARIO_08",
                        "WORLD_HUMAN_SMOKE_CARRYING"
                    }
                }
            },
            {
                spawn = vector4(2960.83, 486.49, 46.82, 286.13),
                camera = { x = 2964.67, y = 487.25, z = 46.74, rotx = 0.0, roty = 0.0, rotz = 100.0, fov = 40.0 },
                scenario = {
                    mp_female = {
                        "MP_LOBBY_SCENARIO_02",
                        "MP_LOBBY_SCENARIO_04",
                        "MP_LOBBY_SCENARIO_07",
                        "WORLD_HUMAN_SMOKE_CARRYING"
                    },
                    mp_male = {
                        "MP_LOBBY_SCENARIO_02",
                        "MP_LOBBY_SCENARIO_04",
                        "MP_LOBBY_SCENARIO_07",
                        "WORLD_HUMAN_SMOKE_CARRYING"
                    },
                }
            },
            {
                spawn = vector4(2958.35, 487.81, 47.35, 283.9),
                camera = { x = 2962.18, y = 488.70, z = 46.90, rotx = 0.0, roty = 0.0, rotz = 90.0, fov = 60.0 },
                scenario = {
                    mp_female = {
                        "WORLD_HUMAN_SIT_GROUND_COFFEE_DRINK",
                        "MP_LOBBY_CROUCHING_B",
                        "WORLD_HUMAN_SIT_DRINK",
                        "WORLD_HUMAN_SIT_GROUND_READ_NEWSPAPER"
                    },
                    mp_male = {
                        "WORLD_HUMAN_SIT_GROUND_COFFEE_DRINK",
                        "MP_LOBBY_CROUCHING_B",
                        "WORLD_HUMAN_SIT_DRINK",
                        "WORLD_HUMAN_SIT_GROUND_READ_NEWSPAPER"
                    },
                }
            },
            {
                spawn = vector4(2960.69, 489.96, 46.59, 275.78),
                camera = { x = 2964.19, y = 490.46, z = 46.20, rotx = 0.0, roty = 0.0, rotz = 90.0, fov = 60.0 },
                scenario = {
                    mp_female = {
                        "WORLD_HUMAN_SIT_GROUND_COFFEE_DRINK",
                        "MP_LOBBY_CROUCHING_B",
                        "WORLD_HUMAN_SIT_DRINK",
                        "WORLD_HUMAN_SIT_GROUND_READ_NEWSPAPER"
                    },
                    mp_male = {
                        "WORLD_HUMAN_SIT_GROUND_COFFEE_DRINK",
                        "MP_LOBBY_CROUCHING_B",
                        "WORLD_HUMAN_SIT_DRINK",
                        "WORLD_HUMAN_SIT_GROUND_READ_NEWSPAPER"
                    },
                }
            },
            {
                spawn = vector4(2957.17, 490.24, 47.34, 257.62),                                                  --location of ped
                camera = { x = 2961.37, y = 490.16, z = 47.37, rotx = 0.0, roty = 0.0, rotz = 90.0, fov = 60.0 }, --camera to look at ped
                scenario = {
                    -- animations will be random every time you join will choose one from the list
                    mp_female = {
                        "MP_LOBBY_SCENARIO_02",
                        "MP_LOBBY_SCENARIO_04",
                        "WORLD_HUMAN_SMOKE_CARRYING",
                    },
                    mp_male = {
                        "MP_LOBBY_SCENARIO_02",
                        "MP_LOBBY_SCENARIO_04",
                        "WORLD_HUMAN_SMOKE_CARRYING",
                    }
                }
            },
        }
    },
    -- Vanhorn 2
    {
        options = {
            timecycle = { name = "Finale1_outrohighhon_bidging2", strenght = 1.0 },
            music     = "",
            weather   = { type = "sunny", transition = 10, snow = false },
            time      = { hour = 10, transition = 10 },
            playerpos = vector3(2963.14, 561.10, 44.68),
            mainCam   = { x = 2964.07, y = 558.95, z = 44.42, rotx = 1.76, roty = 0.00, rotz = -169.00, fov = 50.0 },
        },
        positions = {
            {
                spawn    = vector4(2964.51953125, 556.38671875, 44.45668792724609, 0.0),
                camera   = { x = 2963.80, y = 557.96, z = 44.82, rotx = -2.53, roty = 0.00, rotz = -154.64, fov = 50.0 },
                scenario = {
                    mp_female = {
                        "MP_COOP_LOBBY_STANDING_A"
                    },
                    mp_male = {
                        "MP_COOP_LOBBY_STANDING_A"
                    }
                }
            },
            {
                spawn    = vector4(2964.10107421875, 555.77001953125, 44.48249816894531, 45.93),
                camera   = { x = 2962.81, y = 557.48, z = 44.82, rotx = -4.29, roty = 0.00, rotz = -143.99, fov = 50.0 },
                scenario = {
                    mp_female = {
                        "MP_COOP_LOBBY_STANDING_D"

                    },
                    mp_male = {
                        "MP_COOP_LOBBY_STANDING_D"

                    },
                }
            },
            {
                spawn    = vector4(2963.728759765625, 554.9774169921875, 44.50360107421875, 40.43),
                camera   = { x = 2962.59, y = 556.35, z = 44.82, rotx = -2.53, roty = 0.00, rotz = -140.34, fov = 50.0 },
                scenario = {
                    mp_female = {
                        "MP_COOP_LOBBY_STANDING_A"
                    },
                    mp_male = {
                        "MP_COOP_LOBBY_STANDING_A"
                    },
                }
            },
            {
                spawn    = vector4(2965.1533203125, 555.9634399414062, 44.42756271362305, -51.0),
                camera   = { x = 2965.16, y = 557.78, z = 44.82, rotx = -3.09, roty = 0.00, rotz = -179.39, fov = 50.0 },
                scenario = {
                    mp_female = {
                        "MP_COOP_LOBBY_STANDING_C"
                    },
                    mp_male = {
                        "MP_COOP_LOBBY_STANDING_C"
                    },
                }
            },
            {
                spawn    = vector4(2965.91064453125, 555.1605834960938, 44.42335510253906, -56.0),
                camera   = { x = 2966.17, y = 557.13, z = 44.82, rotx = -3.28, roty = 0.00, rotz = 172.17, fov = 50.0 },
                scenario = {
                    mp_female = {
                        "MP_COOP_LOBBY_STANDING_D"
                    },
                    mp_male = {
                        "MP_COOP_LOBBY_STANDING_D"
                    }
                }
            },
        }
    },
    -- Saloon of Armadillo
    {
        options = {
            timecycle = { name = "teaser_trainShot", strenght = 1.0 },                                             -- you can find more in RDR3 discoveries github
            music = "REHR_START",                                                                                  -- you can find more in RDR3 discoveries github
            weather = { type = "sunny", transition = 10, snow = false },                                           -- weather to choose
            time = { hour = 12, transition = 10 },                                                                 -- time to choose
            playerpos = vector3(-3703.26, -2602.17, -13.27),                                                       -- where invisible player needs to spawn for textures to load in location
            mainCam = { x = -3707.83, y = -2599.98, z = -12.80, rotx = 5.0, roty = 0.0, rotz = -20.0, fov = 40.0 } -- main camera position
        },
        positions = {
            {
                spawn = vector4(-3706.8, -2589.74, -13.27, 204.89),                                                    --location of ped
                camera = { x = -3706.97, y = -2594.06, z = -12.90, rotx = -5.0, roty = 0.0, rotz = -3.0, fov = 30.0 }, --camera to look at ped
                scenario = {
                    mp_female = {
                        "WORLD_HUMAN_SMOKE_CARRYING",
                        "MP_LOBBY_SCENARIO_08",
                        "WORLD_HUMAN_SMOKE_CARRYING"
                    }, -- animations still animation ,select ,spawn for females
                    mp_male = {
                        "WORLD_HUMAN_SMOKE_CARRYING",
                        "MP_LOBBY_SCENARIO_08",
                        "WORLD_HUMAN_SMOKE_CARRYING"
                    },
                }
            },
            {
                spawn = vector4(-3701.46, -2592.47, -13.27, 139.94),
                camera = { x = -3703.89, y = -2596.37, z = -12.60, rotx = -10.0, roty = 0.0, rotz = -30.0, fov = 35.0 },
                scenario = {
                    mp_female = {
                        "MP_LOBBY_SCENARIO_02",
                        "MP_LOBBY_SCENARIO_04",
                        "MP_LOBBY_SCENARIO_07",
                        "WORLD_HUMAN_SMOKE_CARRYING"
                    },
                    mp_male = {
                        "MP_LOBBY_SCENARIO_02",
                        "MP_LOBBY_SCENARIO_04",
                        "MP_LOBBY_SCENARIO_07",
                        "WORLD_HUMAN_SMOKE_CARRYING"
                    },
                }
            },
            {
                spawn = vector4(-3702.79, -2587.09, -10.24, 176.87),
                camera = { x = -3702.87, y = -2589.9, z = -9.66, rotx = -15.0, roty = 0.0, rotz = 5.0, fov = 50.0 },
                scenario = {
                    mp_female = {
                        "MP_LOBBY_SCENARIO_02",
                        "MP_LOBBY_SCENARIO_04",
                        "MP_LOBBY_SCENARIO_07",
                        "WORLD_HUMAN_SMOKE_CARRYING"
                    },
                    mp_male = {
                        "MP_LOBBY_SCENARIO_02",
                        "MP_LOBBY_SCENARIO_04",
                        "MP_LOBBY_SCENARIO_07",
                        "WORLD_HUMAN_SMOKE_CARRYING"
                    },
                }
            },
            {
                spawn = vector4(-3702.5, -2589.02, -13.32, 160.76),
                camera = { x = -3702.7, y = -2592.5, z = -12.8, rotx = -15.0, roty = 0.0, rotz = 5.0, fov = 50.0 },
                scenario = {
                    mp_female = {
                        "MP_LOBBY_SCENARIO_02",
                        "MP_LOBBY_SCENARIO_04",
                        "MP_LOBBY_SCENARIO_07",
                        "WORLD_HUMAN_SMOKE_CARRYING"
                    },
                    mp_male = {
                        "MP_LOBBY_SCENARIO_02",
                        "MP_LOBBY_SCENARIO_04",
                        "MP_LOBBY_SCENARIO_07",
                        "WORLD_HUMAN_SMOKE_CARRYING"
                    },
                }
            },
            {
                spawn = vector4(-3698.99, -2589.17, -10.29, 85.26),
                camera = { x = -3700.80, y = -2590.87, z = -9.59, rotx = -15.0, roty = 0.0, rotz = -50.0, fov = 50.0 },
                scenario = {
                    mp_female = {
                        "MP_LOBBY_SCENARIO_02",
                        "MP_LOBBY_SCENARIO_04",
                        "MP_LOBBY_SCENARIO_07",
                        "WORLD_HUMAN_SMOKE_CARRYING"
                    },
                    mp_male = {
                        "MP_LOBBY_SCENARIO_02",
                        "MP_LOBBY_SCENARIO_04",
                        "MP_LOBBY_SCENARIO_07",
                        "WORLD_HUMAN_SMOKE_CARRYING"
                    },
                }
            },
        }
    },
    -- Cotorra Springs
    {
        options = {
            timecycle = { name = "finale2_campMoonPos", strenght = 1.0 },
            music     = "",
            weather   = { type = "sunny", transition = 10, snow = false },
            time      = { hour = 10, transition = 10 },
            playerpos = vector3(240.46421813964844, 1968.3095703125, 206.56849670410156),
            mainCam   = { x = 241.50, y = 1966.36, z = 205.82, rotx = 0.13, roty = 0.00, rotz = 177.52, fov = 55.0 },
        },
        positions = {
            {
                spawn    = vector4(241.28634643554688, 1963.6492919921875, 205.7147674560547, -13.41),
                camera   = { x = 241.03, y = 1965.26, z = 205.98, rotx = 2.47, roty = 0.00, rotz = -170.29, fov = 50.0 },
                scenario = {
                    mp_female = {
                        "MP_COOP_LOBBY_STANDING_A",
                    },
                    mp_male = {
                        "MP_COOP_LOBBY_STANDING_A",
                    }
                }
            },
            {
                spawn    = vector4(240.3826904296875, 1962.885986328125, 205.5716094970703, 0.90),
                camera   = { x = 239.81, y = 1964.61, z = 205.92, rotx = 0.27, roty = 0.00, rotz = -160.84, fov = 50.0 },
                scenario = {
                    mp_female = {
                        "MP_COOP_LOBBY_STANDING_D",
                    },
                    mp_male = {
                        "MP_COOP_LOBBY_STANDING_D",
                    },
                }
            },
            {
                spawn    = vector4(239.3123321533203, 1962.4949951171875, 205.47006225585938, -1.40),
                camera   = { x = 239.01, y = 1964.32, z = 205.58, rotx = 2.46, roty = 0.00, rotz = -168.28, fov = 50.0 },
                scenario = {
                    mp_female = {
                        "MP_COOP_LOBBY_STANDING_A",
                    },
                    mp_male = {
                        "MP_COOP_LOBBY_STANDING_A",
                    },
                }
            },
            {
                spawn    = vector4(242.06687927246094, 1962.82861328125, 205.6053924560547, -47.0),
                camera   = { x = 242.81, y = 1964.24, z = 205.95, rotx = -1.18, roty = 0.00, rotz = 154.06, fov = 50.0 },
                scenario = {
                    mp_female = {
                        "MP_COOP_LOBBY_STANDING_C",
                    },
                    mp_male = {
                        "MP_COOP_LOBBY_STANDING_C",
                    },
                }
            },
            {
                spawn    = vector4(242.54800415039062, 1961.7637939453125, 205.44102478027344, -44.0),
                camera   = { x = 243.38, y = 1963.29, z = 205.83, rotx = -1.75, roty = 0.00, rotz = 152.17, fov = 50.0 },
                scenario = {
                    mp_female = {
                        "WORLD_HUMAN_SMOKE",
                    },
                    mp_male = {
                        "WORLD_HUMAN_SMOKE",
                    }
                }
            },
        }
    },
    -- Donner Falls
    {
        options = {
            timecycle = { name = "trailer2_shot1", strenght = 1.0 },
            music     = "",
            weather   = { type = "sunny", transition = 10, snow = false },
            time      = { hour = 10, transition = 10 },
            playerpos = vector3(394.7771301269531, 1672.5684814453125, 127.14893341064453),
            mainCam   = { x = 397.08, y = 1672.30, z = 128.27, rotx = 4.64, roty = 0.00, rotz = -45.14, fov = 55.0 },
        },
        positions = {
            {
                spawn    = vector4(399.0948791503906, 1674.13623046875, 128.34893798828125, 121.97),
                camera   = { x = 398.27, y = 1672.93, z = 128.59, rotx = 3.59, roty = 0.00, rotz = -32.96, fov = 50.0 },
                scenario = {
                    mp_female = {
                        "MP_COOP_LOBBY_STANDING_A",
                    },
                    mp_male = {
                        "MP_COOP_LOBBY_STANDING_A",
                    }
                }
            },
            {
                spawn    = vector4(400.1960144042969, 1674.1185302734375, 128.2821807861328, 165.66),
                camera   = { x = 399.36, y = 1672.33, z = 128.59, rotx = -1.39, roty = 0.00, rotz = -24.70, fov = 50.0 },
                scenario = {
                    mp_female = {
                        "MP_COOP_LOBBY_STANDING_D",
                    },
                    mp_male = {
                        "MP_COOP_LOBBY_STANDING_D",
                    },
                }
            },
            {
                spawn    = vector4(401.34051513671875, 1674.3046875, 128.2012939453125, -158.24),
                camera   = { x = 400.68, y = 1672.99, z = 128.40, rotx = 4.22, roty = 0.00, rotz = -29.49, fov = 50.0 },
                scenario = {
                    mp_female = {
                        "MP_COOP_LOBBY_STANDING_A",
                    },
                    mp_male = {
                        "MP_COOP_LOBBY_STANDING_A",
                    },
                }
            },

            {
                spawn    = vector4(399.1690979003906, 1675.1075439453125, 128.34046936035156, 78.19),
                camera   = { x = 397.64, y = 1675.19, z = 128.53, rotx = 1.38, roty = 0.00, rotz = -88.89, fov = 50.0 },
                scenario = {
                    mp_female = {
                        "MP_COOP_LOBBY_STANDING_C",
                    },
                    mp_male = {
                        "MP_COOP_LOBBY_STANDING_C",
                    },
                }
            },
            {
                spawn    = vector4(399.4101867675781, 1676.465087890625, 128.29788208007812, 97.04),
                camera   = { x = 397.11, y = 1675.48, z = 128.54, rotx = 3.55, roty = 0.00, rotz = -60.97, fov = 50.0 },
                scenario = {
                    mp_female = {
                        "WORLD_HUMAN_SMOKE",
                    },
                    mp_male = {
                        "WORLD_HUMAN_SMOKE",
                    }
                }
            },
        }
    },
    -- The HeartLands 1
    {
        options = {
            timecycle = { name = "martson1_intromod2", strenght = 1.0 },
            music     = "",
            weather   = { type = "sunny", transition = 10, snow = false },
            time      = { hour = 10, transition = 10 },
            playerpos = vector3(178.41, 121.52, 105.28),
            mainCam   = { x = 180.76, y = 125.44, z = 104.26, rotx = 4.06, roty = 0.00, rotz = -61.33, fov = 50.0 },
        },
        positions = {
            {
                spawn    = vector4(182.7963409423828, 126.51189422607422, 104.46258544921875, 122.99),
                camera   = { x = 181.80, y = 125.43, z = 104.80, rotx = -5.57, roty = 0.00, rotz = -38.77, fov = 50.0 },
                scenario = {
                    mp_female = {
                        "MP_COOP_LOBBY_STANDING_A"
                    },
                    mp_male = {
                        "MP_COOP_LOBBY_STANDING_A"
                    }
                }
            },
            {
                spawn    = vector4(183.80235290527344, 126.40680694580078, 104.3888931274414, 170.61),
                camera   = { x = 182.81, y = 125.27, z = 104.80, rotx = -8.41, roty = 0.00, rotz = -41.17, fov = 50.0 },
                scenario = {
                    mp_female = {
                        "MP_COOP_LOBBY_STANDING_D"
                    },
                    mp_male = {
                        "MP_COOP_LOBBY_STANDING_D"
                    },
                }
            },
            {
                spawn    = vector4(184.9395294189453, 126.3748779296875, 104.34683990478516, 178.99),
                camera   = { x = 183.94, y = 125.05, z = 104.80, rotx = -6.33, roty = 0.00, rotz = -37.45, fov = 50.0 },
                scenario = {
                    mp_female = {
                        "MP_COOP_LOBBY_STANDING_A"
                    },
                    mp_male = {
                        "MP_COOP_LOBBY_STANDING_A"
                    },
                }
            },
            {
                spawn    = vector4(183.17520141601562, 127.44035339355469, 104.51107025146484, 88.93),
                camera   = { x = 182.02, y = 128.39, z = 104.80, rotx = -4.44, roty = 0.00, rotz = -127.59, fov = 50.0 },
                scenario = {
                    mp_female = {
                        "MP_COOP_LOBBY_STANDING_C"
                    },
                    mp_male = {
                        "MP_COOP_LOBBY_STANDING_C"
                    },
                }
            },
            {
                spawn    = vector4(183.69700622558594, 128.34262084960938, 104.5129165649414, 85.22),
                camera   = { x = 182.57, y = 129.46, z = 104.80, rotx = -1.98, roty = 0.00, rotz = -134.39, fov = 50.0 },
                scenario = {
                    mp_female = {
                        "MP_COOP_LOBBY_STANDING_D"
                    },
                    mp_male = {
                        "MP_COOP_LOBBY_STANDING_D"
                    }
                }
            },
        }
    },
    -- The HeartLands 2
    {
        options = {
            timecycle = { name = "FINALE2_campMoonPos", strenght = 1.0 },
            music     = "",
            weather   = { type = "sunny", transition = 10, snow = false },
            time      = { hour = 10, transition = 10 },
            playerpos = vector3(484.17, -288.31, 144.68),
            mainCam   = { x = 486.16, y = -289.88, z = 144.19, rotx = 1.67, roty = 0.00, rotz = -145.28, fov = 50.0 },
        },
        positions = {
            {
                spawn    = vector4(487.70672607421875, -292.080322265625, 144.1527862548828, 22.96),
                camera   = { x = 486.31, y = -291.28, z = 144.68, rotx = -8.15, roty = 0.00, rotz = -119.39, fov = 50.0 },
                scenario = {
                    mp_female = {
                        "MP_COOP_LOBBY_STANDING_A"
                    },
                    mp_male = {
                        "MP_COOP_LOBBY_STANDING_A"
                    }
                }
            },
            {
                spawn    = vector4(487.6447448730469, -293.106689453125, 144.15354919433594, 65.84),
                camera   = { x = 486.35, y = -292.62, z = 144.68, rotx = -8.22, roty = 0.00, rotz = -110.88, fov = 50.0 },
                scenario = {
                    mp_female = {
                        "MP_COOP_LOBBY_STANDING_D"

                    },
                    mp_male = {
                        "MP_COOP_LOBBY_STANDING_D"

                    },
                }
            },
            {
                spawn    = vector4(487.7176208496094, -294.1673278808594, 144.1559295654297, 61.68),
                camera   = { x = 486.46, y = -293.72, z = 144.68, rotx = -9.48, roty = 0.00, rotz = -110.00, fov = 50.0 },
                scenario = {
                    mp_female = {
                        "MP_COOP_LOBBY_STANDING_A"
                    },
                    mp_male = {
                        "MP_COOP_LOBBY_STANDING_A"
                    },
                }
            },
            {
                spawn    = vector4(488.6108093261719, -292.263916015625, 144.1641082763672, -12.58),
                camera   = { x = 488.30, y = -290.89, z = 144.68, rotx = -11.11, roty = 0.00, rotz = -168.96, fov = 50.0 },
                scenario = {
                    mp_female = {
                        "MP_COOP_LOBBY_STANDING_C"
                    },
                    mp_male = {
                        "MP_COOP_LOBBY_STANDING_C"
                    },
                }
            },
            {
                spawn    = vector4(489.6289367675781, -292.4676208496094, 144.17864990234375, -17.24),
                camera   = { x = 489.19, y = -290.84, z = 144.68, rotx = -8.53, roty = 0.00, rotz = -165.81, fov = 50.0 },
                scenario = {
                    mp_female = {
                        "MP_COOP_LOBBY_STANDING_D"
                    },
                    mp_male = {
                        "MP_COOP_LOBBY_STANDING_D"
                    }
                }
            },
        }
    },
    -- Swamps 1
    {
        options = {
            timecycle = { name = "Finale1_outrohighhon_bidging2", strenght = 1.0 },
            music     = "",
            weather   = { type = "sunny", transition = 10, snow = false },
            time      = { hour = 10, transition = 10 },
            playerpos = vector3(2152.28, -609.59, 41.96),
            mainCam   = { x = 2153.71, y = -611.14, z = 41.40, rotx = 5.92, roty = 0.00, rotz = -135.36, fov = 50.0 },
        },
        positions = {
            {
                spawn    = vector4(2155.578125, -613.0398559570312, 41.54308700561523, 25.46),
                camera   = { x = 2154.30, y = -612.19, z = 41.86, rotx = -1.01, roty = 0.00, rotz = -123.52, fov = 50.0 },
                scenario = {
                    mp_female = {
                        "MP_COOP_LOBBY_STANDING_A"
                    },
                    mp_male = {
                        "MP_COOP_LOBBY_STANDING_A"
                    }
                }
            },
            {
                spawn    = vector4(2155.3779296875, -613.9125366210938, 41.54896926879883, 80.25),
                camera   = { x = 2153.90, y = -613.56, z = 41.86, rotx = -0.63, roty = 0.00, rotz = -103.11, fov = 50.0 },
                scenario = {
                    mp_female = {
                        "MP_COOP_LOBBY_STANDING_D"

                    },
                    mp_male = {
                        "MP_COOP_LOBBY_STANDING_D"

                    },
                }
            },
            {
                spawn    = vector4(2155.763427734375, -615.0479125976562, 41.55394744873047, 70.41),
                camera   = { x = 2154.14, y = -614.62, z = 41.86, rotx = 1.32, roty = 0.00, rotz = -104.81, fov = 50.0 },
                scenario = {
                    mp_female = {
                        "MP_COOP_LOBBY_STANDING_A"
                    },
                    mp_male = {
                        "MP_COOP_LOBBY_STANDING_A"
                    },
                }
            },
            {
                spawn    = vector4(2156.56884765625, -612.965576171875, 41.54000473022461, -9.0),
                camera   = { x = 2156.57, y = -611.24, z = 41.95, rotx = -4.41, roty = 0.00, rotz = -178.63, fov = 50.0 },
                scenario = {
                    mp_female = {
                        "MP_COOP_LOBBY_STANDING_C"
                    },
                    mp_male = {
                        "MP_COOP_LOBBY_STANDING_C"
                    },
                }
            },
            {
                spawn    = vector4(2157.820068359375, -613.3458862304688, 41.55184936523437, 5.29),
                camera   = { x = 2157.74, y = -611.58, z = 41.95, rotx = -3.15, roty = 0.00, rotz = -177.56, fov = 50.0 },
                scenario = {
                    mp_female = {
                        "MP_COOP_LOBBY_STANDING_D"
                    },
                    mp_male = {
                        "MP_COOP_LOBBY_STANDING_D"
                    }
                }
            },
        }
    },
    -- Colter
    {
        options = {
            timecycle = { name = "mod5_int_lessfog", strenght = 1.0 },
            music     = "",
            weather   = { type = "sunny", transition = 10, snow = false },
            time      = { hour = 10, transition = 10 },
            playerpos = vector3(-1325.81, 2474.81, 309.75),
            mainCam   = { x = -1326.78, y = 2472.99, z = 309.75, rotx = 2.17, roty = 0.00, rotz = -165.38, fov = 50.0 },
        },
        positions = {
            {
                spawn    = vector4(-1326.1461181640625, 2470.50244140625, 309.5157165527344, 3.5),
                camera   = { x = -1327.19, y = 2471.72, z = 309.90, rotx = -5.64, roty = 0.00, rotz = -136.97, fov = 50.0 },
                scenario = {
                    mp_female = {
                        "MP_COOP_LOBBY_STANDING_A"
                    },
                    mp_male = {
                        "MP_COOP_LOBBY_STANDING_A"
                    }
                }
            },
            {
                spawn    = vector4(-1326.5155029296875, 2469.6474609375, 309.48480224609375, 27.79),
                camera   = { x = -1327.49, y = 2471.00, z = 309.93, rotx = -9.42, roty = 0.00, rotz = -143.21, fov = 50.0 },
                scenario = {
                    mp_female = {
                        "MP_COOP_LOBBY_STANDING_D"

                    },
                    mp_male = {
                        "MP_COOP_LOBBY_STANDING_D"

                    },
                }
            },
            {
                spawn    = vector4(-1326.728759765625, 2468.68310546875, 309.46185302734375, 46.91),
                camera   = { x = -1327.83, y = 2469.80, z = 309.93, rotx = -4.94, roty = 0.00, rotz = -136.53, fov = 50.0 },
                scenario = {
                    mp_female = {
                        "MP_COOP_LOBBY_STANDING_A"
                    },
                    mp_male = {
                        "MP_COOP_LOBBY_STANDING_A"
                    },
                }
            },
            {
                spawn    = vector4(-1325.2999267578125, 2469.999755859375, 309.5245361328125, -17.53),
                camera   = { x = -1324.98, y = 2471.68, z = 309.93, rotx = -8.09, roty = 0.00, rotz = 168.98, fov = 50.0 },
                scenario = {
                    mp_female = {
                        "MP_COOP_LOBBY_STANDING_C"
                    },
                    mp_male = {
                        "MP_COOP_LOBBY_STANDING_C"
                    },
                }
            },
            {
                spawn    = vector4(-1324.438232421875, 2469.408447265625, 309.5310974121094, -30.19),
                camera   = { x = -1323.99, y = 2470.97, z = 309.93, rotx = -4.63, roty = 0.00, rotz = 164.38, fov = 50.0 },
                scenario = {
                    mp_female = {
                        "MP_COOP_LOBBY_STANDING_D"
                    },
                    mp_male = {
                        "MP_COOP_LOBBY_STANDING_D"
                    }
                }
            },
        }
    },
    -- Manzanita Post
    {
        options = {
            timecycle = { name = "winter4_ride_sunstrength2", strenght = 1.0 },
            music     = "",
            weather   = { type = "sunny", transition = 10, snow = false },
            time      = { hour = 10, transition = 10 },
            playerpos = vector3(-1957.59, -1612.63, 115.69),
            mainCam   = { x = -1959.05, y = -1613.00, z = 115.69, rotx = 10.32, roty = 0.00, rotz = 103.69, fov = 50.0 },
        },
        positions = {
            {
                spawn    = vector4(-1961.74462890625, -1613.662353515625, 115.97038269042969, -91.2),
                camera   = { x = -1960.22, y = -1612.66, z = 116.28, rotx = 0.87, roty = 0.00, rotz = 124.16, fov = 50.0 },
                scenario = {
                    mp_female = {
                        "MP_COOP_LOBBY_STANDING_A"
                    },
                    mp_male = {
                        "MP_COOP_LOBBY_STANDING_A"
                    }
                }
            },
            {
                spawn    = vector4(-1962.37548828125, -1613.1929931640625, 116.01429748535156, -37.79),
                camera   = { x = -1961.40, y = -1611.68, z = 116.28, rotx = -1.33, roty = 0.00, rotz = 148.73, fov = 50.0 },
                scenario = {
                    mp_female = {
                        "MP_COOP_LOBBY_STANDING_D"
                    },
                    mp_male = {
                        "MP_COOP_LOBBY_STANDING_D"
                    },
                }
            },
            {
                spawn    = vector4(-1963.42822265625, -1612.8199462890625, 116.08049011230469, -34.0),
                camera   = { x = -1962.37, y = -1611.23, z = 116.28, rotx = 1.31, roty = 0.00, rotz = 146.08, fov = 50.0 },
                scenario = {
                    mp_female = {
                        "MP_COOP_LOBBY_STANDING_A"
                    },
                    mp_male = {
                        "MP_COOP_LOBBY_STANDING_A"
                    },
                }
            },

            {
                spawn    = vector4(-1962.11572265625, -1614.4964599609375, 116.00640869140625, -133.0),
                camera   = { x = -1960.49, y = -1614.82, z = 116.28, rotx = -1.33, roty = 0.00, rotz = 77.92, fov = 50.0 },
                scenario = {
                    mp_female = {
                        "MP_COOP_LOBBY_STANDING_C"
                    },
                    mp_male = {
                        "MP_COOP_LOBBY_STANDING_C"
                    },
                }
            },
            {
                spawn    = vector4(-1962.7508544921875, -1615.2008056640625, 116.0385513305664, -148.0),
                camera   = { x = -1961.18, y = -1615.87, z = 116.28, rotx = 1.12, roty = 0.00, rotz = 68.41, fov = 50.0 },
                scenario = {
                    mp_female = {
                        "MP_COOP_LOBBY_STANDING_D"
                    },
                    mp_male = {
                        "MP_COOP_LOBBY_STANDING_D"
                    }
                }
            },
        }
    },
    -- Armadillo Cemetery
    {
        options = {
            timecycle = { name = "finale2_campmoonpos", strenght = 1.0 },
            music     = "",
            weather   = { type = "sunny", transition = 10, snow = false },
            time      = { hour = 10, transition = 10 },
            playerpos = vector3(-3317.17, -2824.74, -6.07),
            mainCam   = { x = -3320.76, y = -2823.50, z = -6.07, rotx = 3.21, roty = 0.00, rotz = -175.24, fov = 50.0 },
        },
        positions = {
            {
                spawn    = vector4(-3320.525634765625, -2826.189697265625, -6.14256906509399, -12.0),
                camera   = { x = -3321.13, y = -2824.70, z = -5.77, rotx = -5.10, roty = 0.00, rotz = -156.72, fov = 50.0 },
                scenario = {
                    mp_female = {
                        "MP_COOP_LOBBY_STANDING_A"
                    },
                    mp_male = {
                        "MP_COOP_LOBBY_STANDING_A"
                    }
                }
            },
            {
                spawn    = vector4(-3320.9775390625, -2826.91162109375, -6.20029354095459, 38.11),
                camera   = { x = -3321.85, y = -2825.28, z = -5.77, rotx = -3.72, roty = 0.00, rotz = -152.49, fov = 50.0 },
                scenario = {
                    mp_female = {
                        "MP_COOP_LOBBY_STANDING_D"
                    },
                    mp_male = {
                        "MP_COOP_LOBBY_STANDING_D"
                    },
                }
            },
            {
                spawn    = vector4(-3321.275146484375, -2827.922607421875, -6.22911691665649, 39.59),
                camera   = { x = -3322.58, y = -2826.46, z = -5.77, rotx = -6.05, roty = 0.00, rotz = -139.45, fov = 50.0 },
                scenario = {
                    mp_female = {
                        "MP_COOP_LOBBY_STANDING_A"
                    },
                    mp_male = {
                        "MP_COOP_LOBBY_STANDING_A"
                    },
                }
            },
            {
                spawn    = vector4(-3319.898681640625, -2826.728271484375, -6.10577821731567, -50.86),
                camera   = { x = -3319.01, y = -2825.16, z = -5.77, rotx = -4.29, roty = 0.00, rotz = 151.13, fov = 50.0 },
                scenario = {
                    mp_female = {
                        "MP_COOP_LOBBY_STANDING_C"
                    },
                    mp_male = {
                        "MP_COOP_LOBBY_STANDING_C"
                    },
                }
            },
            {
                spawn    = vector4(-3319.260498046875, -2827.394775390625, -6.08130264282226, -66.57),
                camera   = { x = -3318.73, y = -2825.75, z = -5.77, rotx = -1.26, roty = 0.00, rotz = 163.98, fov = 50.0 },
                scenario = {
                    mp_female = {
                        "MP_COOP_LOBBY_STANDING_D"
                    },
                    mp_male = {
                        "MP_COOP_LOBBY_STANDING_D"
                    }
                }
            },
        }
    },
}

-- Keyboards
Config.keys = {
    prompt_create = { key = 0x9959A6F0 },                           -- [ C ]
    prompt_delete = { key = 0x3F4DC0EF },                           -- [ DELETE ]
    prompt_swap = { key = 0xA65EBAB4 },                             -- [ LEFT ARROW ]
    prompt_select = { key = 0xC7B5340A },                           -- [ NUM ENTER ]
    prompt_choose_gender_M = { key = 0xA65EBAB4 },                  -- [ LEFT ARROW  ]
    prompt_choose_gender_F = { key = 0xDEB34313 },                  -- [ RIGHT ARROW ]
    prompt_select_gender = { key = 0xD9D0E1C0 },                    -- [ SPACE ]
    prompt_camera_ws = { key = 0x8FD015D8, key2 = 0xD27782E3 },     -- [ W ] and [ S ]
    prompt_camera_rotate = { key = 0x7065027D, key2 = 0xB4E465B4 }, -- [ A ] and [ D ]
    prompt_zoom = { key = 0x8BDE7443, key2 = 0x62800C92 },          -- [ MOUSE SCROLL DOWN ] and [ MOUSE SCROLL UP ]
}

Config.commands = {
    CoatClosed = { command = "ccoat" },
    Hat = { command = "hat" },
    EyeWear = { command = "eyewear" },
    Mask = { command = "mask" },
    NeckWear = { command = "neckwear" },
    NeckTies = { command = "tie" },
    Shirt = { command = "shirt" },
    Vest = { command = "vest" },
    Coat = { command = "coat" },
    Poncho = { command = "poncho" },
    Cloak = { command = "cloak" },
    Glove = { command = "glove" },
    Bracelet = { command = "bracelet" },
    Buckle = { command = "buckle" },
    Pant = { command = "pant" },
    Skirt = { command = "skirt" },
    Chap = { command = "chap" },
    Boots = { command = "boots" },
    Spurs = { command = "spurs" },
    Spats = { command = "spats" },
    GunbeltAccs = { command = "gunbeltaccs" },
    Gauntlets = { command = "gauntlets" },
    Loadouts = { command = "loadouts" },
    Accessories = { command = "accessories" },
    Satchels = { command = "satchels" },
    Dress = { command = "dresses" },
    Belt = { command = "belt" },
    Holster = { command = "holster" },
    Suspender = { command = "suspender" },
    armor = { command = "armor" },
    Gunbelt = { command = "gunbelt" },
}


Config.DefaultChar = {
    Male = {
        {
            label = "White fella", -- change label only
            imgColor = "white",    -- change img only
            Heads = { "A0BE4A7B", "1E78F6D", "27A4DC22", "5E9A394D", "7BE9E352", "7D7AA347", "839997EF", "84F3E485",
                "876B1FAE", "8BC1469D", "9324DB9E", "970F3409", "A11747C5", "CA6DABEE",
                "DC8DA4BA", "DFBFB8F4", "ED8EDA8E", "E79A7372", "E78826B1", "F0FB1DF0", },
            Body = { "206061DB", "16E292A1", "206061DB", "4AEEDD87", "4BD8F4A1", "BA59624D", "F6496128" },
            Legs = { "84BAA309", "8AD16414", "A615E02", "E4B584D5", "F11CF1FA", "F2EA7BDE" },
            HeadTexture = { "mp_head_mr1_sc08_c0_000_ab" },
        },
        {
            label = "Mexican",
            imgColor = "white2",
            Heads = { "3625908B", "40365810", "613CF195", "66B5DE24", "7AFEF216", "8574F682", "91417D14",
                "93C69313", "9D604053", "A23ED555", "AC2963F2", "C1130197", "C55F46B9", "CF482B6A", "D89ED98E",
                "D879AA64", "E4FF6111",
                "F4696EBC", "D3D6DD59", "F3CE707E", },
            Body = { "3825D527", "5A929214", "82F14D87", "99E82863", "DF522C3A" },
            Legs = { "15ACBB1D", "97596A2A", "EA27EDE2", "F91940A6", "9EE7070B", "D7F34979" },
            HeadTexture = { "mp_head_mr1_sc02_c0_000_ab" },
        },
        {
            label = "Asian",
            imgColor = "white3",
            Heads = { "158CB7F2", "36739C03", "48133466", "4E11220E", "68C7CDA8", "6DF5043C", "6EF1C97C",
                "771A7EE9", "7B035098", "89556A4D", "9DD7C74F", "A156BC1F", "AFCDE52E", "C6077794",
                "DD95F0D7", "4BCC286D", "D7506A9B", "D1B722DF",
                "D7CDC6AE", "E718D713", },
            Body = { "465F719A", "6D582255", "8CC97681", "B0D24F3F" },
            Legs = { "47FE9FC0", "64F9856B", "B0F62B29", "ACAE409" },
            HeadTexture = { "mp_head_mr1_sc03_c0_000_ab" },
        },
        {
            label = "Native Dark",
            imgColor = "brown",
            Heads = { "4C5C14D1", "2BADE2F9", "32E0BD65", "51EE52F8", "53361205", "7150F35A", "7320223C",
                "8036DB0B", "8239BA1C", "4DAD06D9", "93C8CFE3", "B0B07238", "BC310F75", "B9C497C7",
                "C00E8CF7", "C2978B19", "FEC87D01", "89601857", "FEB1F6D4", "936FAFDE", },
            Body = { "34C3B131", "5C1686B", "8C9686C8", "BF787383" },
            Legs = { "F5E0272A", "B897BFA0", "C17616E", "73710076", "B897BFA0" },
            HeadTexture = { "MP_head_fr1_sc01_c0_000_ab" },
        },
        {
            label = "Native",
            imgColor = "brown2",
            Heads = { "1EF1D4F5", "20BEAD17", "17E48A5C", "1D1391CB", "3E1D8D10", "41FB09E2", "421209B8",
                "44C938AE", "465D3511", "48531C43", "5A5A4569", "69A6DC4D", "87198A9F", "8C099185",
                "9AD0D9E0",
                "9B593624", "A9918F1E", "AF4B1442", "E2BED257", "F769DA58", },
            Body = { "4824ED39", "3B6F503", "5EA984F8", "B4485D23", "6BB6BC48" },
            Legs = { "D3A7708B", "5B835093", "DDF48A5D", "35D1FB67" },
            HeadTexture = { "mp_head_mr1_sc04_c0_000_ab" },
        },
        {
            label = "African",
            imgColor = "black",
            Heads = { "101E374E", "47A369D9", "48A3A1FC", "4C55A1AB", "5248AA25", "52CC549C", "54CED1F4",
                "6817A7D2", "6B50E776", "729570C7", "8B921D0F", "9BE9739A", "9CCAB601", "A0D12D3E", "A9A2BECB",
                "AC877D4D", "BB432C32",
                "B6316BD4", "BF97F8A1", "FAEAC26", },
            Body = { "69B6305B", "BA09D8ED", "C8EA5978", "CD7F8895" },
            Legs = { "52CC3F25", "6577142C", "6CBCE93C", "887C4C70", "EF9D2DAE" },
            HeadTexture = { "mp_head_fr1_sc05_c0_000_ab" },
        },

    },
    Female = {
        {
            label = "White",
            imgColor = "", --todo
            Heads = { "76ACA91E", "30378AB3", "478C7817", "6D06466A", "772F8047", "7C1A194E", "87311A4B",
                "18665C91", "1B15AE7A", "20F6540D", "F8332625", "ED123FBD", "EBCEE04E", "C28AB791", "BBD7BFC",
                "B3BA8C05", "A661B163", "AAC2D8A9", "9D251F06", "945686CF" },
            Body = { "489AFE52", "64181923", "8DCF7A49", "928DAD43", "B1D3B3A", "D878696D" },
            Legs = { "11A244CC", "3B653032", "41021120", "A0736DA7", "C3BFA017", "F0CD92EC" },
            HeadTexture = { "mp_head_fr1_sc08_c0_000_ab" },
        },
        {
            label = "Mexican",
            imgColor = "",
            Heads = { "1C851DA8", "2E1791E1", "477D749A", "62534D55", "6D8686E8", "87371192", "886DB564",
                "8A1E0CED", "FEA98F74", "E64076CE", "E6377EEA", "E4EE32DC", "CDDA79D6", "C9677F2B", "BBF9DC7A",
                "C2E3978", "BB8088E4", "B00FC4DB", "A2B1D14C", "B240A051" },
            Body = { "8002D0F8", "6C25B6F6", "8223BCC5", "2BE27CC4", "C1CF0BC1" },
            Legs = { "18916A9B", "4D38CBC5", "98975DF3", "DC1AD9D2", "E74007F9" },
            HeadTexture = { "mp_head_fr1_sc02_c0_000_ab" },
        },
        {
            label = "Asian",
            imgColor = "",
            Heads = { "1E6FDDFB", "30B5C9FA", "43857351", "50A1A9F2", "5A274672", "6369FC85", "65A5CE70",
                "6DCBE781", "E23268F4", "D406DA89", "D47BD345", "DEE3A266", "D3949F79",
                "C93AA458", "C9D5F867", "C6B7F1F6", "AAB53384", "A4372E08", "98B8DD4C", "47BC4C6", },
            Body = { "2C4FE0C5", "3708268F", "7145337D", "79D35251", "B2850A03" },
            Legs = { "3E152D7E", "C9903FE8", "CC543A45", "24CF58B7", "1684BC22" },
            HeadTexture = { "mp_head_fr1_sc03_c0_000_ab" },
        },
        {
            label = "African",
            imgColor = "",
            Heads = { "11567C3", "1D896D8D", "24452D0B", "34FC0B13", "43F08B06", "53B5B98F", "5DC6A042",
                "5F192A74", "7F2AAA30", "89B0F7FE", "E72483EC", "CC66815D", "C65BEAD1", "B3F26095",
                "AB545F5A", "9D3F64C1",
                "9B4BDB4C", "9409E68", "93DA499", "E8E50D99" },
            Body = { "5B4E1547", "58D8EA30", "87363366", "D0C5A9AE", "DC86C81" },
            Legs = { "CEAB4EC0", "DBE4E491", "5B4E1547", "F9609455", "3DBEB4BD" },
            HeadTexture = { "mp_head_fr1_sc05_c0_000_ab" },
        },
        {
            label = "Native",
            imgColor = "",
            Heads = { "2AE6E5C", "4A52F943", "50882CFA", "", "65F9F637", "6A0AB89D", "8E53BDC1",
                "F7AC67A8", "E6648288", "E25DCD6C", "CDC2BD9", "C71039E6", "BFAFA3EF", "B8F8F515",
                "B2155087", "ADD7ED93", "B059132E", "A6F0329C", "11F10982", "DB4094A2", "C770CAA5", },
            Body = { "80DB09DE", "93925FA2", "94778799", "56617DB6", "E36416C" },
            Legs = { "31BE7295", "71821457", "9D6CD26", "A29CE6D7", "A65CF97E" },
            HeadTexture = { "mp_head_fr1_sc01_c0_000_ab" },
        },
        {
            label = "Native",
            imgColor = "",
            Heads = {
                "11F69034", "169B95C6", "1C32EE08", "22B4E685", "3129C6F1", "3C7D04E4",
                "40E72684", "75AF6E83", "8A7F3F41", "8CD1ABC6", "544D8D50", "F70CFFFC", "E6F8006B", "E1D23BF4",
                "D150CE67", "B57F73B0",
                "986F1565", "9C879729", "16C5E95A", "93F68D87", },
            Body = { "35A7C9FB", "1B088705", "A1AEFBDB", "E28C4D3B", "C05A25AD" },
            Legs = { "27B700C2", "4BA188D", "AAD70276", "EDE17D5F", "F4F5A364" },
            HeadTexture = { "mp_head_fr1_sc04_c0_000_ab" },
        }
    }
}

Config.texture_types = {
    Male = {
        albedo = joaat("head_fr1_sc08_soft_c0_001_ab"),
        normal = joaat("mp_head_mr1_000_nm"),
        material = 0x50A4BBA9,
        color_type = 1,
        texture_opacity = 1.0,
        unk_arg = 0,
    },
    Female = {
        albedo = joaat("mp_head_fr1_sc08_c0_000_ab"),
        normal = joaat("head_fr1_mp_002_nm"),
        material = 0x7FC5B1E1,
        color_type = 1,
        texture_opacity = 1.0,
        unk_arg = 0,
    }
}

-- you can choose the color you want people to use by removing it from each category for example grime you dont want people to use pink
Config.color_palettes = {
    eyebrows = {
        0x3F6E70FF, -- black
        0x0105607B, -- grey
        0x17CBCC83, -- red
        0x29F81B2A, --green
        0x3385C5DB, --pink
        0x37CD36D4, --dark red
        0x4101ED87, -- brown medium
        0x63838A81, -- red medium
        0x6765BC15, -- black medium
        0x8BA18876, -- grey light
        0x9AC34F34, -- blonde
        0x9E4803A0, -- purple dark
        0xA4CFABD0, --pink light
        0xAA65D8A3, -- blue dark
        0xB562025C, --pink dark
        0xB9E7F722, -- violet light
        0xBBF43EF8, -- light brown
        0xD1476963, -- violet
        0xD799E1C2, -- red pinkish
        0xDC6BC93B, -- grey dark
        0xDFB1F64C, -- brown
        0xF509C745, -- redish
        0xF93DB0C8, -- redish
        0xFB71527B, -- gray dark
        0xA4041CEF, --orange

    },
    grime = {
        0x3F6E70FF, -- black
        0x4101ED87, -- brown medium
        0xBBF43EF8, -- light brown
        0xDFB1F64C, -- brown

    },
    beardstabble = {
        0x3F6E70FF,
        0x0105607B,
        0x17CBCC83,
        0x29F81B2A,
        0x3385C5DB,
        0x37CD36D4,
        0x4101ED87,
        0x63838A81,
        0x6765BC15,
        0x8BA18876,
        0x9AC34F34,
        0x9E4803A0,
        0xA4CFABD0,
        0xAA65D8A3,
        0xB562025C,
        0xB9E7F722,
        0xBBF43EF8,
        0xD1476963,
        0xD799E1C2,
        0xDC6BC93B,
        0xDFB1F64C,
        0xF509C745,
        0xF93DB0C8,
        0xFB71527B,
        0xA4041CEF,
    },
    hair = {
        0x3F6E70FF,
        0x0105607B,
        0x17CBCC83,
        0x29F81B2A,
        0x3385C5DB,
        0x37CD36D4,
        0x4101ED87,
        0x63838A81,
        0x6765BC15,
        0x8BA18876,
        0x9AC34F34,
        0x9E4803A0,
        0xA4CFABD0,
        0xAA65D8A3,
        0xB562025C,
        0xB9E7F722,
        0xBBF43EF8,
        0xD1476963,
        0xD799E1C2,
        0xDC6BC93B,
        0xDFB1F64C,
        0xF509C745,
        0xF93DB0C8,
        0xFB71527B,
        0xA4041CEF,
    },
    scars = {
        0x3F6E70FF,
        0x0105607B,
        0x17CBCC83,
        0x29F81B2A,
        0x3385C5DB,
        0x37CD36D4,
        0x4101ED87,
        0x63838A81,
        0x6765BC15,
        0x8BA18876,
        0x9AC34F34,
        0x9E4803A0,
        0xA4CFABD0,
        0xAA65D8A3,
        0xB562025C,
        0xB9E7F722,
        0xBBF43EF8,
        0xD1476963,
        0xD799E1C2,
        0xDC6BC93B,
        0xDFB1F64C,
        0xF509C745,
        0xF93DB0C8,
        0xFB71527B,
        0xA4041CEF,
    },
    shadows = {
        0x3F6E70FF,
        0x0105607B,
        0x17CBCC83,
        0x29F81B2A,
        0x3385C5DB,
        0x37CD36D4,
        0x4101ED87,
        0x63838A81,
        0x6765BC15,
        0x8BA18876,
        0x9AC34F34,
        0x9E4803A0,
        0xA4CFABD0,
        0xAA65D8A3,
        0xB562025C,
        0xB9E7F722,
        0xBBF43EF8,
        0xD1476963,
        0xD799E1C2,
        0xDC6BC93B,
        0xDFB1F64C,
        0xF509C745,
        0xF93DB0C8,
        0xFB71527B,
        0xA4041CEF,
    },
    lipsticks = {
        0x3F6E70FF,
        0x0105607B,
        0x17CBCC83,
        0x29F81B2A,
        0x3385C5DB,
        0x37CD36D4,
        0x4101ED87,
        0x63838A81,
        0x6765BC15,
        0x8BA18876,
        0x9AC34F34,
        0x9E4803A0,
        0xA4CFABD0,
        0xAA65D8A3,
        0xB562025C,
        0xB9E7F722,
        0xBBF43EF8,
        0xD1476963,
        0xD799E1C2,
        0xDC6BC93B,
        0xDFB1F64C,
        0xF509C745,
        0xF93DB0C8,
        0xFB71527B,
        0xA4041CEF,
    },
    eyeliners = {
        0x3F6E70FF,
        0x0105607B,
        0x17CBCC83,
        0x29F81B2A,
        0x3385C5DB,
        0x37CD36D4,
        0x4101ED87,
        0x63838A81,
        0x6765BC15,
        0x8BA18876,
        0x9AC34F34,
        0x9E4803A0,
        0xA4CFABD0,
        0xAA65D8A3,
        0xB562025C,
        0xB9E7F722,
        0xBBF43EF8,
        0xD1476963,
        0xD799E1C2,
        0xDC6BC93B,
        0xDFB1F64C,
        0xF509C745,
        0xF93DB0C8,
        0xFB71527B,
        0xA4041CEF,
    },
    blush = {
        0x3F6E70FF,
        0x0105607B,
        0x17CBCC83,
        0x29F81B2A,
        0x3385C5DB,
        0x37CD36D4,
        0x4101ED87,
        0x63838A81,
        0x6765BC15,
        0x8BA18876,
        0x9AC34F34,
        0x9E4803A0,
        0xA4CFABD0,
        0xAA65D8A3,
        0xB562025C,
        0xB9E7F722,
        0xBBF43EF8,
        0xD1476963,
        0xD799E1C2,
        0xDC6BC93B,
        0xDFB1F64C,
        0xF509C745,
        0xF93DB0C8,
        0xFB71527B,
        0xA4041CEF,
    },
    foundation = {
        0x3F6E70FF,
        0x0105607B,
        0x17CBCC83,
        0x29F81B2A,
        0x3385C5DB,
        0x37CD36D4,
        0x4101ED87,
        0x63838A81,
        0x6765BC15,
        0x8BA18876,
        0x9AC34F34,
        0x9E4803A0,
        0xA4CFABD0,
        0xAA65D8A3,
        0xB562025C,
        0xB9E7F722,
        0xBBF43EF8,
        0xD1476963,
        0xD799E1C2,
        0xDC6BC93B,
        0xDFB1F64C,
        0xF509C745,
        0xF93DB0C8,
        0xFB71527B,
        0xA4041CEF,
    },
    paintedmasks = {
        0x3F6E70FF,
        0x0105607B,
        0x17CBCC83,
        0x29F81B2A,
        0x3385C5DB,
        0x37CD36D4,
        0x4101ED87,
        0x63838A81,
        0x6765BC15,
        0x8BA18876,
        0x9AC34F34,
        0x9E4803A0,
        0xA4CFABD0,
        0xAA65D8A3,
        0xB562025C,
        0xB9E7F722,
        0xBBF43EF8,
        0xD1476963,
        0xD799E1C2,
        0xDC6BC93B,
        0xDFB1F64C,
        0xF509C745,
        0xF93DB0C8,
        0xFB71527B,
        0xA4041CEF,
    }
}

Config.overlay_all_layers = {
    {
        name = "eyebrows", -- dont change
        visibility = 0,
        tx_id = 1,
        tx_normal = 0,
        tx_material = 0,
        tx_color_type = 0,
        tx_opacity = 1.0,
        tx_unk = 0,
        palette = 0,
        palette_color_primary = 0,
        palette_color_secondary = 0,
        palette_color_tertiary = 0,
        var = 0,
        opacity = 0.0,
    },
    {
        name = "scars",
        visibility = 0,
        tx_id = 1,
        tx_normal = 0,
        tx_material = 0,
        tx_color_type = 0,
        tx_opacity = 1.0,
        tx_unk = 0,
        palette = 0,
        palette_color_primary = 0,
        palette_color_secondary = 0,
        palette_color_tertiary = 0,
        var = 0,
        opacity = 1.0,
    },
    {
        name = "eyeliners",
        visibility = 0,
        tx_id = 1,
        tx_normal = 0,
        tx_material = 0,
        tx_color_type = 0,
        tx_opacity = 1.0,
        tx_unk = 0,
        palette = 0,
        palette_color_primary = 0,
        palette_color_secondary = 0,
        palette_color_tertiary = 0,
        var = 0,
        opacity = 1.0,
    },
    {
        name = "lipsticks",
        visibility = 0,
        tx_id = 1,
        tx_normal = 0,
        tx_material = 0,
        tx_color_type = 0,
        tx_opacity = 1.0,
        tx_unk = 0,
        palette = 0,
        palette_color_primary = 0,
        palette_color_secondary = 0,
        palette_color_tertiary = 0,
        var = 0,
        opacity = 1.0,
    },
    {
        name = "acne",
        visibility = 0,
        tx_id = 1,
        tx_normal = 0,
        tx_material = 0,
        tx_color_type = 0,
        tx_opacity = 1.0,
        tx_unk = 0,
        palette = 0,
        palette_color_primary = 0,
        palette_color_secondary = 0,
        palette_color_tertiary = 0,
        var = 0,
        opacity = 1.0,
    },
    {
        name = "shadows",
        visibility = 0,
        tx_id = 1,
        tx_normal = 0,
        tx_material = 0,
        tx_color_type = 0,
        tx_opacity = 1.0,
        tx_unk = 0,
        palette = 0,
        palette_color_primary = 0,
        palette_color_secondary = 0,
        palette_color_tertiary = 0,
        var = 0,
        opacity = 1.0,
    },
    {
        name = "beardstabble",
        visibility = 0,
        tx_id = 1,
        tx_normal = 0,
        tx_material = 0,
        tx_color_type = 0,
        tx_opacity = 1.0,
        tx_unk = 0,
        palette = 0,
        palette_color_primary = 0,
        palette_color_secondary = 0,
        palette_color_tertiary = 0,
        var = 0,
        opacity = 1.0,
    },
    {
        name = "hair",
        visibility = 0,
        tx_id = 1,
        tx_normal = 0,
        tx_material = 0,
        tx_color_type = 0,
        tx_opacity = 1.0,
        tx_unk = 0,
        palette = 0,
        palette_color_primary = 0,
        palette_color_secondary = 0,
        palette_color_tertiary = 0,
        var = 0,
        opacity = 1.0,
    },
    {
        name = "paintedmasks",
        visibility = 0,
        tx_id = 1,
        tx_normal = 0,
        tx_material = 0,
        tx_color_type = 0,
        tx_opacity = 1.0,
        tx_unk = 0,
        palette = 0,
        palette_color_primary = 0,
        palette_color_secondary = 0,
        palette_color_tertiary = 0,
        var = 0,
        opacity = 1.0,
    },
    {
        name = "ageing",
        visibility = 0,
        tx_id = 1,
        tx_normal = 0,
        tx_material = 0,
        tx_color_type = 0,
        tx_opacity = 1.0,
        tx_unk = 0,
        palette = 0,
        palette_color_primary = 0,
        palette_color_secondary = 0,
        palette_color_tertiary = 0,
        var = 0,
        opacity = 0.0,
    },
    {
        name = "blush",
        visibility = 0,
        tx_id = 1,
        tx_normal = 0,
        tx_material = 0,
        tx_color_type = 0,
        tx_opacity = 1.0,
        tx_unk = 0,
        palette = 0,
        palette_color_primary = 0,
        palette_color_secondary = 0,
        palette_color_tertiary = 0,
        var = 0,
        opacity = 1.0,
    },
    {
        name = "complex",
        visibility = 0,
        tx_id = 1,
        tx_normal = 0,
        tx_material = 0,
        tx_color_type = 0,
        tx_opacity = 1.0,
        tx_unk = 0,
        palette = 0,
        palette_color_primary = 0,
        palette_color_secondary = 0,
        palette_color_tertiary = 0,
        var = 0,
        opacity = 1.0,
    },
    {
        name = "disc",
        visibility = 0,
        tx_id = 1,
        tx_normal = 0,
        tx_material = 0,
        tx_color_type = 0,
        tx_opacity = 1.0,
        tx_unk = 0,
        palette = 0,
        palette_color_primary = 0,
        palette_color_secondary = 0,
        palette_color_tertiary = 0,
        var = 0,
        opacity = 1.0,
    },
    {
        name = "foundation",
        visibility = 0,
        tx_id = 1,
        tx_normal = 0,
        tx_material = 0,
        tx_color_type = 0,
        tx_opacity = 1.0,
        tx_unk = 0,
        palette = 0,
        palette_color_primary = 0,
        palette_color_secondary = 0,
        palette_color_tertiary = 0,
        var = 0,
        opacity = 1.0,
    },
    {
        name = "freckles",
        visibility = 0,
        tx_id = 1,
        tx_normal = 0,
        tx_material = 0,
        tx_color_type = 0,
        tx_opacity = 1.0,
        tx_unk = 0,
        palette = 0,
        palette_color_primary = 0,
        palette_color_secondary = 0,
        palette_color_tertiary = 0,
        var = 0,
        opacity = 1.0,
    },
    {
        name = "grime",
        visibility = 0,
        tx_id = 1,
        tx_normal = 0,
        tx_material = 0,
        tx_color_type = 0,
        tx_opacity = 1.0,
        tx_unk = 0,
        palette = 0,
        palette_color_primary = 0,
        palette_color_secondary = 0,
        palette_color_tertiary = 0,
        var = 0,
        opacity = 1.0,
    },
    {
        name = "hair",
        visibility = 0,
        tx_id = 1,
        tx_normal = 0,
        tx_material = 0,
        tx_color_type = 0,
        tx_opacity = 1.0,
        tx_unk = 0,
        palette = 0,
        palette_color_primary = 0,
        palette_color_secondary = 0,
        palette_color_tertiary = 0,
        var = 0,
        opacity = 1.0,
    },
    {
        name = "moles",
        visibility = 0,
        tx_id = 1,
        tx_normal = 0,
        tx_material = 0,
        tx_color_type = 0,
        tx_opacity = 1.0,
        tx_unk = 0,
        palette = 0,
        palette_color_primary = 0,
        palette_color_secondary = 0,
        palette_color_tertiary = 0,
        var = 0,
        opacity = 1.0,
    },
    {
        name = "spots",
        visibility = 0,
        tx_id = 1,
        tx_normal = 0,
        tx_material = 0,
        tx_color_type = 0,
        tx_opacity = 1.0,
        tx_unk = 0,
        palette = 0,
        palette_color_primary = 0,
        palette_color_secondary = 0,
        palette_color_tertiary = 0,
        var = 0,
        opacity = 1.0,
    },
}

Config.overlays_info = {
    eyebrows     = {
        { id = 0x07844317, albedo = 0xF81B2E66, normal = 0x7BC4288B, ma = 0x202674A1, },
        { id = 0x0A83CA6E, albedo = 0x8FA4286B, normal = 0xBD811948, ma = 0xB82C8FBB, },
        { id = 0x139A5CA3, albedo = 0x487ABE5A, normal = 0x22A9DDF9, ma = 0x78AA9401, },
        { id = 0x1832E474, albedo = 0x96FBB931, normal = 0x32FA2683, ma = 0xA1775B18, },
        { id = 0x216EF84C, albedo = 0x269CD8F8, normal = 0x2F54C727, ma = 0xCCBD1939, },
        { id = 0x2594304D, albedo = 0xA5A23CD1, normal = 0x8611B42C, ma = 0x0238302B, },
        { id = 0x33C39BC5, albedo = 0xF928E29B, normal = 0x46C268BD, ma = 0x4B92F13E, },
        { id = 0x443E3CBA, albedo = 0x6C83B571, normal = 0x2B191070, ma = 0xD551E623, },
        { id = 0x4F5052DE, albedo = 0x827EEF46, normal = 0x70E8C702, ma = 0xD97518F9, },
        { id = 0x5C049D35, albedo = 0x41E90506, normal = 0x7E47D163, ma = 0x54100288, },
        { id = 0x77A1546E, albedo = 0x43C4AE44, normal = 0x290FC7F7, ma = 0xD8FC26A9, },
        { id = 0x8A4B79C2, albedo = 0xAE6ED4E6, normal = 0x89B29E5A, ma = 0xFA0476E4, },
        { id = 0x9728137B, albedo = 0x23E65D35, normal = 0xEE39073F, ma = 0x218DD4C8, },
        { id = 0xA6DE8325, albedo = 0x7A93F649, normal = 0x22B33B65, ma = 0xEE6CCF11, },
        { id = 0xA8CCB6C4, albedo = 0x29AD8BF9, normal = 0x34ABB09D, ma = 0xCF206860, },
        { id = 0xB3F74D19, albedo = 0x3E2F71B1, normal = 0xD4809D11, ma = 0x9ABFA640, },
        { id = 0xBD38AFD9, albedo = 0x058A698E, normal = 0x9A732F86, ma = 0x2EF1D769, },
        { id = 0xCD0A4F7C, albedo = 0xED46998E, normal = 0xB5B73A38, ma = 0x15C5FB78, },
        { id = 0xD0EC86FF, albedo = 0x81B462A2, normal = 0x894F8744, ma = 0x51551810, },
        { id = 0xEB088A20, albedo = 0x0C6CDBDC, normal = 0x91A2496E, ma = 0xE639F138, },
        { id = 0xF0CA96FC, albedo = 0xAC3BCA3F, normal = 0x667FEFF8, ma = 0xDD8E5EFF, },
        { id = 0xF3351BD9, albedo = 0xC3286EA4, normal = 0x8BB9158A, ma = 0xFBBAE4D8, },
        { id = 0xF9052779, albedo = 0x8AEADE78, normal = 0x21BB2D97, ma = 0x75A0B928, },
        { id = 0xFE183197, albedo = 0x92B508CD, normal = 0x6AA92A3E, ma = 0xB4A436DB, },
    },
    scars        = {
        { id = 0xC8E45B5B, albedo = 0x6245579F, normal = 0xD53A336F, },
        { id = 0x90D86B44, albedo = 0xA1538E6F, normal = 0xDFCB1159, },
        { id = 0x23190FC3, albedo = 0x39683ECE, normal = 0x249C1A0A, },
        { id = 0x7574B47D, albedo = 0x3AB2A0BB, normal = 0x7A70886A, },
        { id = 0x7FE8C965, albedo = 0xB81C8D16, normal = 0x7210971B, },
        { id = 0x083059FE, albedo = 0xC332710C, normal = 0x860EE45E, },
        { id = 0x19E9FD71, albedo = 0x40895310, normal = 0xB753C5C7, },
        { id = 0x4CAF62FB, albedo = 0xD80F2F64, normal = 0x00BBF225, },
        { id = 0xDE650668, albedo = 0x85F6BF71, normal = 0x3DD0B0AE, },
        { id = 0xC648562B, albedo = 0x6397E4D9, normal = 0x2B59CDA1, },
        { id = 0x484BAEF8, albedo = 0xBF2946DE, normal = 0xD3F2F2F6, },
        { id = 0x190F5080, albedo = 0xCBBDB741, normal = 0x9518FA34, },
        { id = 0x2B5DF51D, albedo = 0x0E05C415, normal = 0x8B8C57AC, },
        { id = 0xE490E784, albedo = 0x50853115, normal = 0xDA7F2A1E, },
        { id = 0x0ED23C06, albedo = 0xAEA45D76, normal = 0x364DAAA6, },
        { id = 0x5712CCB6, albedo = 0x9318AF61, normal = 0x98104C8C, },
    },
    eyeliners    = {
        { id = 0x29A2E58F, albedo = 0xA952BF75, ma = 0xDD55AF2A, },
    },
    lipsticks    = {
        { id = 0x887E11E0, albedo = 0x96A5E4FB, normal = 0x1C77591C, ma = 0x4255A5F4, },
    },
    acne         = {
        { id = 0x96DD8F42, albedo = 0x1BA4244B, normal = 0xBA46CE92, },
    },
    shadows      = {
        { id = 0x47BD7289, albedo = 0x5C5C98FC, ma = 0xE20345CC, },
    },
    beardstabble = {
        { id = 0x375D4807, albedo = 0xB5827817, normal = 0x5041B648, ma = 0x83F42340, },
    },
    paintedmasks = {
        { id = 0x5995AA6F, albedo = 0x99BCB03F, },
    },
    ageing       = {
        { id = 0x96DD8F42, albedo = 0x1BA4244B, normal = 0xBA46CE92, },
        { id = 0x6D9DC405, albedo = 0xAFE82F0C, normal = 0x5CF8808E, },
        { id = 0x2761B792, albedo = 0x4105C6B3, normal = 0x8607CC56, },
        { id = 0x19009AD0, albedo = 0xEBC18618, normal = 0x9087AF96, },
        { id = 0xC29F6E07, albedo = 0xF9887FA7, normal = 0x1331C3C9, },
        { id = 0xA45F3187, albedo = 0x1C30961A, normal = 0x3CA2F3AE, },
        { id = 0x5E21250C, albedo = 0x01E35044, normal = 0x5A965FF0, },
        { id = 0x4FFE08C6, albedo = 0xA65757F2, normal = 0xC46CC005, },
        { id = 0x2DAD4485, albedo = 0x358DEFDA, normal = 0x55D317B4, },
        { id = 0x3F70680B, albedo = 0x7073A58F, normal = 0x33E73C5F, },
        { id = 0xD3310F8E, albedo = 0xD9E8A605, normal = 0x22297EA5, },
        { id = 0xF27A4C84, albedo = 0xE0F0971B, normal = 0x9F0E6718, },
        { id = 0x0044E819, albedo = 0xFD844ADF, normal = 0x315A6D56, },
        { id = 0xA648348D, albedo = 0xC329F765, normal = 0xE8CD7F20, },
        { id = 0x94F991F0, albedo = 0x8586D19B, normal = 0xCA334396, },
        { id = 0xCAACFD56, albedo = 0xD2D0BF4F, normal = 0xE0203BDA, },
        { id = 0xB9675ACB, albedo = 0x2387AF71, normal = 0x90A80AE1, },
        { id = 0x3C2CE03C, albedo = 0xC6DCBCCA, normal = 0x609B7EBD, },
        { id = 0xF2D64D90, albedo = 0xC6DCBCCA, normal = 0x609B7EBD, },
        { id = 0xE389AEF7, albedo = 0xDF591FF2, normal = 0x11D92A14, },
        { id = 0x89317A44, albedo = 0xB4640D19, normal = 0x2F56FDA5, },
        { id = 0x64B3347C, albedo = 0xFF2E8F96, normal = 0x45EE7B10, },
        { id = 0x9FFDAB10, albedo = 0x8F2950D9, normal = 0x85BDD7E8, },
        { id = 0x91D40EBD, albedo = 0x5DCD1D4E, normal = 0xA1B5F71F, },
        { id = 0x6B94C23F, albedo = 0xF17FE41C, normal = 0x0C480977, },
    },
    blush        = {
        { id = 0x6DB440FA, albedo = 0x43B1AACA, },
        { id = 0x47617455, albedo = 0x9CAD2EF0, },
        { id = 0x114D082D, albedo = 0xA52E3B98, },
        { id = 0xEC6F3E72, albedo = 0xB5CED4CB, },
    },
    complex      = {
        { id = 0xF679EDE7, albedo = 0xFAAE9FF0, },
        { id = 0x3FFB80ED, albedo = 0x1FDFD4A1, },
        { id = 0x31C0E478, albedo = 0xC72D0698, },
        { id = 0x2457C9A6, albedo = 0x98F1C76F, },
        { id = 0x16262D43, albedo = 0xE0D03293, },
        { id = 0x88F312DB, albedo = 0x2ECCC670, },
        { id = 0x785C71AE, albedo = 0xAE1C329F, },
        { id = 0x6D7D5BF0, albedo = 0x23201E55, },
        { id = 0x5F2FBF55, albedo = 0x94503F97, },
        { id = 0xBF38FF6A, albedo = 0x5F62F986, },
        { id = 0xF5656C26, albedo = 0x83417009, },
        { id = 0x03A408A3, albedo = 0x1BCC4185, },
        { id = 0x293453C3, albedo = 0x6C556574, },
        { id = 0x43150800, albedo = 0x1E486F85, },
    },
    disc         = {
        { id = 0xD44A5ABA, albedo = 0x2D3AEB2F, },
        { id = 0xE2CF77C4, albedo = 0xB8945AC0, },
        { id = 0xCF57D0E9, albedo = 0xB15E4E47, },
        { id = 0xE0A8738A, albedo = 0x25A711DD, },
        { id = 0xABD109DC, albedo = 0xCEBED6D9, },
        { id = 0xB91C2472, albedo = 0xFDD6C9AB, },
        { id = 0x894844B7, albedo = 0x7E89B165, },
        { id = 0x96FAE01C, albedo = 0x458799CD, },
        { id = 0x86D3BFCE, albedo = 0x8F2F2826, },
        { id = 0x5488DB39, albedo = 0xB49A0275, },
        { id = 0x7DA5A5AE, albedo = 0x8200F51D, },
        { id = 0xE73778DC, albedo = 0x8D35AC90, },
        { id = 0xD83EDADF, albedo = 0x96B619CD, },
        { id = 0xE380F163, albedo = 0xAB7309F7, },
        { id = 0xB4611324, albedo = 0x26FEBDD4, },
        { id = 0xC6ABB7B9, albedo = 0xC162C835, },
    },
    foundation   = {
        { id = 0xEF5AB280, albedo = 0xD9264247, ma = 0x1535C7C9, },
    },
    freckles     = {
        { id = 0x1B794C51, albedo = 0x59B8159A, },
        { id = 0x29BFE8DE, albedo = 0x03FCF67B, },
        { id = 0x0EF6B34C, albedo = 0x21E2FD82, },
        { id = 0x64925E7E, albedo = 0x3FD45844, },
        { id = 0xF5F280FC, albedo = 0xE372E00E, },
        { id = 0x33B0FC78, albedo = 0x288810E0, },
        { id = 0x25675FE5, albedo = 0xEB8C0B1D, },
        { id = 0xD10F3736, albedo = 0x3885AC2A, },
        { id = 0x5126B75F, albedo = 0xB061C984, },
        { id = 0x6B8EEC2F, albedo = 0xE1D1113E, },
        { id = 0x0A9A26F7, albedo = 0xA1EC1AEA, },
        { id = 0xFDE40D8B, albedo = 0x6DBC9203, },
        { id = 0x7E338E44, albedo = 0x097D1D0A, },
        { id = 0x70F273C2, albedo = 0x81A25BCE, },
        { id = 0x61C7D56D, albedo = 0x197A1335, },
    },
    grime        = {
        { id = 0xA2F30923, albedo = 0x16CDD724, normal = 0x136165B3, ma = 0xF3DFA7AC, },
        { id = 0xD5B1EEA0, albedo = 0x0E599D69, normal = 0x5C67FB68, ma = 0x40FEC59E, },
        { id = 0x7EC740CC, albedo = 0x0FAE8DC6, normal = 0x9E7A4B63, ma = 0xB48BF65A, },
        { id = 0xB08F245B, albedo = 0x98358521, normal = 0x1FAA4A84, ma = 0x81428E8F, },
        { id = 0x1A5E77F8, albedo = 0x8D3D2563, normal = 0x1FAA4A84, ma = 0x81428E8F, },
        { id = 0xE81B9373, albedo = 0xAE43378D, normal = 0x0CBEEF9B, ma = 0x92097B22, },
        { id = 0x3CFA3D2F, albedo = 0x7499570E, normal = 0xA27FF667, ma = 0x24B49749, },
        { id = 0x0B865A48, albedo = 0xB80F6B12, normal = 0x377319E3, ma = 0x3CDC25A9, },
        { id = 0x506DE416, albedo = 0x537BA522, normal = 0x006AF092, ma = 0x5CCEA9F8, },
        { id = 0x1F250185, albedo = 0x51BE975D, normal = 0x3F718027, ma = 0x5527ACCF, },
        { id = 0xE71930B0, albedo = 0x595D09A3, normal = 0xF4E08D43, ma = 0x60B91CE7, },
        { id = 0xDE571F2C, albedo = 0xE7FAFDFA, normal = 0xE6A18BBF, ma = 0xCB315A57, },
        { id = 0x0CA6FBCB, albedo = 0x0E27372E, normal = 0xD4894921, ma = 0xBF339D56, },
        { id = 0x21F62669, albedo = 0x693623F0, normal = 0xDB95176C, ma = 0xEA27B375, },
        { id = 0xFB09D881, albedo = 0xC4A40DA0, normal = 0xADD1DC3D, ma = 0xFD797A87, },
        { id = 0x11530513, albedo = 0x67C6D30F, normal = 0x26AA38C3, ma = 0x89C2FFE3, },
    },
    hair         = {
        { id = 0x39051515, albedo = 0x60A4A360, normal = 0x8D65EFF2, ma = 0x62759D82, },
        { id = 0x5E71DFEE, albedo = 0x71147B90, ma = 0xD8EB57BC, },
        { id = 0xDD735DEF, albedo = 0x493214E4, ma = 0x6613D121, },
        { id = 0x69622EAD, albedo = 0xA6E819C4, ma = 0xE581D851, },
    },
    moles        = {
        { id = 0x821FD077, albedo = 0xDFDA0798, normal = 0xE4E90C92, },
        { id = 0xCD38E6A8, albedo = 0xE9CF623E, normal = 0x43FAEA4B, },
        { id = 0x9F9D8B72, albedo = 0x27450B2F, normal = 0x0808DBFB, },
        { id = 0xE7179A39, albedo = 0x38638E0B, normal = 0x99346057, },
        { id = 0xBB094249, albedo = 0x763F8624, normal = 0x6975D6F9, },
        { id = 0x03AC5362, albedo = 0xEF158115, normal = 0xBA297751, },
        { id = 0x154FF6A9, albedo = 0xEE28E6F7, normal = 0xB7548307, },
        { id = 0x1E23084F, albedo = 0x566ACE2F, normal = 0x361237C6, },
        { id = 0x31DBAFC0, albedo = 0x0AB0CC2B, normal = 0xDBF55701, },
        { id = 0x3AC5C194, albedo = 0xC940CC25, normal = 0x41CB48FC, },
        { id = 0x4500D516, albedo = 0x3A1EEDB1, normal = 0x17BC19B0, },
        { id = 0x3695B840, albedo = 0x1D30222E, normal = 0xDA5FDF7E, },
        { id = 0x286C1BED, albedo = 0x4F0B4FA8, normal = 0x40333534, },
        { id = 0x934BF1AF, albedo = 0x4540A8D7, normal = 0x933ACF76, },
        { id = 0x84F55502, albedo = 0x47BE6D32, normal = 0xDCF7108E, },
        { id = 0xBD9A464B, albedo = 0x9DABB1B9, normal = 0x4A3B1739, },
    },
    spots        = {
        { id = 0x5BBFF5F7, albedo = 0x24968425, normal = 0xA5D532AD, },
        { id = 0x65EC0A4F, albedo = 0x326A7845, normal = 0xC09B2354, },
        { id = 0x3F143CA0, albedo = 0x91D7E39E, normal = 0xD607DF75, },
        { id = 0x49675146, albedo = 0x2E6C3769, normal = 0xE6A21CD5, },
        { id = 0x07504D2D, albedo = 0x39F16CE6, normal = 0x5CB32D5C, },
        { id = 0xF161214F, albedo = 0x47C60FBA, normal = 0x19424C77, },
        { id = 0xE43286F2, albedo = 0xA7E86379, normal = 0x7C07E0B0, },
        { id = 0xDDDC7A46, albedo = 0x26D3DA64, normal = 0x5A69A9BB, },
        { id = 0xD086DF9B, albedo = 0x7D6FF58C, normal = 0x5A0D99C8, },
        { id = 0xBA51B331, albedo = 0xCB23CA55, normal = 0xA7720C6A, },
        { id = 0xE4CF097B, albedo = 0x51D0FBDA, normal = 0xB01F5202, },
        { id = 0xF70CADF6, albedo = 0xD0858DFC, normal = 0x7E067837, },
        { id = 0xC07F40DC, albedo = 0x3BAF1008, normal = 0x75030E1B, },
        { id = 0xD3B1E741, albedo = 0x97091388, normal = 0xA191AA56, },
        { id = 0xB494A903, albedo = 0x18025AE1, normal = 0x86F51AD1, },
        { id = 0xC6EE4DB6, albedo = 0xC9F3EBA4, normal = 0xE819AD33, },
    },
}

Config.EyeImgColor = {
    "Brown 1",
    "Brown 2",
    "Blue 1",
    "Blue 2",
    "Blue 3",
    "Blue 4",
    "Blue 5",
    "Green 1",
    "Green 2",
    "Green 3",
    "Green 4",
    "Green 5",
    "Green 6",
    "Green 7",
}

---------------------------* EYES *--------------------------
Config.Eyes = {
    Male = {
        612262189,
        3065185688,
        1864171073,
        1552505114,
        46507404,
        4030267507,
        642477207,
        329402181,
        2501331517,
        2195072443,
        3096645940,
        3983864603,
        2739887825,
        2432743988,
    },
    Female = {
        928002221,
        3117725108,
        2273169671,
        2489772761,
        1647937151,
        3773694950,
        3450854762,
        3703470983,
        2836599857,
        625380794,
        869083847,
        3045109292,
        2210319017,
        2451302243,
    }
}

-------------------------- * BODY TYPE * --------------------------------------
Config.BodyType = {
    Body = {
        61606861,
        -1241887289,
        -369348190,
        32611963,
        -20262001,
        -369348190
    },
    Waist = {
        -2045421226,
        -1745814259,
        -325933489,
        -1065791927,
        -844699484,
        -1273449080,
        927185840,
        149872391,
        399015098,
        -644349862,
        1745919061,
        1004225511,
        1278600348,
        502499352,
        -2093198664,
        -1837436619,
        1736416063,
        2040610690,
        -1173634986,
        -867801909,
        1960266524,
    }
}

Config.Teeth = {
    Female = {
        {
            hash = 0x39340BFF,
            hash_dec_signed = 959712255,
        },
        {
            hash = 0x4AD5AF42,
            hash_dec_signed = 1255518018,
        },
        {
            hash = 0x54A6C2E4,
            hash_dec_signed = 1420215012,
        },
        {
            hash = 0x66716679,
            hash_dec_signed = 1718707833,
        },
        {
            hash = 0xF57D0492,
            hash_dec_signed = -176356206,
        },
        {
            hash = 0x20CC5B30,
            hash_dec_signed = 550263600,
        },
        {
            hash = 0x322BFDEF,
            hash_dec_signed = 841743855,
        },
    },
    Male = {
        {
            hash = 0x2A7712A2,
            hash_dec_signed = 712446626,
        },
        {
            hash = 0x61227FF8,
            hash_dec_signed = 1629650936,
        },
        {
            hash = 0x060949C7,
            hash_dec_signed = 101272007,
        },
        {
            hash = 0x3C87B6C3,
            hash_dec_signed = 1015527107,
        },
        {
            hash = 0xE1A380FC,
            hash_dec_signed = -509378308,
        },
        {
            hash = 0x17FCEDAE,
            hash_dec_signed = 402451886,
        },
        {
            hash = 0xE11FFFF5,
            hash_dec_signed = -517996555,
        },
    }
}

-- *TRANSLATE ["inside here"] below to your language*
Config.FaceFeatures = {
    head = {
        ["Head Width"] = { hash = 0x84D6, comp = "HeadSize" },
        ["Face Width"] = { hash = 41396, comp = "FaceW" },
        ["Face Depth"] = { hash = 12281, comp = "FaceD" },
        ["Forehead Size"] = { hash = 13059, comp = "FaceS" },
        ["Neck Width"] = { hash = 36277, comp = "NeckW" },
        ["Neck Depth"] = { hash = 60890, comp = "NeckD" },
    },

    eyesandbrows = {
        ["Brows Height"] = { hash = 0x3303, comp = "EyeBrowH" },
        ["Brows Width"] = { hash = 0x2FF9, comp = "EyeBrowW" },
        ["Brows Depth"] = { hash = 0x4AD1, comp = "EyeBrowD" },
        ["Eyes Depth"] = { hash = 0xEE44, comp = "EyeD" },
        ["Eyes Angle"] = { hash = 0xD266, comp = "EyeAng" },
        ["Eyes Distance"] = { hash = 0xA54E, comp = "EyeDis" },
        ["Eyes Height"] = { hash = 0xDDFB, comp = "EyeH" },
        ["Eyelid Height"] = { hash = 0x8B2B, comp = "EyeLidH" },
        ["Eyelid Width"] = { hash = 0x1B6B, comp = "EyeLidW" },
        ["Eyelid Left O/Close"] = { hash = 52902, comp = "EyeLidL" },
        ["Eyelid Right O/Close"] = { hash = 22421, comp = "EyeLidR" },
    },
    ears = {
        ["Ears Width"] = { hash = 0xC04F, comp = "EarsW" },
        ["Ears Angle"] = { hash = 0xB6CE, comp = "EarsA" },
        ["Ears Height"] = { hash = 0x2844, comp = "EarsH" },
        ["Ears Depth"] = { hash = 0xED30, comp = "EarsD" },
    },
    cheek = {
        ["CheekBone Height"] = { hash = 0x6A0B, comp = "CheekBonesH" },
        ["CheekBone Width"] = { hash = 0xABCF, comp = "CheekBonesW" },
        ["CheekBone Depth"] = { hash = 0x358D, comp = "CheekBonesD" },
    },
    jaw = {
        ["Jaw Height"] = { hash = 0x8D0A, comp = "JawH" },
        ["Jaw Width"] = { hash = 0xEBAE, comp = "JawW" },
        ["Jaw Depth"] = { hash = 0x1DF6, comp = "JawD" },
    },
    chin = {
        ["Chin Height"] = { hash = 0x3C0F, comp = "ChinH" },
        ["Chin Width"] = { hash = 0xC3B2, comp = "ChinW" },
        ["Chin Depth"] = { hash = 0xE323, comp = "ChinD" },
    },
    nose = {
        ["Nose Width"] = { hash = 0x6E7F, comp = "NoseW" },
        ["Nose Size"] = { hash = 0x3471, comp = "NoseS" },
        ["Nose Height"] = { hash = 0x03F5, comp = "NoseH" },
        ["Nose Angle"] = { hash = 0x34B1, comp = "NoseAng" },
        ["Nose Curvature"] = { hash = 0xF156, comp = "NoseC" },
        ["Nose Distance"] = { hash = 0x561E, comp = "NoseDis" },
    },
    mouthandlips = {
        ["Mouth Width"] = { hash = 0xF065, comp = "MouthW" },
        ["Mouth Depth"] = { hash = 0xAA69, comp = "MouthD" },
        ["Mouth DistanceX"] = { hash = 0x7AC3, comp = "MouthX" },
        ["Mouth DistanceY"] = { hash = 0x410D, comp = "MouthY" },
        ["Lip Upper Height"] = { hash = 0x1A00, comp = "ULiphH" },
        ["Lip Upper Width"] = { hash = 0x91C1, comp = "ULiphW" },
        ["Lip Upper Depth"] = { hash = 0xC375, comp = "ULiphD" },
        ["Lip Lower Height"] = { hash = 0xBB4D, comp = "LLiphH" },
        ["Lip Lower Width"] = { hash = 0xB0B0, comp = "LLiphW" },
        ["Lip Lower Depth"] = { hash = 0x5D16, comp = "LLiphD" },
        ["Mouth Corner Left Withd"] = { hash = 57350, comp = "MouthCLW" },
        ["Mouth Corner Right Withd"] = { hash = 60292, comp = "MouthCRW" },
        ["Mouth Corner Left Depth"] = { hash = 40950, comp = "MouthCLD" },
        ["Mouth Corner Right Depth"] = { hash = 49299, comp = "MouthCRD" },
        ["Mouth Corner Left Height"] = { hash = 46661, comp = "MouthCLH" },
        ["Mouth Corner Right Height"] = { hash = 55718, comp = "MouthCRH" },
        ["Mouth Corner Left Lips Distance"] = { hash = 22344, comp = "MouthCLLD" },
        ["Mouth Corner Right Lips Distance"] = { hash = 9423, comp = "MouthCRLD" },
    },
    upperbody = {
        ["Arms Size"] = { hash = 46032, comp = "ArmsS" },
        ["Upper Shoulders Size"] = { hash = 50039, comp = "ShouldersS" },
        ["Back Shoulders Thickness"] = { hash = 7010, comp = "ShouldersT" },
        ["Back Muscles"] = { hash = 18046, comp = "ShouldersM" }, -- shoulder blades / back muscles
        ["Chest Size"] = { hash = 27779, comp = "ChestS" },
        ["Waist Width"] = { hash = 50460, comp = "WaistW" },
        ["Hips Size"] = { hash = 49787, comp = "HipsS" }, -- hip width / stomach size
    },

    lowerbody = {
        ["Tights Size"] = { hash = 64834, comp = "LegsS" },
        ["Calves Size"] = { hash = 42067, comp = "CalvesS" },
    },

}



Config.HashList = {
    Gunbelt     = 0x9B2C8B89,
    Mask        = 0x7505EF42,
    Holster     = 0xB6B6122D,
    Loadouts    = 0x83887E88,
    Coat        = 0xE06D30CE,
    Cloak       = 0x3C1A74CD,
    EyeWear     = 0x5E47CA6,
    Bracelet    = 0x7BC10759,
    Skirt       = 0xA0E3AB7F,
    Poncho      = 0xAF14310B,
    Spats       = 0x514ADCEA,
    NeckTies    = 0x7A96FACA,
    Spurs       = 0x18729F39,
    Pant        = 0x1D4C528A,
    Suspender   = 0x877A2CF7,
    Glove       = 0xEABE0032,
    Satchels    = 0x94504D26,
    GunbeltAccs = 0xF1542D11,
    CoatClosed  = 0x662AC34,
    Buckle      = 0xFAE9107F,
    RingRh      = 0x7A6BBD0B,
    Belt        = 0xA6D134C6,
    Accessories = 0x79D7DF96,
    Shirt       = 0x2026C46D,
    Gauntlets   = 0x91CE9B20,
    Chap        = 0x3107499B,
    NeckWear    = 0x5FC29285,
    Boots       = 0x777EC6EF,
    Vest        = 0x485EE834,
    RingLh      = 0xF16A1D23,
    Hat         = 0x9925C067,
    Dress       = 0xA2926F9B,
    Badge       = 0x3F7F3587,
    armor       = 0x72E6EF74,
    Hair        = 0x864B03AE,
    Beard       = 0xF8016BCA,
    bow         = 0x8E84A2AA,
}

Config.clothesPalettes = { 1090645383, 1064202495, -783849117, 864404955, 1669565057, -1952348042 }
