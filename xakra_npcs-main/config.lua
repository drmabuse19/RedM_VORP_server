Config = {}

Config.NPCS = {
       { -- Guard
        coords = vector4(-0.66, -248.16, 100.72, 314.07), -- Npc coordinates
        model = 'S_M_M_SkpGuard_01', -- Npc model
        weapon = 'WEAPON_RIFLE_BOLTACTION', -- Choose the weapon that will be equipped or without a weapon
        outfit = 8, -- Outfit number or random (false)
        scenario = 'WORLD_HUMAN_GUARD_LANTERN_NERVOUS', -- Choose the scenario that the npc will perform or disable the scenario (false)
        anim = { animDict = false, animName = '' }, -- Choose animation or disable animation by putting false in animDict or animName
        scale = false, -- Increase or decrease the NPC e.g. 0.6 for a very very small or 1.5 for a giant. (false is default)
    }}