Config = {}

Config.UseTeleports = true
Config.Blips = false

-- Change interior_sets with the interior you want at that location
-- https://github.com/femga/rdr3_discoveries/blob/399df3278b5101af1044f205c045648d2c8bcb38/interiors/interior_sets/README.md

Config.Shacks = {

    
    ['new_austin'] = {
        ['outside'] = vector3(-2769.23, -3048.90, 11.38),
        ['inside'] = vector3(-2769.3, -3048.87, -9.7),
        ['interior'] = 78337,
        ['interior_sets'] = {
            "mp006_mshine_band2",
            "mp006_mshine_bar_benchAndFrame",
            "mp006_mshine_dressing_1",
            "mp006_mshine_hidden_door_open",
            "mp006_mshine_location1",
            "mp006_mshine_pic_09",
            "mp006_mshine_shelfwall1",
            "mp006_mshine_shelfwall2",
            "mp006_mshine_Still_02",
            "mp006_mshine_still_hatch",
            "mp006_mshine_theme_refined",
        },
    },

    }
