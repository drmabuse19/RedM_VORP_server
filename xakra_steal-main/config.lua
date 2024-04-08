Config = {}

-- Menu alignment setting
Config.Align = 'top-left' -- Sets the alignment of the menu on the screen

-- Language setting - English | Portuguese_PT | Portuguese_BR | French | German | Spanish
Config.Lang = 'English'

-- Keybindings
Config.KeySteal = 0xA1ABB953      -- Key binding for steal action [G]
Config.HandsUpButton = 0x8CC9CD42 -- Key binding for hands up [X]

-- Stealing conditions
Config.StealHogtied = true -- Allow stealing from hogtied players
Config.Cuffed = true       -- Allow stealing from handcuffed players
Config.StealHandsUp = true -- Allow stealing from players with their hands up
Config.StealDead = true    -- Allow stealing from dead players

-- Webhook Configuration Section
Config.Webhook = {
    UseWebhook = false,     -- Set to 'true' to enable webhook integration for logging events
    WebhookUrl = "",        -- The URL of the Discord webhook
    WebhookTitle = "",      -- The title for webhook messages
    WebhookColor = "",      -- Color code for the webhook embed (e.g., '#FF5733' or a decimal color code)
    WebhookName = "",       -- The name that will appear as the sender of the webhook messages
    WebhookLogo = "",       -- URL of the logo image to display in the webhook embed
    WebhookLogoFooter = "", -- URL of the footer logo image to display in the webhook embed
    WebhookAvatar = ""      -- URL of the avatar image for the webhook sender
}

-- Requirements for stealing (e.g., minimum number of police)
Config.RequiredJobs = {
    Amount = 0,  -- Minimum number of police required
    Jobs = {
        'police' -- Job identifier for police
    },
}

-- Limits on the amount that can be stolen
Config.Limit = {
    Money = 10,  -- Max amount of money that can be stolen (set to false for no limit)
    Weapons = 1, -- Max number of weapons that can be stolen (set to false for no limit)
    Items = 10,  -- Max number of items that can be stolen (set to false for no limit)
}

-- Blacklist of items and weapons that cannot be stolen
Config.ItemsBlackList = {
    'water',              -- Example item
    'WEAPON_MELEE_KNIFE', -- Example weapon
}
