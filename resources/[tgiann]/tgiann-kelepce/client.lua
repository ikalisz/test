local dragStatus, playerData = {}, {}
dragStatus.isDragged = false
local tirman = 0
local poliskelepceledi = false
local oyuncukelepceledi = false
local benkelepceledim = false
local isDead = false
local sistemAktif = true
local tasiyorum = false
QBCore = nil
Citizen.CreateThread(function()
    while QBCore == nil do
        TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)
        Citizen.Wait(200)
    end
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    PlayerData = QBCore.Functions.GetPlayerData()
    oyuncukelepceledi = PlayerData.metadata["kelepce"]
    poliskelepceledi = PlayerData.metadata["pkelepce"]
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload')
AddEventHandler('QBCore:Client:OnPlayerUnload', function()
    PlayerData = {}
    oyuncukelepceledi = false
    poliskelepceledi = false
end)

AddEventHandler('tgiann:playerdead', function(dead)
    isDead = dead
end)

-- Meslek Update
RegisterNetEvent('QBCore:Client:OnJobUpdate')
AddEventHandler('QBCore:Client:OnJobUpdate', function(job)
    PlayerData.job = job
end)

RegisterNetEvent('tigann-kelepce:aktif-pasif')
AddEventHandler('tigann-kelepce:aktif-pasif', function(durum)
    if durum then
        sistemAktif = true
    else
        sistemAktif = false
    end
end)

Citizen.CreateThread(function()
    while QBCore == nil do Citizen.Wait(1) end
    while true do
        local time = 1000
        if poliskelepceledi or oyuncukelepceledi then
            time = 1
            local playerPed = PlayerPedId()
            if not IsPedRagdoll(playerPed) then
                if not IsEntityPlayingAnim(playerPed, 'mp_arresting', 'idle', 3) then   
                    TriggerEvent("disc-inventoryhud:remove-weapon")
                    QBCore.Shared.RequestAnimDict('mp_arresting', function()
                        TaskPlayAnim(playerPed, 'mp_arresting', 'idle', 8.0, 8.0, -1, 49, 0, 0, 0, 0)
                    end)
                end

                if IsPedClimbing(playerPed) then
                    tirman = tirman + 1
                    if tirman > 40 then
                        SetPedToRagdoll(playerPed, 2000, 2000, 0, 0, 0, 0)
                        Citizen.Wait(2000)
                    end
                else
                    tirman = 0
                end
            end
        end 
        Citizen.Wait(time)
    end
end)  


exports("kelepcelimiyim", function()
    if poliskelepceledi or oyuncukelepceledi then
        return true
    end

    return false
end)

Citizen.CreateThread(function()
    while true do
        local time = 1000
        if poliskelepceledi or oyuncukelepceledi then
            time = 1
            local playerPed = PlayerPedId()
            DisablePlayerFiring(playerPed, true)

            DisableControlAction(0,21,true) -- disable sprint
            DisableControlAction(0, 24, true) -- Attack
            DisableControlAction(0, 257, true) -- Attack 2
            DisableControlAction(0, 25, true) -- Aim
            DisableControlAction(0, 263, true) -- Melee Attack 1
            DisableControlAction(0, 37, true) -- Select Weapon

            DisableControlAction(0, 56, true) -- F9
            DisableControlAction(0, 45, true) -- Reload
            DisableControlAction(0, 22, true) -- Jump
            DisableControlAction(0, 44, true) -- Cover

            DisableControlAction(0, 288, true) --F1
            DisableControlAction(0, 289, true) -- F2
            DisableControlAction(0, 170, true) -- F3
            DisableControlAction(0, 167, true) -- F6

            DisableControlAction(0, 26, true) -- Disable looking behind
            DisableControlAction(0, 73, true) -- Disable clearing animation

            DisableControlAction(0, 59, true) -- Disable steering in vehicle
            DisableControlAction(0, 71, true) -- Disable driving forward in vehicle
            DisableControlAction(0, 72, true) -- Disable reversing in vehicle
			DisableControlAction(2, 21, true) -- Disable going stealth

            DisableControlAction(0, 47, true)  -- Disable weapon
            DisableControlAction(0, 264, true) -- Disable melee
            DisableControlAction(0, 257, true) -- Disable melee
            DisableControlAction(0, 140, true) -- Disable melee
            DisableControlAction(0, 141, true) -- Disable melee
            DisableControlAction(0, 142, true) -- Disable melee
            DisableControlAction(0, 143, true) -- Disable melee
            DisableControlAction(0, 75, true)  -- Disable exit vehicle
            DisableControlAction(0, 301, true)  -- Disable exit vehicle
            DisableControlAction(27, 75, true) -- Disable exit vehicle
            DisableControlAction(0, 23, true)
        end
        Citizen.Wait(time)
    end
end)  

