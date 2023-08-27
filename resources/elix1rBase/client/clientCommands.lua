QBCore = nil

Citizen.CreateThread(function() 
    while QBCore == nil do
        TriggerEvent("QBCore:GetObject", function(obj) QBCore = obj end)    
        Citizen.Wait(200)
    end
end)


RegisterCommand("carhash", function()
    print(GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsIn(PlayerPedId())))) -- Sadece bulunduğunuz aracın adını gösterir.
    print(GetEntityModel(GetVehiclePedIsIn(PlayerPedId()))) 
    print(GetVehicleClassFromName(GetVehiclePedIsIn(PlayerPedId())))
end)

RegisterNetEvent("healevent", function()
    player = GetPlayerPed(-1)
    TriggerServerEvent("QBCore:Server:SetMetaData", "hunger", 90)
    TriggerServerEvent("QBCore:Server:SetMetaData", "thirst", 90)
    SetEntityMaxHealth(player, 200)
    SetEntityHealth(player, 200)
    SetPedArmour(player, 100)
    TriggerServerEvent('hud:server:RelieveStress', 0)
    QBCore.Functions.Notify('All Values ​​Upgraded', 'primary', 7500)
end)

RegisterNetEvent("carfix", function()
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped, false)
       SetVehicleDeformationFixed(vehicle)
       SetVehicleFixed(vehicle)
       SetVehicleTyreFixed(vehicle, 4)
       SetVehicleDirtLevel(vehicle, 0)
     exports['np-fuel']:SetFuel(vehicle, 100)
    QBCore.Functions.Notify('Vehicle Repaired / Cleaned / Fuel Level Maximized')
end)


RegisterNetEvent("aracfulle", function()
    if IsPedInAnyVehicle(PlayerPedId(), false) then
        local vehicle = GetVehiclePedIsIn(PlayerPedId())
        PerformanceUpgradeVehicle(vehicle)
        QBCore.Functions.Notify("I Filled the Vehicle")
    else
        TriggerEvent("QBCore:Notify", "do you think you are in the car kek")
    end
end)

 
local performanceModIndices = { 11, 12, 13, 15, 16 }
function PerformanceUpgradeVehicle(vehicle, customWheels)
    customWheels = customWheels or false
    local max
    if DoesEntityExist(vehicle) and IsEntityAVehicle(vehicle) then
        SetVehicleModKit(vehicle, 0)
        for _, modType in ipairs(performanceModIndices) do
            max = GetNumVehicleMods(vehicle, tonumber(modType)) - 1
            SetVehicleMod(vehicle, modType, max, customWheels)
        end
        ToggleVehicleMod(vehicle, 18, true) -- Turbo
    SetVehicleFixed(vehicle)
    end
end

RegisterCommand('+generalDelete', function()
    if PlayerData.job then
        if string.find(PlayerData.job.name, "mechanic") then TriggerEvent("mechanicKeybindGeneralDelete") end
    end
end, false)

RegisterCommand('+generalX', function()
   TriggerEvent("tgiann-thieff:hands-up")
end, false)



RegisterCommand('-generalTab', function()
    TriggerEvent("inventoryHotBar", false)
    TriggerEvent("tgiannHudMoney", false)
 end, false)