-- Other stuff normally here, stripped for the sake of only scenario stuff
local SCENARIO_TYPES = {
    "WORLD_VEHICLE_MILITARY_PLANES_SMALL", -- Zancudo Small Planes
    "WORLD_VEHICLE_MILITARY_PLANES_BIG", -- Zancudo Big Planes
    "WORLD_VEHICLE_POLICE_BIKE",                                               
    "WORLD_VEHICLE_POLICE_CAR",                                               
    "WORLD_VEHICLE_POLICE_NEXT_TO_CAR",
    "WORLD_VEHICLE_TRUCK_LOGS",  
    "WORLD_VEHICLE_DRIVE_SOLO",
    "WORLD_VEHICLE_SALTON_DIRT_BIKE",
    "WORLD_VEHICLE_STREETRACE",
    "WORLD_VEHICLE_SALTON",
    "WORLD_VEHICLE_MECHANIC",
    "WORLD_VEHICLE_EMPTY",
    "WORLD_VEHICLE_BUSINESSMEN",
    "WORLD_VEHICLE_BIKE_OFF_ROAD_RACE",
}

local SCENARIO_GROUPS = {
    "LSA_Planes",
    "SANDY_PLANES",
    "ng_planes", -- Far up in the skies jets
    "ALAMO_PLANES",
    "BLIMP",
    "ARMY_HELI",
    "GRAPESEED_PLANES",
    "Grapeseed_Planes",
}

local SUPPRESSED_MODELS = {
    `SHAMAL`, -- They spawn on LSIA and try to take off
    `LUXOR`, -- They spawn on LSIA and try to take off
    `LUXOR2`, -- They spawn on LSIA and try to take off
    `JET`, -- They spawn on LSIA and try to take off and land, remove this if you still want em in the skies
    `LAZER`, -- They spawn on Zancudo and try to take off
    `TITAN`, -- They spawn on Zancudo and try to take off
    `BARRACKS`, -- Regularily driving around the Zancudo airport surface
    `BARRACKS2`, -- Regularily driving around the Zancudo airport surface
    `CRUSADER`, -- Regularily driving around the Zancudo airport surface
    `RHINO`, -- Regularily driving around the Zancudo airport surface
    `AIRTUG`, -- Regularily spawns on the LSIA airport surface
    `RIPLEY`, -- Regularily spawns on the LSIA airport surface
    `blimp`,
    `rubble`,
    `taco`,
    `biff`,
    `blimp2`,
    `frogger`,
    `frogger2`,
}

Citizen.CreateThread(function()
    while true do
        for _, sctyp in next, SCENARIO_TYPES do
            SetScenarioTypeEnabled(sctyp, false)
        end
        for _, scgrp in next, SCENARIO_GROUPS do
            SetScenarioGroupEnabled(scgrp, false)
        end
        for _, model in next, SUPPRESSED_MODELS do
            SetVehicleModelIsSuppressed(model, true)
        end
        SetAiMeleeWeaponDamageModifier(4.0)
        Citizen.Wait(10000)
    end
end)