-- Polis Kelepçeleme
RegisterNetEvent("tgiann-kelepce:polis-kelepce-tak-client")
AddEventHandler("tgiann-kelepce:polis-kelepce-tak-client", function()
    if sistemAktif then
        QBCore.Functions.TriggerCallback('elixir-base:item-kontrol', function(qtty)
        if qtty >= 1 then
            local closestPlayer, closestDistance = QBCore.Functions.GetClosestPlayer()
                if closestPlayer ~= -1 and closestDistance <= 1.5 then
                    local targetPlayerPed = GetPlayerServerId(closestPlayer)  
                    QBCore.Functions.TriggerCallback('tgiann-kelepce:target-kelepcelimi', function(data)
                        if not data.kelepce and not data.pkelepce then
                            playerPed = PlayerPedId()
                            kordinat()
                            TriggerServerEvent("tgiann-kelepce:polis-kelepce-tak-takilan", targetPlayerPed, playerlocation, playerheading, playerCoords)
                            Citizen.Wait(200)
                            handcuffSound()
                            QBCore.Shared.RequestAnimDict('mp_arrest_paired', function()
                                TaskPlayAnim(playerPed, 'mp_arrest_paired', 'cop_p2_back_right', 8.0, -8,3750, 2, 0, 0, 0, 0) -- Kelepce Takma
                                TriggerServerEvent("tgiann-kelepce:polis-kelepce-tak-takan")
                            end)
                        else
                            QBCore.Functions.Notify('Person Already Handcuffed!')
                        end
                    end, targetPlayerPed)
                else
                    QBCore.Functions.Notify('No One Nearby!')
                end
            else
                QBCore.Functions.Notify('No Handcuffs on You!')
            end 
        end, "pkelepce")
    end
end)



RegisterNetEvent("tgiann-kelepce:polis-kelepce-tak-yakin-oyuncu-client")
AddEventHandler("tgiann-kelepce:polis-kelepce-tak-yakin-oyuncu-client", function(playerlocation, playerheading, playerCoords, takan)
    local playerPed = PlayerPedId()
    TriggerEvent("chat:forceClose")
    konumaldir(playerPed, playerlocation, playerheading, playerCoords)

    Citizen.CreateThread(function()
        QBCore.Shared.RequestAnimDict('mp_arrest_paired', function()
            TaskPlayAnim(PlayerPedId(), 'mp_arrest_paired', 'crook_p2_back_right', 8.0, -8, 5300 , 2, 0, 0, 0, 0) -- Kelepçelenme Anim            
        end)
    end)
    
        Citizen.Wait(4550)
        QBCore.Shared.RequestAnimDict('mp_arresting', function()
            TaskPlayAnim(PlayerPedId(), 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0.0, false, false, false)  -- Eller Arakada Kelepçeli Anim
            poliskelepceledi = true
        end)
        poliskelepceledi = true

end) 

RegisterNetEvent("tgiann-kelepce:client:anim-cancel")
AddEventHandler("tgiann-kelepce:client:anim-cancel", function()
    Citizen.Wait(5300)
    ClearPedTasksImmediately(PlayerPedId())
end)

-- Polis Kelepçe çöz
RegisterNetEvent("tgiann-kelepce:polis-kelepce-coz-client")
AddEventHandler("tgiann-kelepce:polis-kelepce-coz-client", function()
    QBCore.Functions.TriggerCallback('elixir-base:item-kontrol', function(qtty)
        if qtty >= 1 then
            local closestPlayer, closestDistance = QBCore.Functions.GetClosestPlayer()
            if closestPlayer ~= -1 and closestDistance <= 1.5 then
                local targetPlayerPed = GetPlayerServerId(closestPlayer)  
                QBCore.Functions.TriggerCallback('tgiann-kelepce:target-kelepcelimi', function(data)
                    if data.pkelepce then
                        playerPed = PlayerPedId()
                        kordinat()
                        TriggerServerEvent("tgiann-kelepce:polis-kelepce-coz-takilan", targetPlayerPed, playerlocation, playerheading, playerCoords)
                        uncuffSound()
                        QBCore.Shared.RequestAnimDict('mp_arresting', function()
                            TaskPlayAnim(PlayerPedId(), 'mp_arresting', 'a_uncuff', 8.0, -8,-1, 2, 0, 0, 0, 0)
                            TriggerServerEvent("tgiann-kelepce:polis-kelepce-coz-takan")
                            Citizen.Wait(6000)
                            ClearPedTasksImmediately(playerPed)
                        end)
                    elseif data.kelepce then
                        QBCore.Functions.Notify('The Key In Your Hand Is Not of This Cuff!')
                    elseif not data.pkelepce or not data.kelepce then
                        QBCore.Functions.Notify('Person Not Already Handcuffed!')
                    end
                end, targetPlayerPed)
            else
                QBCore.Functions.Notify('No One Near!!')
            end
        else
            QBCore.Functions.Notify('You Have No Key!')
        end 
    end, "pkelepceanahtar")
end)

