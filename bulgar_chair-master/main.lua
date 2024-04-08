local SeatPrompt
local CancelPrompt

local SeatGroup = GetRandomIntInRange(0, 0xffffff)
local CancelGroup = GetRandomIntInRange(0, 0xffffff)

function Seat()
    Citizen.CreateThread(function()
        local str = 'Seat'
        local wait = 0
        SeatPrompt = Citizen.InvokeNative(0x04F97DE45A519419)
        PromptSetControlAction(SeatPrompt, 0x018C47CF)
        str = CreateVarString(10, 'LITERAL_STRING', str)
        PromptSetText(SeatPrompt, str)
        PromptSetEnabled(SeatPrompt, true)
        PromptSetVisible(SeatPrompt, true)
        PromptSetHoldMode(SeatPrompt, true)
        PromptSetGroup(SeatPrompt, SeatGroup)
        PromptRegisterEnd(SeatPrompt)
    end)
end

function cancel()
    Citizen.CreateThread(function()
        local str = 'Cancel'
        local wait = 0
        CancelPrompt = Citizen.InvokeNative(0x04F97DE45A519419)
        PromptSetControlAction(CancelPrompt, 0x018C47CF)
        str = CreateVarString(10, 'LITERAL_STRING', str)
        PromptSetText(CancelPrompt, str)
        PromptSetEnabled(CancelPrompt, true)
        PromptSetVisible(CancelPrompt, true)
        PromptSetHoldMode(CancelPrompt, true)
        PromptSetGroup(CancelPrompt, CancelGroup)
        PromptRegisterEnd(CancelPrompt)
    end)
end

local target

