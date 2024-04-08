--=============================================
--            VORP SHARED CONFIG             --
--=============================================

-- Ensure you understand each setting.
-- If unsure, ask or leave the default value.

-- Set the language for your server.
-- Check the 'translation' folder for available options.
Lang = "English"

Config = {
    autoUpdateDB           = true,  -- Enables automatic database updates.
    PrintPlayerInfoOnLeave = false, -- Logs player information in the server console when they leave.
    PrintPlayerInfoOnEnter = false, -- Logs player information in the server console upon joining.

    --=============================================
    --        STARTING CONFIGURATION             --
    --=============================================

    initGold               = 0.0,          -- Initial gold amount for new players.
    initMoney              = 500.0,        -- Initial money amount for new players.
    initRol                = 0.0,          -- Initial role-play currency amount for new players.
    initXp                 = 0,            -- Initial experience points for new players.
    initJob                = "unemployed", -- Default job for new players. Recommended not to change.
    initJobGrade           = 0,            -- Default job grade for new players. Recommended not to change.
    initGroup              = "user",       -- Default user group for new players. Recommended not to change.
    initJobLabel           = "Unemployed", -- Default job label for new players. Recommended not to change.
    Whitelist              = false,        -- Enable if not using TxAdmin's whitelist system.
    SavePlayersStatus      = true,        -- Future deprecated. Advised not to use, as it will be removed.
    maxHealth              = 10,           -- Maximum health for players. 10 is full, 0 is empty.
    maxStamina             = 10,           -- Maximum stamina for players. 10 is full, 0 is empty.
    PVP                    = true,         -- Enables player vs player combat.
    PVPToggle              = true,        -- Allows players to toggle their PVP status.
    CommandOnOffPVP        = 'pvp',        -- Command to toggle PVP status, requires PVPToggle to be true.
    savePlayersTimer       = 10,           -- Interval in minutes for automatically saving all players to the database.
    showplayerIDwhenfocus  = true,         -- Shows player Steam name when focusing on them with RMB if set to false.
    disableAutoAIM         = true,         -- Disables auto-aim for controller players if set to false.
    SavePlayersHours       = true,        -- Enables saving of players' played hours in the database. TxAdmin might already provide this.
    CheckDoubleAccounts    = false,        -- Enables, check if player enter with two accounts if false players can enter with same character and dupe.
    --=============================================
    --          MULTICHARACTER SUPPORT           --
    --=============================================

    SaveDiscordId          = true, -- Saves Discord ID in the character/user database upon joining/leaving.
    MaxCharacters          = 1,    -- Maximum number of characters a player can create. when first join, for old users go to users table and change the number of characters there

    --=============================================
    --             UI CORE SETTINGS              --
    --=============================================

    HideOnlyDEADEYE        = true,  -- Hides only the Dead Eye core in the UI.
    HidePlayersCore        = false, -- Hides player cores in the UI.
    HideHorseCores         = false, -- Hides horse cores in the UI.

    --=============================================
    --          WEBHOOK CONFIGURATIONS           --
    --     Refer to commands.config for usage.   --
    --=============================================

    webhookColor           = 16711680,                            -- Color for embeds in Discord webhooks.
    name                   = "VORP",                              -- Name displayed in webhook embeds.
    logo                   = "https://via.placeholder.com/30x30", -- Logo URL for webhook embeds.
    footerLogo             = "https://via.placeholder.com/30x30", -- Footer logo URL for webhook embeds.
    Avatar                 = "https://via.placeholder.com/30x30", -- Avatar URL for webhook embeds.

    --=============================================
    --            UI CONFIGURATIONS              --
    --=============================================

    HideUi                 = false,      -- Shows or hides the overall UI.
    HideGold               = false,      -- Disables the Gold UI for all players.
    HideMoney              = false,      -- Disables the Money UI for all players.
    HideLevel              = false,      -- Disables the Level UI for all players.
    HideID                 = false,      -- Disables the ID UI for all players.
    HideTokens             = false,      -- Disables the Token UI for all players.
    HidePVP                = false,      -- Disables the PVP UI for all players.
    UIPosition             = 'TopRight', -- Sets the UI position on the screen.
    UILayout               = 'Column',   -- Sets the UI layout, options are 'Row' or 'Column'.
    HideWithRader          = false,       -- UI hides when the radar (minimap) is hidden.
    OpenAfterRader         = true,       -- UI shows when the radar (minimap) reappears.
    CloseOnDelay           = false,      -- UI automatically closes after a set time.
    CloseOnDelayMS         = 10000,      -- Time in milliseconds before the UI auto-closes, 10000 equals 10 seconds.
    CommandHideIU          = 'hideUi',   -- Command to hide all UI elements, useful for screenshots.
    CommandToogleUI        = 'toggleUi', -- Command to toggle the visibility of VORP UI elements.
    CommandClearAnim       = 'stopAnim', -- Command to stop animations if a player is stuck.

    --=============================================
    --            MAP CONFIGURATIONS             --
    --=============================================

    mapTypeOnFoot          = 1,     -- Radar type when on foot. 0 = Off, 1 = Regular, 2 = Expanded, 3 = Simple (compass).
    mapTypeOnMount         = 1,     -- Radar type when on horse. Same options as on foot.
    enableTypeRadar        = true, -- Enables custom radar types if true, otherwise players use game settings.
    Loadinscreen           = true,  -- Enables loading screens during spawn and respawn.
    LoadinScreenTimer      = 10000, -- Duration of loading screens in milliseconds.

    --=============================================
    --            RESPAWN SETTINGS               --
    --=============================================

    HealthOnRespawn        = 500,                                  -- Player health after respawning at a hospital (max is 500).
    HealthOnResurrection   = 100,                                  -- Player health after being resurrected (max is 500).
    RagdollOnResurrection  = true,                                 -- Enables ragdoll and revive effects upon resurrection.
    HealthRecharge         = { enable = true, multiplier = 0.37 }, -- Auto-recharge for health, with a multiplier for speed.
    StaminaRecharge        = { enable = true, multiplier = 0.4 },  -- Auto-recharge for stamina, with a multiplier for speed.
    RespawnTime            = 1,                                   -- Time in seconds before a player can respawn.
    RespawnKey             = 0xDFF812F9,                           -- Key code for respawning (default is 'E').
    RespawnKeyTime         = 500,                                 -- Time in milliseconds to hold the respawn key.
    CombatLogDeath         = true,                                 -- Combat loggers respawn in a dead state instead of alive.
    UseControlsCamera      = false,                                -- Allows dead or carried players to move the camera with WASD (resource intensive).
    UseDeathHandler        = true,                                 -- Keeps default death handling unless you have a custom system.
    Hospitals              = {                                     -- Spawn points for players respawning at hospitals.
                SaintDenis = {
            name = "Saint Denis",
            pos = vector4(2717.63, -1233.76, 50.37, 339.95),
        }    },
    ActiveEagleEye         = true,  -- Enables or disables Eagle Eye feature.
    ActiveDeadEye          = false, -- Enables or disables Dead Eye feature.

    --=============================================
    --         BAN SYSTEM CONFIGURATIONS         --
    --=============================================

    DateTimeFormat         = "%d/%m/%y %H:%M:%S", -- Format for displaying date and time in ban notifications.
    TimeZone               = " CET",              -- Set your server's timezone.
    TimeZoneDifference     = 1,                   -- Time difference from UTC, used in the banning system.

    --=============================================
    --        COMMAND PERMISSION SETTINGS        --
    --=============================================

    NewPlayerWebhook       = "",    -- Webhook URL for logging new player joins.
    SetUserDBadmin         = true,  -- If true, 'addGroup' command also sets admin status in the Users table.
    SetBothDBadmin         = false, -- If true, 'addGroup' sets admin status in both Users and Characters tables.

    --=============================================
    --    DISCORD RICH PRESENCE INTEGRATION      --
    --=============================================

    maxplayers             = 42,                         -- Maximum number of players allowed on the server.
    appid                  = nil,                        -- Discord Application ID. Replace this with your own application's ID.
    biglogo                = "LOGOname",                 -- Name of the image asset to use for the large icon in the rich presence.
    biglogodesc            = " Redm Server Connect: ",   -- Description displayed when hovering over the large icon.
    smalllogo              = "smallboy name",            -- Name of the image asset for the small icon in the rich presence. This is optional.
    smalllogodesc          = "Join us for a good time ", -- Description displayed when hovering over the small icon.
    richpresencebutton     = "Join Discord",             -- Text displayed on the rich presence button.
    shownameandid          = true,                       -- Whether to display the player's Steam name and ID.
    Buttons                = {                           -- Configuration for buttons shown in the Discord rich presence.
        {
            text = 'Join Discord!',                      -- Text displayed on the first button.
            -- URL the first button directs to. Replace with your Discord invite link.
            url = 'https://discord.gg/vorpcore'

        },
        {
            text = 'Website', -- Text displayed on the second button.
            -- URL the second button directs to. Fill in with your website URL.
            url = ''          -- Example for Rich Presence Button
        }
    }
    --=============================================
}
