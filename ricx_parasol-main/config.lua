Config = {}
Config.vorp = true
Config.redm = false

Config.Prompts = {
    Title = "Parasol",
    StopPrompt = 0x5966D52A,
    StopName = "Stop",
}

Config.Parasol = {
    model = GetHashKey("p_parasol02x"),
    anim = {"amb_rest_sit@prop_human_seat_bench@parasol@female_a@wip_base", "wip_base"},
    male = {
        Attach = {0.07, -0.01, -0.03, -90.0, 0.0, 0.0},
        BoneIndex = 337,
    },
    female = {
        Attach = {0.07, -0.03, -0.03, -90.0, 0.0, 0.0},
        BoneIndex = 396,
    },
}


Config.Messages = {
    Title = "Parasol",
    NoParasol = "You cant use it now!",
}

--[[
    Items for redemrp_inventory 2.0
    ["parasol"] =
    {
        label = "Parasol",
        description = "A parasol",
        weight = 1.0,
        canBeDropped = true,
        canBeUsed = true,
        requireLvl = 0,
        limit = 1,
        imgsrc = "items/parasol.png",
        type = "item_standard",
    },
]]