RegisterNetEvent("tgiann-kelepce:polis-kelepce-coz-yakin-oyuncu-client")
AddEventHandler("tgiann-kelepce:polis-kelepce-coz-yakin-oyuncu-client", function(playerlocation, playerheading, playerCoords)
    local playerPed = PlayerPedId()
    konumaldir(playerPed, playerlocation, playerheading, playerCoords)
    QBCore.Shared.RequestAnimDict('mp_arresting', function()
        TaskPlayAnim(PlayerPedId(), 'mp_arresting', 'b_uncuff', 8.0, -8,-1, 2, 0, 0, 0, 0)
        Citizen.Wait(6000)
        poliskelepceledi = false
        ClearPedTasksImmediately(playerPed)
    end)
end) 

local cooldown = GetGameTimer()
-- Normal Kelepçeleme

-- Normal Kelepçe çöz

exports('tasiyormuyum', function()
    local closestPlayer, closestDistance = QBCore.Functions.GetClosestPlayer()
    if tasiyorum ~= nil then 
        if closestPlayer ~= -1 and closestDistance <= 1.5 then
            local targetPlayerPed = GetPlayerServerId(closestPlayer) 
            -- QBCore.Functions.TriggerCallback('tgiann-kelepce:target-kelepcelimi', function(data)
                -- if data.pkelepce or data.kelepce or data.isDead then
                   tasiyorun = nil
                    -- TriggerServerEvent("tgiann-kelepce:tasi-target-server", targetPlayerPed)
                -- end
            -- end, targetPlayerPed) 
        end 
        return tasiyorum
    end
end)

-- Kelepçeli Oyuncuyu Taşı
RegisterNetEvent("tgiann-kelepce:tasi")
AddEventHandler("tgiann-kelepce:tasi", function()
    if sistemAktif then
        local closestPlayer, closestDistance = QBCore.Functions.GetClosestPlayer()
        if closestPlayer ~= -1 and closestDistance <= 1.5 then
            local targetPlayerPed = GetPlayerServerId(closestPlayer) 
            QBCore.Functions.TriggerCallback('tgiann-kelepce:target-kelepcelimi', function(data)
                if data.pkelepce or data.kelepce or data.isDead then
                    tasiyorum = not tasiyorum
                    TriggerServerEvent("tgiann-kelepce:tasi-target-server", targetPlayerPed)
                end
            end, targetPlayerPed) 
        end  
    end
end)


-- Kelepçeli Oyuncuyu Taşı
RegisterCommand("move", function()
    local closestPlayer, closestDistance = QBCore.Functions.GetClosestPlayer()
    if closestPlayer ~= -1 and closestDistance <= 1.5 then
        local targetPlayerPed = GetPlayerServerId(closestPlayer) 
        tasiyorum = not tasiyorum
        TriggerServerEvent("tgiann-kelepce:tasi-target-server", targetPlayerPed)
        QBCore.Functions.Notify('You move the player, /move or alt + right click to release.', 'info', 7500)
    else
        QBCore.Functions.Notify('No players nearby?.', 'info', 7500)
    end  
end)