Props = {
    {"p_pianochair01x", "GENERIC_SEAT_BENCH_SCENARIO"} ,
    {"p_stool06x", "GENERIC_SEAT_BENCH_SCENARIO"} ,
    {"p_benchpiano02x", "GENERIC_SEAT_BENCH_SCENARIO"} ,
    {"p_stool08x", "GENERIC_SEAT_BENCH_SCENARIO"} ,
    {"P_CHAIRCOMFY04X", "GENERIC_SEAT_BENCH_SCENARIO"} ,
    {"P_CHAIR14X", "GENERIC_SEAT_BENCH_SCENARIO"} ,
    {"P_SIT_CHAIRWICKER01B", "GENERIC_SEAT_BENCH_SCENARIO"} ,
    {"P_SIT_CHAIRWICKER01A", "GENERIC_SEAT_BENCH_SCENARIO"} ,
    {"S_CRATESEAT03X", "GENERIC_SEAT_BENCH_SCENARIO"} ,
    {"P_CHAIRWICKER01X", "GENERIC_SEAT_BENCH_SCENARIO"} ,
    {"P_CHAIRROCKING06X", "GENERIC_SEAT_BENCH_SCENARIO"} ,
    {"P_WINDSORCHAIR03X", "GENERIC_SEAT_BENCH_SCENARIO"} ,
    {"P_CHAIR13X", "GENERIC_SEAT_BENCH_SCENARIO"} ,
    {"P_CHAIR12X", "GENERIC_SEAT_BENCH_SCENARIO"} ,
    {"p_bistrochair01x", "GENERIC_SEAT_BENCH_SCENARIO"} ,
    {"p_bistrochair02x", "GENERIC_SEAT_BENCH_SCENARIO"} ,
    {"P_CHAIRFOLDING02X", "GENERIC_SEAT_BENCH_SCENARIO"} ,
    {"P_CHAIR06X", "GENERIC_SEAT_BENCH_SCENARIO"} ,
    {"P_CHAIR22X", "GENERIC_SEAT_BENCH_SCENARIO"} ,
    {"P_WOODENCHAIR01X", "GENERIC_SEAT_BENCH_SCENARIO"} ,
    {"P_DININGCHAIRS01X", "GENERIC_SEAT_BENCH_SCENARIO"} ,
    {"P_WINDSORCHAIR02X", "GENERIC_SEAT_BENCH_SCENARIO"} ,
    {"P_LOVESEAT01X", "GENERIC_SEAT_BENCH_SCENARIO"} ,
    {"P_BENCH06X", "GENERIC_SEAT_BENCH_SCENARIO"} ,
    {"P_BENCH17X", "GENERIC_SEAT_BENCH_SCENARIO"} ,
    {"P_COUCH05X", "GENERIC_SEAT_BENCH_SCENARIO"} ,
    {"P_COUCH08X", "GENERIC_SEAT_BENCH_SCENARIO"} ,
    {"P_BENCH_LOG07X", "GENERIC_SEAT_BENCH_SCENARIO"} ,
    {"P_WINDSORBENCH01X", "GENERIC_SEAT_BENCH_SCENARIO"} ,
    {"P_BENCH15X", "GENERIC_SEAT_BENCH_SCENARIO"} ,
    {"p_seatbench01x", "GENERIC_SEAT_BENCH_SCENARIO"} ,
    {"p_chairdesk01x", "GENERIC_SEAT_BENCH_SCENARIO"} ,
    {"p_chairdesk02x", "GENERIC_SEAT_BENCH_SCENARIO"} ,
    {"p_couch02x", "GENERIC_SEAT_BENCH_SCENARIO"} ,
    {"p_woodendeskchair01x", "GENERIC_SEAT_BENCH_SCENARIO"} ,
    {"p_chair05x", "GENERIC_SEAT_BENCH_SCENARIO"} ,
    {"p_chairrusticsav01x", "GENERIC_SEAT_BENCH_SCENARIO"} ,
    {"p_chaircomfy11x", "GENERIC_SEAT_BENCH_SCENARIO"} ,
    {"p_medwheelchair01x", "GENERIC_SEAT_BENCH_SCENARIO"} ,
    {"p_chairdoctor01x", "GENERIC_SEAT_BENCH_SCENARIO"} ,
    {"p_ambchair01x", "GENERIC_SEAT_BENCH_SCENARIO"} ,
    {"mp005_s_posse_trad_chair01x", "GENERIC_SEAT_BENCH_SCENARIO"} ,
    {"p_chairoffice02x", "GENERIC_SEAT_BENCH_SCENARIO"} ,
    {"p_chair_barrel04b", "GENERIC_SEAT_BENCH_SCENARIO"} ,
    {"p_chairrustic05x", "GENERIC_SEAT_BENCH_SCENARIO"} ,
    {"p_chairrocking03x", "GENERIC_SEAT_BENCH_SCENARIO"} ,
    {"p_chaircomfy17x", "GENERIC_SEAT_BENCH_SCENARIO"} ,
    {"p_chair07x", "GENERIC_SEAT_BENCH_SCENARIO"} ,
    {"p_chaircomfy23x", "GENERIC_SEAT_BENCH_SCENARIO"} ,
    {"p_chair37x", "GENERIC_SEAT_BENCH_SCENARIO"} ,
    {"p_chaircomfy12x", "GENERIC_SEAT_BENCH_SCENARIO"} ,
    {"p_chestchair01x", "GENERIC_SEAT_BENCH_SCENARIO"} ,
    {"p_chairdining01x", "GENERIC_SEAT_BENCH_SCENARIO"} ,
    {"p_chaircomfy09x", "GENERIC_SEAT_BENCH_SCENARIO"} ,
    {"p_chairrustic03x", "GENERIC_SEAT_BENCH_SCENARIO"} ,
    {"mp005_s_posse_foldingchair_01x", "GENERIC_SEAT_BENCH_SCENARIO"} ,
    {"p_theaterchair01b01x", "GENERIC_SEAT_BENCH_SCENARIO"} ,
    {"p_chair04x", "GENERIC_SEAT_BENCH_SCENARIO"} ,
    {"p_cs_electricchair01x", "GENERIC_SEAT_BENCH_SCENARIO"} ,
    {"s_bfchair04x", "GENERIC_SEAT_BENCH_SCENARIO"} ,
    {"p_chair_crate15x", "GENERIC_SEAT_BENCH_SCENARIO"} ,
    {"p_chaircomfycombo01x", "GENERIC_SEAT_BENCH_SCENARIO"} ,
    {"p_rockingchair01x", "GENERIC_SEAT_BENCH_SCENARIO"} ,
    {"p_chairwicker03x", "GENERIC_SEAT_BENCH_SCENARIO"} ,
    {"p_chaircomfy01x", "GENERIC_SEAT_BENCH_SCENARIO"} ,
    {"p_chair20x", "GENERIC_SEAT_BENCH_SCENARIO"} ,
    {"p_chairdining03x", "GENERIC_SEAT_BENCH_SCENARIO"} ,
    {"p_chairrustic02x", "GENERIC_SEAT_BENCH_SCENARIO"} ,
    {"p_chaircomfy07x", "GENERIC_SEAT_BENCH_SCENARIO"} ,
    {"s_chair04x", "GENERIC_SEAT_BENCH_SCENARIO"} ,
    {"p_chairrocking02x", "GENERIC_SEAT_BENCH_SCENARIO"} ,
    {"p_chaircomfy02", "GENERIC_SEAT_BENCH_SCENARIO"} ,
    {"p_chair_privatedining01x", "GENERIC_SEAT_BENCH_SCENARIO"} ,
    {"p_chairtall01x", "GENERIC_SEAT_BENCH_SCENARIO"} ,
    {"p_chair30x", "GENERIC_SEAT_BENCH_SCENARIO"} ,
    {"p_chairpokerfancy01x", "GENERIC_SEAT_BENCH_SCENARIO"} ,
    {"p_chaircomfy14x", "GENERIC_SEAT_BENCH_SCENARIO"} ,
    {"p_privatelounge_chair01x", "GENERIC_SEAT_BENCH_SCENARIO"} ,
    {"p_gen_chair07x", "GENERIC_SEAT_BENCH_SCENARIO"} ,
    {"p_oldarmchair01x", "GENERIC_SEAT_BENCH_SCENARIO"} ,
    {"p_chaircomfy22x", "GENERIC_SEAT_BENCH_SCENARIO"} ,
    {"p_chairrocking04x", "GENERIC_SEAT_BENCH_SCENARIO"} ,
    {"p_chair15x", "GENERIC_SEAT_BENCH_SCENARIO"} ,
    {"p_ambchair02x", "GENERIC_SEAT_BENCH_SCENARIO"} ,
    {"p_chairsalon01x", "GENERIC_SEAT_BENCH_SCENARIO"} ,
    {"p_chair_10x", "GENERIC_SEAT_BENCH_SCENARIO"} ,
    {"p_chairmed01x", "GENERIC_SEAT_BENCH_SCENARIO"} ,
    {"p_chair12bx", "GENERIC_SEAT_BENCH_SCENARIO"} ,
    {"p_chaircomfy06x", "GENERIC_SEAT_BENCH_SCENARIO"} ,
    {"p_chair18x", "GENERIC_SEAT_BENCH_SCENARIO"} ,
    {"p_chair02x", "GENERIC_SEAT_BENCH_SCENARIO"} ,
    {"p_chaircomfy03x", "GENERIC_SEAT_BENCH_SCENARIO"} ,
    {"p_chair21x", "GENERIC_SEAT_BENCH_SCENARIO"} ,
    {"p_rockingchair02x", "GENERIC_SEAT_BENCH_SCENARIO"} ,
    {"p_armchair01x", "GENERIC_SEAT_BENCH_SCENARIO"} ,
    {"p_chair38x", "GENERIC_SEAT_BENCH_SCENARIO"} ,
    {"p_chairmed02x", "GENERIC_SEAT_BENCH_SCENARIO"} ,
    {"p_chair27x", "GENERIC_SEAT_BENCH_SCENARIO"} ,
    {"p_chair23x", "GENERIC_SEAT_BENCH_SCENARIO"} ,
    {"s_electricchair01x", "GENERIC_SEAT_BENCH_SCENARIO"} ,
    {"p_chair11x", "GENERIC_SEAT_BENCH_SCENARIO"} ,
    {"p_chairdining02x", "GENERIC_SEAT_BENCH_SCENARIO"} ,
    {"p_rockingchair03x", "GENERIC_SEAT_BENCH_SCENARIO"} ,
    {"p_chair31x", "GENERIC_SEAT_BENCH_SCENARIO"} ,
    {"p_chair16x", "GENERIC_SEAT_BENCH_SCENARIO"} ,
    {"p_chairdeck01x", "GENERIC_SEAT_BENCH_SCENARIO"} ,
    {"p_loveseat02x", "GENERIC_SEAT_BENCH_SCENARIO"} ,
    {"p_seatsnorpass01_x", "GENERIC_SEAT_BENCH_SCENARIO"} ,
    {"p_seatsnorpass02_x", "GENERIC_SEAT_BENCH_SCENARIO"} ,
    {"p_bench03x", "GENERIC_SEAT_BENCH_SCENARIO"} ,
    {"p_benchbear01x", "GENERIC_SEAT_BENCH_SCENARIO"} ,
    {"p_bench_log05x", "GENERIC_SEAT_BENCH_SCENARIO"} ,
    {"p_benchch01x", "GENERIC_SEAT_BENCH_SCENARIO"} ,
    {"p_bench_log06x", "GENERIC_SEAT_BENCH_SCENARIO"} ,
    {"p_bench09x", "GENERIC_SEAT_BENCH_SCENARIO"} ,
    {"p_benchnbx02x", "GENERIC_SEAT_BENCH_SCENARIO"} ,
    {"p_woodbench02x", "GENERIC_SEAT_BENCH_SCENARIO"} ,
    {"p_bench20x", "GENERIC_SEAT_BENCH_SCENARIO"} ,
    {"p_bench18x", "GENERIC_SEAT_BENCH_SCENARIO"} ,
    {"p_bench_log04x", "GENERIC_SEAT_BENCH_SCENARIO"} ,
    {"p_benchironnbx01x", "GENERIC_SEAT_BENCH_SCENARIO"} ,
    {"p_couch06x", "GENERIC_SEAT_BENCH_SCENARIO"} ,
    {"p_bench_log02x", "GENERIC_SEAT_BENCH_SCENARIO"} ,
    {"p_chairwhite01x", "GENERIC_SEAT_BENCH_SCENARIO"}
}

