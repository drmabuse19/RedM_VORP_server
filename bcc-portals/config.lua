-- bcc-portals
Config = {}

-- Set Language
Config.defaultlang = 'en_lang'
-----------------------------------------------------

-- Open Portals Menu
Config.key = 0x760A9C6F --[G]
-----------------------------------------------------

-- Travel Time is Computed Based on Distance
Config.time = 2.0 -- Default: 3.0 / Travel Time Multiplier
-----------------------------------------------------

-- Price is Computed Based on Distance
Config.price = 0.1 -- Default: 0.012 / Price Multiplier
-----------------------------------------------------

-- Portal Shops
Config.shops = {
    annesburg = {
        shop = {
            name     = 'Annesburg Havn',              -- Name of Shop on Menu Header
            prompt   = 'Annesburg Havn',              -- Text Below the Menu Prompt Button
            distance = 2.0,                             -- Distance Between Player and Shop to Show Menu Prompt
            currency = 1,                               -- 1 = Cash-Only / 2 = Gold-Only / 3 = Cash and Gold / 4 = Free
            jobsEnabled = false,                        -- Allow Shop Access to Specified Jobs Only
            jobs     = {                                -- Insert Job to Limit Access - ex. jobs = {{name = 'police', grade = 1},{name = 'doctor', grade = 3}}
                {name = 'police', grade = 1},
                {name = 'doctor', grade = 3}
            },
            hours    = {
                active = false,                         -- Shop uses Open and Closed Hours
                open   = 7,                             -- Shop Open Time / 24 Hour Clock
                close  = 21                             -- Shop Close Time / 24 Hour Clock
            }
        },
        blip = {
            show   = true,                              -- Show Blip On Map
            showClosed = true,                          -- Show Blip On Map when Closed
            name   = 'Annesburg Havn',                -- Name of Blip on Map
            sprite = 784218150,                         -- Default: 784218150
            color  = {
                open   = 'WHITE',                       -- Shop Open - Default: White - Blip Colors Shown Below
                closed = 'RED',                         -- Shop Closed - Deafault: Red - Blip Colors Shown Below
                job    = 'YELLOW_ORANGE'                -- Shop Job Locked - Default: Yellow - Blip Colors Shown Below
            }
        },
        npc = {
            active   = true,                             -- Turns NPC On / Off
            model    = 's_m_m_sdticketseller_01',        -- Model Used for NPC
            coords   = vector3(3020.14, 1351.72, 42.69), -- NPC and Shop Blip Positions
            heading  = 237.13,                           -- NPC Heading
            distance = 100                               -- Distance Between Player and Shop for NPC to Spawn
        },
        player = {
            coords  = vector3(3018.15, 1344.16, 42.63), -- Player Teleport Position
            heading = 52.18                             -- Player Heading
        },
        outlets = {                                     -- Available Locations for Shop / label is the Name Used in the Body of the Menu
            armadillo  = { label = 'Armadillo'   },
            blackwater = { label = 'Blackwater'  },
            rhodes     = { label = 'Rhodes'      },
            strawberry = { label = 'Strawberry'  },
            stdenis    = { label = 'Saint Denis' },
            tumbleweed = { label = 'Tumbleweed'  },
            valentine  = { label = 'Valentine'   },
            vanhorn    = { label = 'Van Horn'    }
        }
    },
        -----------------------------------------------------

    blackwater = {
        shop = {
            name     = 'Blackwater Havn',
            prompt   = 'Blackwater Havn',
            distance = 2.0,
            currency = 1,
            jobsEnabled = false,
            jobs     = {
                {name = 'police', grade = 1},
                {name = 'doctor', grade = 3}
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
            name   = 'Blackwater Havn',
            sprite = 784218150,
            color  = {
                open   = 'WHITE',
                closed = 'RED',
                job    = 'YELLOW_ORANGE'
            }
        },
        npc = {
            active   = true,
            model    = 's_m_m_sdticketseller_01',
            coords   = vector3(-732.87, -1232.39, 43.73),
            heading  = 133.34,
            distance = 100
        },
        player = {
            coords  = vector3(-733.99, -1233.41, 44.73),
            heading = 313.2
        },
         outlets = {
            annesburg  = { label = 'Annesburg'   },
           blackwater = { label = 'Blackwater'  },
                       
            stdenis    = { label = 'Saint Denis' },
            
            vanhorn    = { label = 'Van Horn'    }
        }
    },
    -----------------------------------------------------

    -----------------------------------------------------

      -----------------------------------------------------

    stdenis = {
        shop = {
            name     = 'Saint Denis Havn',
            prompt   = 'Saint Denis Havn',
            distance = 2.0,
            currency = 3,
            jobsEnabled = false,
            jobs     = {
                {name = 'police', grade = 1},
                {name = 'doctor', grade = 3}
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
            name   = 'Saint Denis Havn',
            sprite = 784218150,
            color  = {
                open   = 'WHITE',
                closed = 'RED',
                job    = 'YELLOW_ORANGE'
            }
        },
        npc = {
            active   = true,
            model    = 's_m_m_sdticketseller_01',
            coords   = vector3(2704.35, -1505.67, 44.18),
            heading  =188.91,
            distance = 100
        },
        player = {
            coords  = vector3(2693.21, -1506.75, 42.72),
            heading = 201.54
        },
         outlets = {
            annesburg  = { label = 'Annesburg'   },
           blackwater = { label = 'Blackwater'  },
                       
            stdenis    = { label = 'Saint Denis' },
            
            vanhorn    = { label = 'Van Horn'    }
        }
    },

    vanhorn = {
        shop = {
            name     = 'Van Horn Havn',
            prompt   = 'Van Horn Havn',
            distance = 2.0,
            currency = 3,
            jobsEnabled = false,
            jobs     = {
                {name = 'police', grade = 1},
                {name = 'doctor', grade = 3}
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
            name   = 'Van Horn',
            sprite = 784218150,
            color  = {
                open   = 'WHITE',
                closed = 'RED',
                job    = 'YELLOW_ORANGE'
            }
        },
        npc = {
            active   = true,
            model    = 's_m_m_sdticketseller_01',
            coords   = vector3(3016.77, 552.85, 44.7),
            heading  = 364.27,
            distance = 100
        },
        player = {
            coords  = vector3(3016.77, 552.85, 44.7),
            heading = 254.74
        },
         outlets = {
            annesburg  = { label = 'Annesburg'   },
           blackwater = { label = 'Blackwater'  },
                       
            stdenis    = { label = 'Saint Denis' },
            
            vanhorn    = { label = 'Van Horn'    }
        }
    }
}
-----------------------------------------------------

Config.BlipColors = {
    LIGHT_BLUE    = 'BLIP_MODIFIER_MP_COLOR_1',
    DARK_RED      = 'BLIP_MODIFIER_MP_COLOR_2',
    PURPLE        = 'BLIP_MODIFIER_MP_COLOR_3',
    ORANGE        = 'BLIP_MODIFIER_MP_COLOR_4',
    TEAL          = 'BLIP_MODIFIER_MP_COLOR_5',
    LIGHT_YELLOW  = 'BLIP_MODIFIER_MP_COLOR_6',
    PINK          = 'BLIP_MODIFIER_MP_COLOR_7',
    GREEN         = 'BLIP_MODIFIER_MP_COLOR_8',
    DARK_TEAL     = 'BLIP_MODIFIER_MP_COLOR_9',
    RED           = 'BLIP_MODIFIER_MP_COLOR_10',
    LIGHT_GREEN   = 'BLIP_MODIFIER_MP_COLOR_11',
    TEAL2         = 'BLIP_MODIFIER_MP_COLOR_12',
    BLUE          = 'BLIP_MODIFIER_MP_COLOR_13',
    DARK_PUPLE    = 'BLIP_MODIFIER_MP_COLOR_14',
    DARK_PINK     = 'BLIP_MODIFIER_MP_COLOR_15',
    DARK_DARK_RED = 'BLIP_MODIFIER_MP_COLOR_16',
    GRAY          = 'BLIP_MODIFIER_MP_COLOR_17',
    PINKISH       = 'BLIP_MODIFIER_MP_COLOR_18',
    YELLOW_GREEN  = 'BLIP_MODIFIER_MP_COLOR_19',
    DARK_GREEN    = 'BLIP_MODIFIER_MP_COLOR_20',
    BRIGHT_BLUE   = 'BLIP_MODIFIER_MP_COLOR_21',
    BRIGHT_PURPLE = 'BLIP_MODIFIER_MP_COLOR_22',
    YELLOW_ORANGE = 'BLIP_MODIFIER_MP_COLOR_23',
    BLUE2         = 'BLIP_MODIFIER_MP_COLOR_24',
    TEAL3         = 'BLIP_MODIFIER_MP_COLOR_25',
    TAN           = 'BLIP_MODIFIER_MP_COLOR_26',
    OFF_WHITE     = 'BLIP_MODIFIER_MP_COLOR_27',
    LIGHT_YELLOW2 = 'BLIP_MODIFIER_MP_COLOR_28',
    LIGHT_PINK    = 'BLIP_MODIFIER_MP_COLOR_29',
    LIGHT_RED     = 'BLIP_MODIFIER_MP_COLOR_30',
    LIGHT_YELLOW3 = 'BLIP_MODIFIER_MP_COLOR_31',
    WHITE         = 'BLIP_MODIFIER_MP_COLOR_32'
}