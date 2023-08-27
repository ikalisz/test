-- local motelDoors = {
--     vector3(-----)
-- }

local motelCoords = vector3(0, 0, 0)
local motelKapi = vector3(266.11, -1007.61, -101.01)
local motelDepo = vector3(261.48, -1002.47, -99.01)
local motelGiysi = vector3(259.68, -1004.05, -99.01)

-- Citizen.CreateThread(function()
--     motelCoords = motelDoors[math.random(1, #motelDoors)] 
--     local blip = AddBlipForCoord(motelCoords)
--     SetBlipSprite(blip, 475)
--     SetBlipDisplay(blip, 4)
--     SetBlipScale(blip, 0.5)
--     SetBlipColour(blip, 23)
--     SetBlipAsShortRange(blip, true)
--     BeginTextCommandSetBlipName("STRING")
--     AddTextComponentString("Motel")
--     EndTextCommandSetBlipName(blip)
-- end)

RegisterCommand("emotel", function() 
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    if #(playerCoords - motelDepo) < 25 then
        TriggerEvent("inventory:client:SetCurrentStash", "KMotel_"..PlayerData.citizenid, QBCore.Key)
        TriggerServerEvent("inventory:server:OpenInventory", "stash", "KMotel_"..PlayerData.citizenid, {
            maxweight = 500000,
            slots = 20,
        })
    end
end)

Citizen.CreateThreadNow(function()
    while true do 
        local time = 1000
        if coreLoaded then
            local playerPed = PlayerPedId()
            local playerCoords = GetEntityCoords(playerPed)
 
            if #(playerCoords - motelDepo) < 25 then
                time = 1
                -- Motel İçi Diğer Oyuncuları GÖrünmez Yapma
                for _, player in ipairs(GetActivePlayers()) do
                    if player ~= PlayerId() and NetworkIsPlayerActive(player) then
                        NetworkFadeInEntity(GetPlayerPed(player), true)
                    end
                end 

                local distance2 = #(playerCoords - motelKapi)
                if distance2 < 20 then
                    DrawMarker(2, motelKapi.x, motelKapi.y, motelKapi.z-0.65, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.4, 0.4, 0.3, 255, 00, 0, 200, false, true, false, false, false, false, false)
                    local yazi = ""
                    if distance2 < 1 then
                        yazi = "[E] "
                        if IsControlJustReleased(0, 38) then
                            DoScreenFadeOut(1000)
                            while not IsScreenFadedOut() do Citizen.Wait(100) end
                            SetEntityCoords(PlayerPedId(), motelCoords.x, motelCoords.y, motelCoords.z-1.0)
                            Citizen.Wait(1000)
                            DoScreenFadeIn(1000)
                        end
                    end
                    QBCore.Functions.DrawText3D(motelKapi.x, motelKapi.y, motelKapi.z-0.35, yazi.."Get out")
                end

                local distance3 = #(playerCoords - motelDepo)
                if distance3 < 20 then
                    DrawMarker(2, motelDepo.x, motelDepo.y, motelDepo.z-0.65, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.4, 0.4, 0.3, 255, 00, 0, 200, false, true, false, false, false, false, false)
                    local yazi = ""
                    if distance3 < 1 then
                        yazi = "[E] "
                        if IsControlJustReleased(0, 38) then
                            TriggerEvent("inventory:client:SetCurrentStash", "motel_"..PlayerData.citizenid, QBCore.Key)
                            TriggerServerEvent("inventory:server:OpenInventory", "stash", "motel_"..PlayerData.citizenid)
                        end
                    end
                    QBCore.Functions.DrawText3D(motelDepo.x, motelDepo.y, motelDepo.z-0.35, yazi.."Depo")
                end

                local distance4 = #(playerCoords - motelGiysi)
                DrawMarker(2, motelGiysi.x, motelGiysi.y, motelGiysi.z-0.65, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.4, 0.4, 0.3, 255, 00, 0, 200, false, true, false, false, false, false, false)
                if distance4 < 3 then
                    local yazi = ""
                    if distance4 < 1 then
                        yazi = "[E] "
                        if IsControlJustReleased(0, 38) then
                            TriggerEvent("qb-clothing:client:openOutfitMenu")
                        end
                    end
                    QBCore.Functions.DrawText3D(motelGiysi.x, motelGiysi.y, motelGiysi.z-0.35, yazi.."Wardrobe")
                end

            else
                local distance = #(playerCoords - motelCoords)
                if distance < 16 then
                    time = 1
                    DrawMarker(2, motelCoords.x, motelCoords.y, motelCoords.z-0.65, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.4, 0.4, 0.3, 255, 00, 0, 200, false, true, false, false, false, false, false)
                    if distance < 3 then
                        local yazi = ""
                        if distance < 1 then
                            yazi = "[E] "
                            if IsControlJustReleased(0, 38) then
                                DoScreenFadeOut(1000)
                                while not IsScreenFadedOut() do Citizen.Wait(100) end
                                SetEntityCoords(PlayerPedId(), motelKapi.x, motelKapi.y, motelKapi.z-1.0)
                                SetEntityHeading(PlayerPedId(), 350.0)
                                Citizen.Wait(1000)
                                local kapiKordinat = vector3(150.83894348145, -1008.3522338867, -98.849998474121)
                                local kapi = GetClosestObjectOfType(kapiKordinat, 3.0, -1663022887, false, false, false)
                                SetEntityHeading(kapi, 180.0)
                                DoScreenFadeIn(1000)
                            end
                        end
                        QBCore.Functions.DrawText3D(motelCoords.x, motelCoords.y, motelCoords.z-0.35, yazi.."Motel")
                    end
                end
            end
        end

        Citizen.Wait(time)
    end
end)

exports("motelRaid", function(citizenid)
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    if #(playerCoords - motelDepo) < 35 then
        QBCore.Functions.Progressbar("motelraid", "Motel Room Wanted", 15000, false, true, { 
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {}, {}, {}, function() -- Done
            TriggerEvent("inventory:client:SetCurrentStash", "motel_"..citizenid, QBCore.Key)
            TriggerServerEvent("inventory:server:OpenInventory", "stash", "motel_"..citizenid)
        end, function() -- Cancel
        end)
        return true
    else
        return false
    end
end)