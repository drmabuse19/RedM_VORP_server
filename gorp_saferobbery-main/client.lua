local safe = { 
"P_BANK_SAFE_R", 
"P_BANK_SAFE_MED_L", 
"P_GEN_SAFE01", 
"S_SAFE03X", 
"S_SAFE02X", 
"S_SAFE01X", 
"P_SAFETYDEPOSITBOX01X", 
"P_SAFENBD02X", 
"P_SAFENBD01X", 
"P_SAFEBLA01X", 
"P_SAFE01",
"P_SAFE_SER", 
"P_GEN_SAFE02", 
"P_GEN_SAFE01", 
"P_DOORSAFE_H", 
"P_SAINTDENISTOP01X", 
"P_DEPOSITBOXSET01X", 
"P_DEPOSITBOXGROUP02X", 
"P_DEPOSITBOXGROUP01X", 
"P_TNT_TRAINROBBERY_01X", 
"P_CS_TRAINCRATETNT01X", 
"P_CS_TRAINCRATETNT02X",
"S_COACHROBBERY01BX", 
"S_COACHROBBERY01X", 
"S_DOORROBBERY01X", 
"S_DOORROBBERY02X", 
"S_DOORROBBERY03X", 
"S_DOORROBBERY04X", 
"S_DOORROBBERY05X", 
"S_DOORROBBERY06X", 
"S_DOORROBBERY07X", 
"S_DOORROBBERY08X", 
"S_LOOTABLEBEDCHEST_A", 
"S_LOOTABLEBEDCHEST_B", 
"S_LOOTABLEBEDCHEST_C", 
"S_LOOTABLEBEDCHEST_D", 
"S_LOOTABLEBEDCHEST", 
"S_RUSTEDCHEST01X",
"S_MISCCHEST_LOOT_D", 
"P_ADL_CHESTLRG01X", 
"P_CHEST_LRG", 
"P_CHEST_MED", 
"P_CHEST01X", 
"P_CHEST02X", 
"P_CHEST03X", 
"P_SDTHEATER_CHEST01X", 
"P_WEDDINGCHEST01X", 
"S_ARTHURCHEST01X", 
"S_CRAFTEDARTHURCHEST01X", 
"S_CVAN_CHEST01", 
"S_CVAN_CHEST02", 
"S_LOOTABLEBIGNARROWMISCCHEST", 
"S_LOOTABLEBIGMISCCHEST", 
"S_LOOTABLEBIGBLUECHEST03X", 
"S_LOOTABLEBIGBLUECHEST02X", 
"S_LOOTABLEBIGBLUECHEST01X", 
"p_trunk01x",
"s_vault_sml_l_val01x",
"p_gate_valbankvlt"
}
RegisterNetEvent('gorp:saferobbery')
AddEventHandler('gorp:saferobbery', function()
	local x, y, z = table.unpack(GetEntityCoords(PlayerPedId()))
	for key, value in pairs(safe) do
		local safe = DoesObjectOfTypeExistAtCoords(x, y, z, 1.0, GetHashKey(value), true)
		if safe then
			TaskStartScenarioInPlace(GetPlayerPed(), GetHashKey('WORLD_HUMAN_CROUCH_INSPECT'), -1, true, false, false, false)
            exports['progressBars']:startUI(15000, "Lockpicking...")
			Wait(15000)
			ClearPedTasks(GetPlayerPed())
			TriggerServerEvent("gorp:robberycomplete")
		end
	end
end)
