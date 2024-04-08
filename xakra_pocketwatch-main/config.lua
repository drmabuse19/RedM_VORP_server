Config = {}

--[[ 
    type = 'Inspect' (Synchronized interaction with the players but only first person camera)
    type = 'InspectZ' (Non-synchronized interaction with the players but you can switch between third and first person cameras)

    --########################### POCKET WATCH ALL LIST ###########################
    p_si_pocketwatch01x
    s_inv_pocketwatch01x
    s_inv_pocketwatch02x
    s_inv_pocketwatch03x
    s_inv_pocketwatch04x
    s_inv_pocketwatch06x
    s_inv_pocketwatch07x
    s_oldpocketwatch01x
    s_pocketwatch_reutlinge 
--]]

Config.PocketWatches = {
    { item = 'pocket_watch', prop = 's_inv_pocketwatch04x', type = 'InspectZ' },
    { item = 'pocket_watch_gold', prop = 's_inv_pocketwatch03x', type = 'Inspect' },
    { item = 'pocket_watch_platinum', prop = 's_inv_pocketwatch01x', type = 'Inspect' },
    { item = 'pocket_watch_silver', prop = 's_inv_pocketwatch02x', type = 'Inspect' },
}