local QBCore = exports['qb-core']:GetCoreObject()

local currentClass = "Normal"
local currentMode = "Automatic"
local vaildveh = false

-- Pursuit Mode

function validVehicle(vehicleModel)
    for k,v in pairs(Config.VehiclesConfig) do
        if Config.VehiclesConfig[k]["model"] == vehicleModel then
            return true
        end
    end

    return false
end


function getHandlingConfig(vehicleModel, type)
    for k,v in pairs(Config.VehiclesConfig) do
        if Config.VehiclesConfig[k]["model"] == vehicleModel then
            return Config.VehiclesConfig[k][currentClass][type]
        end
    end
end

function changeClass()
    if currentClass == "Normal" then
        currentClass = "Sport"
        SetVehicleModKit(GetVehiclePedIsIn(PlayerPedId()), 0)
        ToggleVehicleMod(GetVehiclePedIsIn(PlayerPedId()), 22, true) -- toggle xenon lights
        ToggleVehicleMod(GetVehiclePedIsIn(PlayerPedId()), 18, true) -- upgrade turbo to max level
        SetVehicleMod(GetVehiclePedIsIn(PlayerPedId()), 11, 2, false) -- upgrade engine to max level
        SetVehicleHeadlightsColour(GetVehiclePedIsIn(PlayerPedId()), 8)
    elseif currentClass == "Sport" then
        currentClass = "Normal"
        ToggleVehicleMod(GetVehiclePedIsIn(PlayerPedId()), 22, false) -- toggle off xenon lights
        ToggleVehicleMod(GetVehiclePedIsIn(PlayerPedId()), 18, false) -- toggle off turbo
        SetVehicleMod(GetVehiclePedIsIn(PlayerPedId()), 3, -1, false) -- change engine to lowest level
    end
end

CreateThread(function()
    while true do
        local plyPed = PlayerPedId()
        if IsPedInAnyVehicle(PlayerPedId(), false) then
            local plyVehicle = GetVehiclePedIsIn(plyPed)
            if validVehicle(GetEntityModel(plyVehicle)) and DoesEntityExist(plyVehicle) then
                vaildveh = true
                SetVehicleHandlingFloat(plyVehicle, "CHandlingData", "fDriveInertia", getHandlingConfig(GetEntityModel(plyVehicle), "fDriveInertia"))
                SetVehicleHandlingFloat(plyVehicle, "CHandlingData", "fInitialDriveMaxFlatVel", getHandlingConfig(GetEntityModel(plyVehicle), "fInitialDriveMaxFlatVel"))
                -- SetVehicleHandlingFloat(plyVehicle, "CHandlingData", "fBrakeForce", getHandlingConfig(GetEntityModel(plyVehicle), "fBrakeForce"))
                -- SetVehicleHandlingFloat(plyVehicle, "CHandlingData", "fBrakeBiasFront", getHandlingConfig(GetEntityModel(plyVehicle), "fBrakeBiasFront"))
                SetVehicleHandlingFloat(plyVehicle, "CHandlingData", "fSteeringLock", getHandlingConfig(GetEntityModel(plyVehicle), "fSteeringLock"))
                SetVehicleHandlingFloat(plyVehicle, "CHandlingData", "fInitialDriveForce", getHandlingConfig(GetEntityModel(plyVehicle), "fInitialDriveForce"))
                if IsControlPressed(0, Config.KeyBind) then
                    changeClass()
                    -- exports["mythic_notify"]:SendAlert("inform", "Pursuit Mode : " .. currentClass, 3000)
                    QBCore.Functions.Notify("Pursuit Mode : " ..currentClass,  "primary", 3500)
                    SetVehicleHandlingFloat(plyVehicle, "CHandlingData", "fDriveInertia", getHandlingConfig(GetEntityModel(plyVehicle), "fDriveInertia"))
                    SetVehicleHandlingFloat(plyVehicle, "CHandlingData", "fInitialDriveMaxFlatVel", getHandlingConfig(GetEntityModel(plyVehicle), "fInitialDriveMaxFlatVel"))
                    -- SetVehicleHandlingFloat(plyVehicle, "CHandlingData", "fBrakeForce", getHandlingConfig(GetEntityModel(plyVehicle), "fBrakeForce"))
                    -- SetVehicleHandlingFloat(plyVehicle, "CHandlingData", "fBrakeBiasFront", getHandlingConfig(GetEntityModel(plyVehicle), "fBrakeBiasFront"))
                    SetVehicleHandlingFloat(plyVehicle, "CHandlingData", "fSteeringLock", getHandlingConfig(GetEntityModel(plyVehicle), "fSteeringLock"))
                    SetVehicleHandlingFloat(plyVehicle, "CHandlingData", "fInitialDriveForce", getHandlingConfig(GetEntityModel(plyVehicle), "fInitialDriveForce"))
                end
            else
                vaildveh = false
                Wait(600)
            end
        else
            vaildveh = false
            currentClass = "Normal"
        end
        -- if IsControlPressed(0, Config.WeaponKeyBind) then
        --     if currentMode == "Automatic" then
        --         currentMode = "Single"
        --         QBCore.Functions.Notify('Silah Atış Modu "TEK')
        --     elseif currentMode == "Single" then
        --         currentMode = "Burst"
        --         QBCore.Functions.Notify('Silah Atış Modu "Burst"')
        --     elseif currentMode == "Burst" then
        --         currentMode = "Automatic"
        --         QBCore.Functions.Notify('Silah Atış Modu "Otomatik"')
        --     end
        -- end

        Wait(600)
    end
end)

-- exports("currentClass", function()
--     if currentClass == "Normal" then
-- return 25
--     elseif currentClass == "Sport" then
--         return 100
--     end
-- end)

exports("validVehicle", function()
    return vaildveh
end)

-- Weapon Modes

-- exports("currentMode", function()
--     if currentMode == "Single" then
--         return 25
--     elseif currentMode == "Burst" then
--         return 60
--     elseif currentMode == "Automatic" then
--         return 100
--     end
-- end)

CreateThread(function()
    while true do
        Wait(0)
        local playerPed = PlayerPedId()
        local shooting = IsPedShooting(playerPed)

        if shooting and currentMode == "Single" then
            DisablePlayerFiring(playerPed, true)
        elseif shooting and currentMode == "Burst" then
            Wait(300)
            DisablePlayerFiring(playerPed, true)
        end

    end
end)


