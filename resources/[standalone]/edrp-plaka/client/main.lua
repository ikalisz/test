QBCore = nil
Citizen.CreateThread(function()
    while QBCore == nil do
        TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)
        Citizen.Wait(200)
    end
end)

local cooldown = false

RegisterNetEvent('edrp-plaka:splaka-tak')
AddEventHandler('edrp-plaka:splaka-tak', function()
    if not cooldown then
        cooldown = true
        local player = PlayerPedId()
        local playerCoords = GetEntityCoords(player)
        local closestVehicle = GetVehiclePedIsIn(player, false)
        local plateNumber = GetVehicleNumberPlateText(closestVehicle)

        if IsPedInAnyVehicle(player, false) then
            local vehSeed = GetEntitySpeed(closestVehicle)
            if vehSeed < 5 then
                local progbar = true
                QBCore.Functions.TriggerCallback('edrp-plaka:plaka-kontrol', function(owned, text)
                    if owned then
                        QBCore.Functions.Progressbar("plaka_degistir", "Plate is Changing", 15000, false, true, { -- p1: menu name, p2: yazı, p3: ölü iken kullan, p4:iptal edilebilir
                            disableMovement = true,
                            disableCarMovement = true,
                            disableMouse = false,
                            disableCombat = true,
                        }, {}, {}, {}, function() -- Done
                            
                            progbar = false
                            local newPlate = exports['esx_vehicleshop']:GeneratePlate()
                            QBCore.Functions.TriggerCallback('edrp-plaka:plaka-tak', function(status)
                                if status then
                                    SetVehicleNumberPlateText(closestVehicle, newPlate)
                                    TriggerEvent("x-hotwire:give-keys", closestVehicle)
                                    QBCore.Functions.Notify('You changed the license plate of the vehicle!')
                                end
                            end, plateNumber, newPlate)
                        end, function() -- Cancel
                            progbar = false
                        end)
                    else
                        progbar = false
                        QBCore.Functions.Notify(text, "error")
                    end
                end, plateNumber)
                while progbar do
                    Citizen.Wait(100)
                end
            else
                QBCore.Functions.Notify('You cannot change the license plate while on the move.!', "error")
            end
        else
            QBCore.Functions.Notify('You cannot change the license plate while outside the vehicle.!', "error")
        end
        Citizen.Wait(5000)
        cooldown = false
    else
        QBCore.Functions.Notify('You Cant Use This Item So Fast!', "error")
    end
end)

RegisterCommand("revertplate", function()
    local player = PlayerPedId()
    local playerCoords = GetEntityCoords(player)
    local closestVehicle = GetVehiclePedIsIn(player, false)
    local splaka = GetVehicleNumberPlateText(closestVehicle)
    if not cooldown then
        cooldown = true
        if IsPedInAnyVehicle(player, false) then
            local vehSeed = GetEntitySpeed(closestVehicle)
            if vehSeed < 5 then
                local progbar = true
                QBCore.Functions.TriggerCallback('edrp-plaka:sahte-plaka-kontrol', function(plaka)
                    if plaka then
                        QBCore.Functions.Progressbar("plaka_degistir", "Plate is Changing", 5000, false, true, { -- p1: menu name, p2: yazı, p3: ölü iken kullan, p4:iptal edilebilir
                            disableMovement = false,
                            disableCarMovement = false,
                            disableMouse = false,
                            disableCombat = true,
                        }, {}, {}, {}, function() -- Done
                            progbar = false
                            SetVehicleNumberPlateText(closestVehicle, plaka)
                            TriggerServerEvent("edrp-plaka:s-plaka-sok", splaka)
                            QBCore.Functions.Notify('Installed the original license plate of the vehicle!')
                        end, function() -- Cancel
                            progbar = false
                        end)
                    else
                        progbar = false
                        QBCore.Functions.Notify('No fake license plate installed in the vehicle!', "error")
                    end
                end, splaka)
                while progbar do
                    Citizen.Wait(100)
                end
            else
                QBCore.Functions.Notify('You cannot change the license plate while on the move.!', "error")
            end
            
        else
            QBCore.Functions.Notify('You cannot remove the fake license plate while outside the vehicle.!', "error")
        end
        Citizen.Wait(5000)
        cooldown = false
    else
        QBCore.Functions.Notify('You Cant Use This Command So Seriously!', "error")
    end
end)