armed = false
local reviveKey = 0x760A9C6F -- Change this to the desired key (e.g., '23' for F)

-- List of animal models to revive
local animalModels = {
          "A_C_Alligator_02",
	"A_C_Alligator_03",
	"A_C_Armadillo_01",
	"A_C_Badger_01",
	"A_C_Bat_01",
	"A_C_BearBlack_01",
	"A_C_Bear_01",
	"A_C_Beaver_01",
	"A_C_BigHornRam_01",
	"A_C_BlueJay_01",
	"A_C_BoarLegendary_01",
	"A_C_Boar_01",
	"A_C_Buck_01",
	"A_C_Buffalo_01",
	"A_C_Buffalo_Tatanka_01",
	"A_C_Bull_01",
	"A_C_CaliforniaCondor_01",
	"A_C_Cardinal_01",
	"A_C_CarolinaParakeet_01",
	"A_C_Cat_01",
	"A_C_CedarWaxwing_01",
	"A_C_Chicken_01",
	"A_C_Chipmunk_01",
	"A_C_Cormorant_01",
	"A_C_Cougar_01",
	"A_C_Cow",
	"A_C_Coyote_01",
	"A_C_Crab_01",
	"A_C_CraneWhooping_01",
	"A_C_Crawfish_01",
	"A_C_Crow_01",
	"A_C_Deer_01",
	"A_C_DogAmericanFoxhound_01",
	"A_C_DogAustralianSheperd_01",
	"A_C_DogBluetickCoonhound_01",
	"A_C_DogCatahoulaCur_01",
	"A_C_DogChesBayRetriever_01",
	"A_C_DogCollie_01",
	"A_C_DogHobo_01",
	"A_C_DogHound_01",
	"A_C_DogHusky_01",
	"A_C_DogLab_01",
	"A_C_DogLion_01",
	"A_C_DogPoodle_01",
	"A_C_DogRufus_01",
	"A_C_DogStreet_01",
	"A_C_Donkey_01",
	"A_C_Duck_01",
	"A_C_Eagle_01",
	"A_C_Egret_01",
	"A_C_Elk_01",
	"A_C_FishBluegil_01_ms",
	"A_C_FishBluegil_01_sm",
	"A_C_FishBullHeadCat_01_ms",
	"A_C_FishBullHeadCat_01_sm",
	"A_C_FishChainPickerel_01_ms",
	"A_C_FishChainPickerel_01_sm",
	"A_C_FishChannelCatfish_01_lg",
	"A_C_FishChannelCatfish_01_XL",
	"A_C_FishLakeSturgeon_01_lg",
	"A_C_FishLargeMouthBass_01_lg",
	"A_C_FishLargeMouthBass_01_ms",
	"A_C_FishLongNoseGar_01_lg",
	"A_C_FishMuskie_01_lg",
	"A_C_FishNorthernPike_01_lg",
	"A_C_FishPerch_01_ms",
	"A_C_FishPerch_01_sm",
	"A_C_FishRainbowTrout_01_lg",
	"A_C_FishRainbowTrout_01_ms",
	"A_C_FishRedfinPickerel_01_ms",
	"A_C_FishRedfinPickerel_01_sm",
	"A_C_FishRockBass_01_ms",
	"A_C_FishRockBass_01_sm",
	"A_C_FishSalmonSockeye_01_lg",
	"A_C_FishSalmonSockeye_01_ml",
	"A_C_FishSalmonSockeye_01_ms",
	"A_C_FishSmallMouthBass_01_lg",
	"A_C_FishSmallMouthBass_01_ms",
	"A_C_Fox_01",
	"A_C_FrogBull_01",
	"A_C_GilaMonster_01",
	"A_C_Goat_01",
	"A_C_GooseCanada_01",
	"A_C_Hawk_01",
	"A_C_Heron_01",
	"A_C_HorseMulePainted_01",
	"A_C_HorseMule_01",
	"A_C_Horse_AmericanPaint_Greyovero",
	"A_C_Horse_AmericanPaint_Overo",
	"A_C_Horse_AmericanPaint_SplashedWhite",
	"A_C_Horse_AmericanPaint_Tobiano",
	"A_C_Horse_AmericanStandardbred_Black",
	"A_C_Horse_AmericanStandardbred_Buckskin",
	"A_C_Horse_AmericanStandardbred_LightBuckskin",
	"A_C_Horse_AmericanStandardbred_PalominoDapple",
	"A_C_Horse_AmericanStandardbred_SilverTailBuckskin",
	"A_C_Horse_Andalusian_DarkBay",
	"A_C_Horse_Andalusian_Perlino",
	"A_C_Horse_Andalusian_RoseGray",
	"A_C_Horse_Appaloosa_BlackSnowflake",
	"A_C_Horse_Appaloosa_Blanket",
	"A_C_Horse_Appaloosa_BrownLeopard",
	"A_C_Horse_Appaloosa_FewSpotted_PC",
	"A_C_Horse_Appaloosa_Leopard",
	"A_C_Horse_Appaloosa_LeopardBlanket",
	"A_C_Horse_Arabian_Black",
	"A_C_Horse_Arabian_Grey",
	"A_C_Horse_Arabian_RedChestnut",
	"A_C_Horse_Arabian_RedChestnut_PC",
	"A_C_Horse_Arabian_RoseGreyBay",
	"A_C_Horse_Arabian_WarpedBrindle_PC",
	"A_C_Horse_Arabian_White",
	"A_C_Horse_Ardennes_BayRoan",
	"A_C_Horse_Ardennes_IronGreyRoan",
	"A_C_Horse_Ardennes_StrawberryRoan",
	"A_C_Horse_Belgian_BlondChestnut",
	"A_C_Horse_Belgian_MealyChestnut",
	"A_C_Horse_Breton_GrulloDun",
	"A_C_Horse_Breton_MealyDappleBay",
	"A_C_Horse_Breton_RedRoan",
	"A_C_Horse_Breton_sealbrown",
	"A_C_Horse_Breton_Sorrel",
	"A_C_Horse_Breton_SteelGrey",
	"A_C_Horse_Buell_WarVets",
	"A_C_Horse_Criollo_BayBrindle",
	"A_C_Horse_Criollo_BayFrameOvero",
	"A_C_Horse_Criollo_BlueRoanOvero",
	"A_C_Horse_Criollo_Dun",
	"A_C_Horse_Criollo_MarbleSabino",
	"A_C_Horse_Criollo_SorrelOvero",
	"A_C_Horse_DutchWarmblood_ChocolateRoan",
	"A_C_Horse_DutchWarmblood_SealBrown",
	"A_C_Horse_DutchWarmblood_SootyBuckskin",
	"A_C_Horse_EagleFlies",
	"A_C_Horse_Gang_Bill",
	"A_C_Horse_Gang_Charles",
	"A_C_Horse_Gang_Charles_EndlessSummer",
	"A_C_Horse_Gang_Dutch",
	"A_C_Horse_Gang_Hosea",
	"A_C_Horse_Gang_Javier",
	"A_C_Horse_Gang_John",
	"A_C_Horse_Gang_Karen",
	"A_C_Horse_Gang_Kieran",
	"A_C_Horse_Gang_Lenny",
	"A_C_Horse_Gang_Micah",
	"A_C_Horse_Gang_Sadie",
	"A_C_Horse_Gang_Sadie_EndlessSummer",
	"A_C_Horse_Gang_Sean",
	"A_C_Horse_Gang_Trelawney",
	"A_C_Horse_Gang_Uncle",
	"A_C_Horse_Gang_Uncle_EndlessSummer",
	"A_C_Horse_GypsyCob_PalominoBlagdon",
	"A_C_Horse_GypsyCob_Piebald",
	"A_C_Horse_GypsyCob_Skewbald",
	"A_C_Horse_GypsyCob_SplashedBay",
	"A_C_Horse_GypsyCob_SplashedPiebald",
	"A_C_Horse_GypsyCob_WhiteBlagdon",
	"A_C_Horse_HungarianHalfbred_DarkDappleGrey",
	"A_C_Horse_HungarianHalfbred_FlaxenChestnut",
	"A_C_Horse_HungarianHalfbred_LiverChestnut",
	"A_C_Horse_HungarianHalfbred_PiebaldTobiano",
	"A_C_Horse_John_EndlessSummer",
	"A_C_Horse_KentuckySaddle_Black",
	"A_C_Horse_KentuckySaddle_ButterMilkBuckskin_PC",
	"A_C_Horse_KentuckySaddle_ChestnutPinto",
	"A_C_Horse_KentuckySaddle_Grey",
	"A_C_Horse_KentuckySaddle_SilverBay",
	"A_C_Horse_Kladruber_Black",
	"A_C_Horse_Kladruber_Cremello",
	"A_C_Horse_Kladruber_DappleRoseGrey",
	"A_C_Horse_Kladruber_Grey",
	"A_C_Horse_Kladruber_Silver",
	"A_C_Horse_Kladruber_White",
	"A_C_Horse_MissouriFoxTrotter_AmberChampagne",
	"A_C_Horse_MissouriFoxTrotter_SableChampagne",
	"A_C_Horse_MissouriFoxTrotter_SilverDapplePinto",
	"A_C_Horse_Morgan_Bay",
	"A_C_Horse_Morgan_BayRoan",
	"A_C_Horse_Morgan_FlaxenChestnut",
	"A_C_Horse_Morgan_LiverChestnut_PC",
	"A_C_Horse_Morgan_Palomino",
	"A_C_Horse_MP_Mangy_Backup",
	"A_C_Horse_MurfreeBrood_Mange_01",
	"A_C_Horse_MurfreeBrood_Mange_02",
	"A_C_Horse_MurfreeBrood_Mange_03",
	"A_C_Horse_Mustang_GoldenDun",
	"A_C_Horse_Mustang_GrulloDun",
	"A_C_Horse_Mustang_TigerStripedBay",
	"A_C_Horse_Mustang_WildBay",
	"A_C_Horse_Nokota_BlueRoan",
	"A_C_Horse_Nokota_ReverseDappleRoan",
	"A_C_Horse_Nokota_WhiteRoan",
	"A_C_Horse_NorfolkRoadster_Black",
	"A_C_Horse_NorfolkRoadster_DappledBuckskin",
	"A_C_Horse_NorfolkRoadster_PiebaldRoan",
	"A_C_Horse_NorfolkRoadster_RoseGrey",
	"A_C_Horse_NorfolkRoadster_SpeckledGrey",
	"A_C_Horse_NorfolkRoadster_SpottedTricolor",
	"A_C_Horse_Shire_DarkBay",
	"A_C_Horse_Shire_LightGrey",
	"A_C_Horse_Shire_RavenBlack",
	"A_C_Horse_SuffolkPunch_RedChestnut",
	"A_C_Horse_SuffolkPunch_Sorrel",
	"A_C_Horse_TennesseeWalker_BlackRabicano",
	"A_C_Horse_TennesseeWalker_Chestnut",
	"A_C_Horse_TennesseeWalker_DappleBay",
	"A_C_Horse_TennesseeWalker_FlaxenRoan",
	"A_C_Horse_TennesseeWalker_GoldPalomino_PC",
	"A_C_Horse_TennesseeWalker_MahoganyBay",
	"A_C_Horse_TennesseeWalker_RedRoan",
	"A_C_Horse_Thoroughbred_BlackChestnut",
	"A_C_Horse_Thoroughbred_BloodBay",
	"A_C_Horse_Thoroughbred_Brindle",
	"A_C_Horse_Thoroughbred_DappleGrey",
	"A_C_Horse_Thoroughbred_ReverseDappleBlack",
	"A_C_Horse_Turkoman_DarkBay",
	"A_C_Horse_Turkoman_Gold",
	"A_C_Horse_Turkoman_Silver",
	"A_C_Horse_Winter02_01",
	"A_C_IguanaDesert_01",
	"A_C_Iguana_01",
	"A_C_Javelina_01",
	"A_C_LionMangy_01",
	"A_C_Loon_01",
	"A_C_Moose_01",
	"A_C_Muskrat_01",
	"A_C_Oriole_01",
	"A_C_Owl_01",
	"A_C_Ox_01",
	"A_C_Panther_01",
	"A_C_Parrot_01",
	"A_C_Pelican_01",
	"A_C_Pheasant_01",
	"A_C_Pigeon",
	"A_C_Pig_01",
	"A_C_Possum_01",
	"A_C_PrairieChicken_01",
	"A_C_Pronghorn_01",
	"A_C_Quail_01",
	"A_C_Rabbit_01",
	"A_C_Raccoon_01",
	"A_C_Rat_01",
	"A_C_Raven_01",
	"A_C_RedFootedBooby_01",
	"A_C_Robin_01",
	"A_C_Rooster_01",
	"A_C_RoseateSpoonbill_01",
	"A_C_Seagull_01",
	"A_C_SharkHammerhead_01",
	"A_C_SharkTiger",
	"A_C_Sheep_01",
	"A_C_Skunk_01",
	"A_C_SnakeBlackTailRattle_01",
	"A_C_SnakeBlackTailRattle_Pelt_01",
	"A_C_SnakeFerDeLance_01",
	"A_C_SnakeFerDeLance_Pelt_01",
	"A_C_SnakeRedBoa10ft_01",
	"A_C_SnakeRedBoa_01",
	"A_C_SnakeRedBoa_Pelt_01",
	"A_C_SnakeWater_01",
	"A_C_SnakeWater_Pelt_01",
	"A_C_Snake_01",
	"A_C_Snake_Pelt_01",
	"A_C_SongBird_01",
	"A_C_Sparrow_01",
	"A_C_Squirrel_01",
	"A_C_Toad_01",
	"A_C_TurkeyWild_01",
	"A_C_Turkey_01",
	"A_C_Turkey_02",
	"A_C_TurtleSea_01",
	"A_C_TurtleSnapping_01",
	"A_C_Vulture_01",
	"A_C_Wolf",
	"A_C_Wolf_Medium",
	"A_C_Wolf_Small",
	"A_C_Woodpecker_01",
	"A_C_Woodpecker_02",

}