RegisterNetEvent('tgiann-kelepce:tasi-target-client')
AddEventHandler('tgiann-kelepce:tasi-target-client', function(copId)
    dragStatus.isDragged = not dragStatus.isDragged
    dragStatus.CopId = copId
    
    local playerPed = PlayerPedId()
    if dragStatus.isDragged then
        targetPed = GetPlayerPed(GetPlayerFromServerId(dragStatus.CopId))

        if not IsPedSittingInAnyVehicle(targetPed) then
            AttachEntityToEntity(playerPed, targetPed, 11816, 0.54, 0.54, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
        else
            dragStatus.isDragged = false
            DetachEntity(playerPed, true, false)
        end

        if IsPedDeadOrDying(targetPed, true) then
            dragStatus.isDragged = false
            DetachEntity(playerPed, true, false)
        end
    else
        DetachEntity(playerPed, true, false)
    end
end)

-- Araç İçine Koyma
RegisterNetEvent("tgiann-kelepce:arac")
AddEventHandler("tgiann-kelepce:arac", function()
    if sistemAktif then
        local closestPlayer, closestDistance = QBCore.Functions.GetClosestPlayer()
        if closestPlayer ~= -1 and closestDistance <= 3.0 then
            local targetPlayerPed = GetPlayerServerId(closestPlayer)
            QBCore.Functions.TriggerCallback('tgiann-kelepce:target-kelepcelimi', function(data)
                if data.pkelepce or data.kelepce then
                    TriggerServerEvent("tgiann-kelepce:arac-ici-koy-server", targetPlayerPed, "normal")
                end
            end, targetPlayerPed) 
        end  
    end
end)


RegisterNetEvent('tgiann-kelepce:arac-ici-koy-client')
AddEventHandler('tgiann-kelepce:arac-ici-koy-client', function(type)
    if (type == "dead" and isDead) or (type == "normal" and not isDead) then
        local playerPed = PlayerPedId()
        local coords = GetEntityCoords(playerPed)
        if not IsPedSittingInAnyVehicle(playerPed) then
            local arac, akordinat = QBCore.Functions.GetClosestVehicle(coords)
            if akordinat < 5 then
                if DoesEntityExist(arac) then
                    local maxSeats, freeSeat = GetVehicleMaxNumberOfPassengers(arac)

                    for i=maxSeats - 1, 0, -1 do
                        if IsVehicleSeatFree(arac, i) then
                            freeSeat = i
                            break
                        end
                    end

                    if freeSeat then
                        TriggerEvent("tgiann-kucak:yaralibindir")
                        TaskWarpPedIntoVehicle(playerPed, arac, freeSeat)
                        dragStatus.isDragged = false
                    end
                end
            end
        else
            ClearPedSecondaryTask(playerPed)
            SetEntityCoords(playerPed, coords.x+2, coords.y, coords.z)

        end
    end
end)

-- Chat Komutları
RegisterNetEvent("tgiann-kelepce:client:tasi")
AddEventHandler("tgiann-kelepce:client:tasi", function()
    TriggerEvent("tgiann-kelepce:tasi")
end) 

RegisterNetEvent("tgiann-kelepce:client:arac")
AddEventHandler("tgiann-kelepce:client:arac", function()
    TriggerEvent("tgiann-kelepce:arac")
end) 

RegisterNetEvent("tgiann-kelepce:client:ybindir")
AddEventHandler("tgiann-kelepce:client:ybindir", function()
    if sistemAktif then
        local playerPed = PlayerPedId()
        if not IsPedInAnyVehicle(playerPed) then
            local closestPlayer, closestDistance = QBCore.Functions.GetClosestPlayer()
            if closestPlayer ~= -1 and closestDistance <= 3.0 then
                ClearPedSecondaryTask(playerPed)
                TriggerServerEvent("tgiann-kelepce:arac-ici-koy-server", GetPlayerServerId(closestPlayer), "dead") 
            end 
        else
          QBCore.Functions.Notify("You cannot perform this operation while in the vehicle.") 
        end
    end
end)

function uncuffSound()
    Citizen.Wait(700)
    TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 1.5, 'uncuff', 1.0)
end

function handcuffSound()
    Citizen.Wait(100)
    TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 1.5, 'handcuff', 1.0)
end

function kordinat()
    playerheading = GetEntityHeading(playerPed)
    playerlocation = GetEntityForwardVector(playerPed)
    playerCoords = GetEntityCoords(playerPed)
end

function konumaldir(playerPed, playerlocation, playerheading, playerCoords)
    SetCurrentPedWeapon(playerPed, `WEAPON_UNARMED`, true) -- unarm player
    local x, y, z = table.unpack(playerCoords + playerlocation * 0.95)
    SetEntityCoords(PlayerPedId(), x, y, z - 1.0)
    SetEntityHeading(PlayerPedId(), playerheading)
end 

Citizen.CreateThread(function()
    while true do
        sleep = 1500

        if tasiyorum then
            sleep = 1

            if IsControlJustReleased(0,47) then
                local closestPlayer, closestDistance = QBCore.Functions.GetClosestPlayer()
                local targetPlayerPed = GetPlayerServerId(closestPlayer) 
                tasiyorum = not tasiyorum
                TriggerServerEvent("tgiann-kelepce:tasi-target-server", targetPlayerPed)
            end

            DisableControlAction(0, 47, true)


        end


        Citizen.Wait(sleep)
    end
end)

exports("isDragged", function()
    return dragStatus.isDragged
end)