local coordOBJ
local activeAnim = false
Citizen.CreateThread(function()
    local sleep = 500
    Seat()
    cancel()
    while true do
        local coords = GetEntityCoords(PlayerPedId())
        Wait(sleep)
        if activeAnim then
            local CanceltGroupName  = CreateVarString(10, 'LITERAL_STRING', "")
            PromptSetActiveGroupThisFrame(CancelGroup, CanceltGroupName)
            if PromptHasHoldModeCompleted(CancelPrompt) then
                SetEntityCoordsNoOffset(PlayerPedId(), coordOBJ.x, coordOBJ.y, coordOBJ.z)
                coordOBJ = nil
                Wait(2000)
                activeAnim = false
            end
        else
            for k,v in pairs(Props) do
                local object = GetClosestObjectOfType(coords, 1.0, GetHashKey(v[1]), false, false, false)
                if object ~= 0 then
                    local model = GetEntityModel(object)
                    local closestDistance = 1.5
                    local coords = GetEntityCoords(PlayerPedId())
                    local coordsEntidad = GetEntityCoords(object)
                    local distance = #(coords - coordsEntidad)
                    if distance < closestDistance and GetHashKey(v[1]) == model then
                        sleep = 1
                        local SeatGroupName  = CreateVarString(10, 'LITERAL_STRING', "")
                        PromptSetActiveGroupThisFrame(SeatGroup, SeatGroupName)
                        if PromptHasHoldModeCompleted(SeatPrompt) then
                            local player = PlayerPedId()
                            local chairpos = GetOffsetFromEntityInWorldCoords(object,0.0,0.0,0.5)
                            local chairheading = GetEntityHeading(object)
                            coordOBJ = chairpos
                            TaskStartScenarioAtPosition(player, GetHashKey(v[2]), chairpos.x, chairpos.y, chairpos.z, chairheading+180.0, -1, false, true)
                            activeAnim = true
                        end
                    else
                        sleep = 500
                    end
                end
            end
        end
    end
end)

-- RegisterCommand('stand', function(source, args, rawCommand)
	-- ClearPedTasks(PlayerPedId())
	-- ClearPedTasksImmediately(PlayerPedId()) -- Test
	-- coordOBJ = nil
	-- Citizen.Wait(2000)
	-- activeAnim = false
-- end)