-- Animation variables
local animDict = "amb_work@world_human_crouch_inspect@female_a@idle_a"
local animName = "idle_a"
local animPlaying = false
local animTime = 5000 -- Animation duration in milliseconds (5 seconds)
local reviveTime = 3000 -- Revive time in milliseconds (3 seconds)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        if IsControlJustPressed(0, reviveKey) and armed then
            local playerPed = PlayerPedId()
            local playerPos = GetEntityCoords(playerPed)

            for _, ped in ipairs(GetGamePool("CPed")) do
                if IsPedDeadOrDying(ped) and IsAnimalModel(ped) and #(GetEntityCoords(ped) - playerPos) < 2.0 then
                    if not animPlaying then
                        animPlaying = true

                        -- Play animation for the player
                        RequestAnimDict(animDict)
                        while not HasAnimDictLoaded(animDict) do
                            Citizen.Wait(0)
                        end

                        TaskPlayAnim(playerPed, animDict, animName, 1.0, 1.0, animTime, 1, 0, false, false, false)
                    end

                    -- Wait for the animation duration
                    Citizen.Wait(animTime)

                    -- Revive the ped
                    ResurrectPed(ped)
                    SetEntityHealth(ped, GetEntityMaxHealth(ped))
                    SetPedRelationshipGroupHash(ped, GetPedRelationshipGroupHash(playerPed))
                    TaskWanderStandard(ped, 10.0, 10)
                    SetPedCombatAttributes(ped, 17, true) -- Set combat mode to passive
                    ClearPedTasksImmediately(ped) -- Clear all tasks

                    SetPedAsGroupMember(ped, GetPedGroupIndex(playerPed))
              
                    SetPedCanBeTargettedByPlayer(ped, false)
                    SetPedCanBeTargetted(ped, false)

                    TriggerEvent("chat:addMessage", {
                        color = { 0, 255, 0 },
                        multiline = true,
                        args = { "Revive", "Animal ped revived and added to your group!" }
                    })

                    -- Wait for the revive time
                    Citizen.Wait(reviveTime)

                    -- Stop the animation
                    ClearPedTasks(playerPed)
                    animPlaying = false

                    break -- Only revive one ped at a time
                end
            end
        end
    end
end)

function IsAnimalModel(ped)
    local pedModel = GetEntityModel(ped)

    for _, model in ipairs(animalModels) do
        if GetHashKey(model) == pedModel then
            return true
        end
    end

    return false
end