QBCore = nil
local coreLoaded = false
Citizen.CreateThread(function()
    while QBCore == nil do
        TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)
        Citizen.Wait(200)
    end
    coreLoaded = true
end)

local npcCoord = {
    {
        ped = 0xF9FD068C,
        coord = vector4(360.95, -75.43, 66.19, 247.35),
        name = "Vinewood Rentals",
        carModel = `bison`,
        carSpawn = vector4(367.88018798828, -77.533706665039, 67.349670410156, 250.96),
        price = 500
    },
    {
        ped = 0xF9FD068C,
        coord = vector4(413.66, -632.61, 27.5, 247.35),
        name = "Bus Station Rentals",
        carModel = `glendale`,
        carSpawn = vector4(422.32, -627.5, 28.5, 180.96),
        price = 50
    },
    {
        ped = 0x4A8E5536,
        coord = vector4(-1798.1485595703, -1225.0150146484, 0.5970861911774, 109.0),
        name = "Boat Rental",
        carModel = `dinghy`,
        carSpawn = vector4(-1789.4418945312, -1232.3885498047, -0.007099891547, 240.0),
        price = 500
    },
    {
        ped = 0x2FDE6EB7,
        coord = vector4(-1024.74, -2732.71, 12.756, 39.25),
        name = "Airport Rental",
        carModel = `dilettante`,
        carSpawn = vector4(-1012.89, -2735.09, 12.061, 241.8),
        price = 250
    },
    
}

Citizen.CreateThread(function()
    for i=1, #npcCoord do
        local data = npcCoord[i]
        exports["elixir-base"]:pedcreate("kiralikarac-"..i, data.ped, data.coord.x, data.coord.y, data.coord.z, data.coord.w)

        local blip = AddBlipForCoord(data.coord.x, data.coord.y, data.coord.z)
        SetBlipSprite(blip, 500)
        SetBlipDisplay(blip, 2)
        SetBlipScale (blip, 0.55)
        SetBlipColour(blip, 2)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Vehicle Rental")
        EndTextCommandSetBlipName(blip)
        SetModelAsNoLongerNeeded(Pedhash)
    end
   
    while true do
        local time = 250
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        if coreLoaded then
            for i=1, #npcCoord do
                local data = npcCoord[i]
                local mesafe = #(vector3(data.coord.x, data.coord.y, data.coord.z) - playerCoords)
                local yazi = ""..data.name
                if mesafe < 8 then 
                    time = 1
                    if not IsPedInAnyVehicle(playerPed) then
                        if mesafe < 3 then
                            yazi = "[E] "..data.name
                            if IsControlJustReleased(0, 38) then
                                menuAc(data.carModel, data.carSpawn, data.price)
                            end
                        end
                    else
                        yazi = "[E] Return Your Rental Car!"
                        local Arac = GetVehiclePedIsUsing(playerPed)
                        local Plaka = QBCore.Shared.Trim(GetVehicleNumberPlateText(Arac))
                    
                        if IsControlJustReleased(0, 38) then
                            if string.starts(Plaka, "K") and (string.match(Plaka, "K%d") or string.match(Plaka, "K%d%d") or string.match(Plaka, "K%d%d%d")) then

                                for i=1, GetVehicleModelNumberOfSeats(GetEntityModel(Arac)) do
                                    if i ~= 1 then
                                        if not IsVehicleSeatFree(Arac, i-2) then 
                                            QBCore.Functions.Notify('You Cannot Return the Vehicle While Others Are In The Vehicle')
                                            return
                                        end
                                    end
                                end

                                QBCore.Functions.TriggerCallback("edrp:aracBirak", function(durum)
                                    if durum then
                                        if DoesEntityExist(Arac) then
                                            TaskLeaveVehicle(playerPed, Arac, 0)
                                            while IsPedInVehicle(playerPed, Arac, true) do
                                                Citizen.Wait(0)
                                            end
                                            NetworkFadeOutEntity(Arac, true, true)
                                            Citizen.Wait(100)
                                            QBCore.Functions.DeleteVehicle(Arac)
                                            QBCore.Functions.Notify("You Returned the Vehicle!")
                                        end
                                    end
                                end, Plaka, data.price/2)
                            else
                                QBCore.Functions.Notify("This Vehicle Is Not from Rent!", "error")
                            end

                        end
                    end
                    QBCore.Functions.DrawText3D(data.coord.x, data.coord.y, data.coord.z+2.0, yazi, 0.40)
                end
            end
        end
        Citizen.Wait(time)
    end  
end)

function menuAc(carModel, carSpawn, price)

    QBCore.UI.Menu.Open('default', GetCurrentResourceName(), 'is_araci', {
        title    = "Car Rental Service",
        align    = 'left',
        elements = { 
            {label = "Rent a Car: "..price.."$", value= "kirala"}
        }
    }, function(data, menu)
        if data.current.value == "kirala" then
            menu.close()
            QBCore.Functions.TriggerCallback("edrp:kira-kontrol", function(durum, plaka)
                if durum then
                    local playerPed = PlayerPedId()
                    local playerCoords = GetEntityCoords(playerPed)

                    QBCore.Functions.SpawnVehicle(carModel, function(yourVehicle)
                        local vehicleProps = {}
                        vehicleProps.plate = plaka
                        QBCore.Functions.SetVehicleProperties(yourVehicle, vehicleProps)
                        NetworkFadeInEntity(yourVehicle, true, true)
                        TaskWarpPedIntoVehicle(PlayerPedId(), yourVehicle, -1)
                        SetVehicleHasBeenOwnedByPlayer(yourVehicle, true)
                        local id = NetworkGetNetworkIdFromEntity(yourVehicle)
                        SetNetworkIdCanMigrate(id, true)
                        SetVehicleFuelLevel(yourVehicle, 90.0)
                        DecorSetFloat(yourVehicle, "_FUEL_LEVEL", 90.0)
                        TriggerEvent("x-hotwire:give-keys", yourVehicle)                    
                        QBCore.Functions.Notify("Vehicle Rented!")
                    end, {x=carSpawn.x, y=carSpawn.y, z=carSpawn.z, h=carSpawn.w }, true)

                end
            end, price)
        end
    end, function(data, menu)
        menu.close()      
    end)
end

function string.starts(String,Start)
    return string.sub(String,1,#Start)==Start
end