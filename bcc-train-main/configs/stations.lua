-----------------------------------------------------
-- Train Station Config
-----------------------------------------------------
Stations = {
    valentine = {
        shop = {
            name     = 'Valentine Station',             -- Name of Station on Menu Header
            prompt   = 'Valentine Station',             -- Text Below the Menu Prompt Button
            distance = 2.0,                             -- Distance Between Player and Station to Show Menu Prompt
            jobsEnabled = true,                         -- Allow Access to Specified Jobs Only
            jobs     = {                                -- Allowed Jobs - ex. jobs = {{name = 'police', grade = 1},{name = 'doctor', grade = 3}}
                {name = 'conductor', grade = 0},
            },
            hours    = {
                active = false,                         -- Station uses Open and Closed Hours
                open   = 7,                             -- Station Open Time / 24 Hour Clock
                close  = 21                             -- Station Close Time / 24 Hour Clock
            }
        },
        blip = {
            show   = true,                              -- Show Blip On Map
            showClosed = true,                          -- Show Blip On Map when Closed
            name   = 'Valentine Station',               -- Name of Blip on Map
            sprite = 1258184551,                        -- Default: 1258184551
            color  = {
                open   = 'WHITE',                       -- Station Open - Default: White - Blip Colors Shown Below
                closed = 'RED',                         -- Station Closed - Deafault: Red - Blip Colors Shown Below
                job    = 'YELLOW_ORANGE'                -- Station Job Locked - Default: Yellow - Blip Colors Shown Below
            }
        },
        npc = {
            active   = true,                            -- Turns NPC On / Off
            model    = 's_m_m_sdticketseller_01',       -- Model Used for NPC
            coords   = vector3(-172.9, 629.79, 114.03), -- NPC and Station Blip Positions
            heading  = 228.81,                          -- NPC Heading
            distance = 100                              -- Distance Between Player and Station for NPC to Spawn
        },
        train = {
            coords  = vector3(-163.78, 628.17, 113.52), -- Make Sure the Coord Here is Directly on Top of the Track You Want the Train to Spawn On!
            outWest = false,                            -- Set false if This is Not in the Desert/Western Part of the Map
        }
    },
    -----------------------------------------------------

    emerald = {
        shop = {
            name     = 'Emerald Station',
            prompt   = 'Emerald Station',
            distance = 2.0,
            jobsEnabled = true,
            jobs     = {
                {name = 'conductor', grade = 0},
            },
            hours    = {
                active = false,
                open   = 7,
                close  = 21
            }
        },
        blip = {
            show   = true,
            showClosed = true,
            name   = 'Emerald Station',
            sprite = 1258184551,
            color  = {
                open   = 'WHITE',
                closed = 'RED',
                job    = 'YELLOW_ORANGE'
            }
        },
        npc = {
            active   = true,
            model    = 's_m_m_sdticketseller_01',
            coords   = vector3(1525.18, 442.51, 90.68),
            heading  = 270.86,
            distance = 100
        },
        train = {
            coords  = vector3(1529.67, 442.54, 90.22),
            outWest = false,
        }
    },
    -----------------------------------------------------

    flatneck = {
        shop = {
            name     = 'Flatneck Station',
            prompt   = 'Flatneck Station',
            distance = 2.0,
            jobsEnabled = true,
            jobs     = {
                {name = 'conductor', grade = 0},
            },
            hours    = {
                active = false,
                open   = 7,
                close  = 21
            }
        },
        blip = {
            show   = true,
            showClosed = true,
            name   = 'Flatneck Station',
            sprite = 1258184551,
            color  = {
                open   = 'WHITE',
                closed = 'RED',
                job    = 'YELLOW_ORANGE'
            }
        },
        npc = {
            active   = true,
            model    = 's_m_m_sdticketseller_01',
            coords   = vector3(-335.89, -361.2, 88.08),
            heading  = 115.48,
            distance = 100
        },
        train = {
            coords  = vector3(-339.0, -350.0, 87.81),
            outWest = false,
        }
    },
    -----------------------------------------------------

    rhodes = {
        shop = {
            name     = 'Rhodes Station',
            prompt   = 'Rhodes Station',
            distance = 2.0,
            jobsEnabled = true,
            jobs     = {
                {name = 'conductor', grade = 0},
            },
            hours    = {
                active = false,
                open   = 7,
                close  = 21
            }
        },
        blip = {
            show   = true,
            showClosed = true,
            name   = 'Rhodes Station',
            sprite = 1258184551,
            color  = {
                open   = 'WHITE',
                closed = 'RED',
                job    = 'YELLOW_ORANGE'
            }
        },
        npc = {
            active   = true,
            model    = 's_m_m_sdticketseller_01',
            coords   = vector3(1225.77, -1296.45, 76.9),
            heading  = 271.52,
            distance = 100
        },
        train = {
            coords  = vector3(1226.74, -1310.03, 76.47),
            outWest = false,
        }
    },
    -----------------------------------------------------

    stdenis = {
        shop = {
            name     = 'Saint Denis Station',
            prompt   = 'Saint Denis Station',
            distance = 2.0,
            jobsEnabled = true,
            jobs     = {
                {name = 'conductor', grade = 0},
            },
            hours    = {
                active = false,
                open   = 7,
                close  = 21
            }
        },
        blip = {
            show   = true,
            showClosed = true,
            name   = 'Saint Denis Station',
            sprite = 1258184551,
            color  = {
                open   = 'WHITE',
                closed = 'RED',
                job    = 'YELLOW_ORANGE'
            }
        },
        npc = {
            active   = true,
            model    = 's_m_m_sdticketseller_01',
            coords   = vector3(2747.5, -1398.89, 46.18),
            heading  = 74.02,
            distance = 100
        },
        train = {
            coords  = vector3(2770.08, -1414.51, 45.98),
            outWest = false,
        }
    },
    -----------------------------------------------------

    annesburg = {
        shop = {
            name     = 'Annesburg Station',
            prompt   = 'Annesburg Station',
            distance = 2.0,
            jobsEnabled = true,
            jobs     = {
                {name = 'conductor', grade = 0},
            },
            hours    = {
                active = false,
                open   = 7,
                close  = 21
            }
        },
        blip = {
            show   = true,
            showClosed = true,
            name   = 'Annesburg Station',
            sprite = 1258184551,
            color  = {
                open   = 'WHITE',
                closed = 'RED',
                job    = 'YELLOW_ORANGE'
            }
        },
        npc = {
            active   = true,
            model    = 's_m_m_sdticketseller_01',
            coords   = vector3(2938.98, 1282.05, 44.65),
            heading  = 89.44,
            distance = 100
        },
        train = {
            coords  = vector3(2957.25, 1281.58, 43.95),
            outWest = false,
        }
    },
    -----------------------------------------------------

    bacchus = {
        shop = {
            name     = 'Bacchus Station',
            prompt   = 'Bacchus Station',
            distance = 2.0,
            jobsEnabled = true,
            jobs     = {
                {name = 'conductor', grade = 0},
            },
            hours    = {
                active = false,
                open   = 7,
                close  = 21
            }
        },
        blip = {
            show   = true,
            showClosed = true,
            name   = 'Bacchus Station',
            sprite = 1258184551,
            color  = {
                open   = 'WHITE',
                closed = 'RED',
                job    = 'YELLOW_ORANGE'
            }
        },
        npc = {
            active   = true,
            model    = 's_m_m_sdticketseller_01',
            coords   = vector3(582.49, 1681.07, 187.79),
            heading  = 315.88,
            distance = 100
        },
        train = {
            coords  = vector3(581.14, 1691.8, 187.6),
            outWest = false,
        }
    },
    -----------------------------------------------------

    wallace = {
        shop = {
            name     = 'Wallace Station',
            prompt   = 'Wallace Station',
            distance = 2.0,
            jobsEnabled = true,
            jobs     = {
                {name = 'conductor', grade = 0},
            },
            hours    = {
                active = false,
                open   = 7,
                close  = 21
            }
        },
        blip = {
            show   = true,
            showClosed = true,
            name   = 'Wallace Station',
            sprite = 1258184551,
            color  = {
                open   = 'WHITE',
                closed = 'RED',
                job    = 'YELLOW_ORANGE'
            }
        },
        npc = {
            active   = true,
            model    = 's_m_m_sdticketseller_01',
            coords   = vector3(-1307.86, 395.86, 95.38),
            heading  = 61.95,
            distance = 100
        },
        train = {
            coords  = vector3(-1307.62, 406.83, 94.98),
            outWest = false,
        }
    },
    -----------------------------------------------------

    riggs = {
        shop = {
            name     = 'Riggs Station',
            prompt   = 'Riggs Station',
            distance = 2.0,
            jobsEnabled = true,
            jobs     = {
                {name = 'conductor', grade = 0},
            },
            hours    = {
                active = false,
                open   = 7,
                close  = 21
            }
        },
        blip = {
            show   = true,
            showClosed = true,
            name   = 'Riggs Station',
            sprite = 1258184551,
            color  = {
                open   = 'WHITE',
                closed = 'RED',
                job    = 'YELLOW_ORANGE'
            }
        },
        npc = {
            active   = true,
            model    = 's_m_m_sdticketseller_01',
            coords   = vector3(-1096.58, -575.92, 82.41),
            heading  = 8.67,
            distance = 100
        },
        train = {
            coords  = vector3(-1097.07, -583.71, 81.67),
            outWest = false,
        }
    },
    -----------------------------------------------------

    armadillo = {
        shop = {
            name     = 'Armadillo Station',
            prompt   = 'Armadillo Station',
            distance = 2.0,
            jobsEnabled = true,
            jobs     = {
                {name = 'conductor', grade = 0},
            },
            hours    = {
                active = false,
                open   = 7,
                close  = 21
            }
        },
        blip = {
            show   = true,
            showClosed = true,
            name   = 'Armadillo Station',
            sprite = 1258184551,
            color  = {
                open   = 'WHITE',
                closed = 'RED',
                job    = 'YELLOW_ORANGE'
            }
        },
        npc = {
            active   = true,
            model    = 's_m_m_sdticketseller_01',
            coords   = vector3(-3733.71, -2602.73, -12.92),
            heading  = 75.7,
            distance = 100
        },
        train = {
            coords  = vector3(-3748.85, -2600.8, -13.72),
            outWest = true,
        }
    },
    -----------------------------------------------------

    benedict = {
        shop = {
            name     = 'Benedict Station',
            prompt   = 'Benedict Station',
            distance = 2.0,
            jobsEnabled = true,
            jobs     = {
                {name = 'conductor', grade = 0},
            },
            hours    = {
                active = false,
                open   = 7,
                close  = 21
            }
        },
        blip = {
            show   = true,
            showClosed = true,
            name   = 'Benedict Station',
            sprite = 1258184551,
            color  = {
                open   = 'WHITE',
                closed = 'RED',
                job    = 'YELLOW_ORANGE'
            }
        },
        npc = {
            active   = true,
            model    = 's_m_m_sdticketseller_01',
            coords   = vector3(-5230.56, -3470.81, -20.57),
            heading  = 88.7,
            distance = 100
        },
        train = {
            coords  = vector3(-5235.54, -3473.3, -21.25),
            outWest = true,
        }
    }
}