QBCore = nil
local coreLoaded = false
Citizen.CreateThread(function()
    while QBCore == nil do
        TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)
        Citizen.Wait(200)
    end
    coreLoaded = true
end)

local washingVehicle = false

RegisterNetEvent('qbshopsKeybindGeneral')
AddEventHandler('qbshopsKeybindGeneral', function()
    local PlayerPed = PlayerPedId()
    if IsPedInAnyVehicle(PlayerPed) and coreLoaded then
        for k, v in pairs(Config.Locations) do
            if GetPedInVehicleSeat(GetVehiclePedIsIn(PlayerPed), -1) == PlayerPed then
                if not washingVehicle then
                    if #(GetEntityCoords(PlayerPed) - vector3(Config.Locations[k]["coords"]["x"], Config.Locations[k]["coords"]["y"], Config.Locations[k]["coords"]["z"])) < 2 then
                        TriggerServerEvent('qb-carwash:server:washCar')
                    end
                end
            end
        end
    end
end)


Citizen.CreateThread(function()
    for k, v in pairs(Config.Locations) do
        exports["elixir-base"]:addNotif("E", 'Wash Vehicle ($'..Config.DefaultPrice..')', 2, 2, vector3(Config.Locations[k]["coords"]["x"], Config.Locations[k]["coords"]["y"], Config.Locations[k]["coords"]["z"]), true)
        -- exports["elixir-base"]:addNotif("E", 'Aracı Yıkat ($'..Config.DefaultPrice..')', 2, 2, vector3(Config.Locations[k]["coords"]["x"], Config.Locations[k]["coords"]["y"], Config.Locations[k]["coords"]["z"]), true)
    end
end)

RegisterNetEvent('qb-carwash:client:washCar')
AddEventHandler('qb-carwash:client:washCar', function()
    local PlayerPed = PlayerPedId()
    local PedVehicle = GetVehiclePedIsIn(PlayerPed)
    local Driver = GetPedInVehicleSeat(PedVehicle, -1)

    washingVehicle = true
    QBCore.Functions.Progressbar("search_cabin", "The vehicle is cleaning", math.random(13500, 18000), false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function() -- Done
        SetVehicleDirtLevel(PedVehicle)
        SetVehicleUndriveable(PedVehicle, false)
        WashDecalsFromVehicle(PedVehicle, 1.0)
        exports["elix1rBase"]:SendAlert("The vehicle was cleaned", "success", 5000)
        washingVehicle = false
    end, function() -- Cancel
        exports["elix1rBase"]:SendAlert("Vehicle Cleaning Process Canceled", "error", 5000)
        washingVehicle = false
    end)
end)