QBCore = nil
Citizen.CreateThread(function()
    while QBCore == nil do
        TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)
        Citizen.Wait(200)
    end
	PlayerData = QBCore.Functions.GetPlayerData()

end)

RegisterNetEvent('alert:client:SendPolice')
AddEventHandler('alert:client:SendPolice', function(message)
    if not QBCore.Functions.GetPlayerData().metadata["isdead"] then
        QBCore.Functions.Progressbar('name', 'Sending', 1500, false, true, { -- Name | Label | Time | useWhileDead | canCancel
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {
            animDict = 'cellphone@',
            anim = 'cellphone_call_listen_base',
            flags = 16,
        }, {}, {}, function() -- Play When Done
            TriggerServerEvent("alert:server:SendEmergencyMessage", GetEntityCoords(PlayerPedId()), message, "police")
            ClearPedTasks(PlayerPedId())
            -- ClearPedTasksImmediately(PlayerPedId())
        end, function() -- Play When Cancel
            QBCore.Functions.Notify("Transaction Canceled", "error")
        end)
    else
        QBCore.Functions.Notify("You can't send a 911 call when you're dead..", "error")
    end
end)




RegisterNetEvent('alert:client:SendPoliced')
AddEventHandler('alert:client:SendPoliced', function(message)
    if not QBCore.Functions.GetPlayerData().metadata["isdead"] then
        QBCore.Functions.Progressbar('name', 'Sending', 1500, false, true, { -- Name | Label | Time | useWhileDead | canCancel
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {
            animDict = 'cellphone@',
            anim = 'cellphone_call_listen_base',
            flags = 16,
        }, {}, {}, function() -- Play When Done
            TriggerServerEvent("alert:server:SendEmergencyMessaged", GetEntityCoords(PlayerPedId()), message, "police")
            ClearPedTasks(PlayerPedId())
        end, function() -- Play When Cancel
            QBCore.Functions.Notify("Transaction Canceled", "error")
        end)
    else
        QBCore.Functions.Notify("You can't send a 911 call when you're dead..", "error")
    end
end)

RegisterNetEvent('alert:client:SendPolicer')
AddEventHandler('alert:client:SendPolicer', function(message)
    if not QBCore.Functions.GetPlayerData().metadata["isdead"] then
        QBCore.Functions.Progressbar('name', 'Sending', 1500, false, true, { -- Name | Label | Time | useWhileDead | canCancel
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {
            animDict = 'cellphone@',
            anim = 'cellphone_call_listen_base',
            flags = 16,
        }, {}, {}, function() -- Play When Done
            TriggerServerEvent("alert:server:SendEmergencyMessager", GetEntityCoords(PlayerPedId()), message, "police")
            ClearPedTasks(PlayerPedId())
        end, function() -- Play When Cancel
            QBCore.Functions.Notify("Transaction Canceled", "error")
        end)
    else
        QBCore.Functions.Notify("You can't send a 911 call when you're dead..", "error")
    end
end)

RegisterNetEvent('alert:client:SendAmbulancer')
AddEventHandler('alert:client:SendAmbulancer', function(message)
    if not QBCore.Functions.GetPlayerData().metadata["isdead"] then
        QBCore.Functions.Progressbar('name', 'Sending', 1500, false, true, { -- Name | Label | Time | useWhileDead | canCancel
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {
            animDict = 'cellphone@',
            anim = 'cellphone_call_listen_base',
            flags = 16,
        }, {}, {}, function() -- Play When Done
            TriggerServerEvent("alert:server:SendEmergencyMessager", GetEntityCoords(PlayerPedId()), message, "ambulance")
            ClearPedTasks(PlayerPedId())
        end, function() -- Play When Cancel
            QBCore.Functions.Notify("Transaction Canceled", "error")
        end)
    else
        QBCore.Functions.Notify("You can't send a 911 call when you're dead..", "error")
    end
end)

RegisterNetEvent('alert:client:SendAmbulance')
AddEventHandler('alert:client:SendAmbulance', function(message)
    if not QBCore.Functions.GetPlayerData().metadata["isdead"] then
        QBCore.Functions.Progressbar('name', 'Sending', 1500, false, true, { -- Name | Label | Time | useWhileDead | canCancel
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {
            animDict = 'cellphone@',
            anim = 'cellphone_call_listen_base',
            flags = 16,
        }, {}, {}, function() -- Play When Done
            TriggerServerEvent("alert:server:SendEmergencyMessage", GetEntityCoords(PlayerPedId()), message, "ambulance")
            ClearPedTasks(PlayerPedId())
        end, function() -- Play When Cancel
            QBCore.Functions.Notify("Transaction Canceled", "error")
        end)
    else
        QBCore.Functions.Notify("You can't send a 911 call when you're dead..", "error")
    end
end)

RegisterNetEvent('alert:client:addAlertr')
AddEventHandler('alert:client:addAlertr', function(id, isim, konum, msg, coords, job)
    local pData = QBCore.Functions.GetPlayerData()
    prefix = ""
    if job == "police" then
        prefix = "911r"
        color = "pd"
    elseif job == "ambulance" then
        prefix = "311r"
        color = "ems"
    end
    if pData.job.name == job then 
        TriggerEvent('chatMessage', prefix.." | "..isim.." #"..id.."", color, msg)

    if job == "police" then
        local blip911 = AddBlipForCoord(konum.x, konum.y, konum.x)
        SetBlipSprite(blip911, 480)
        SetBlipDisplay(blip911, 2)
        SetBlipScale(blip911, 1.60)
        SetBlipColour(blip911, 75)
        SetBlipAsShortRange(blip911, false)
        SetBlipAlpha(blip911, alpha)
    
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("[911 Notice] - "..msg)
        EndTextCommandSetBlipName(blip911)
    
        local alpha = 200
        while alpha ~= 0 do
            Citizen.Wait(500)
            alpha = alpha - 1
            SetBlipAlpha(blip911, alpha)
    
            if alpha == 0 then
                RemoveBlip(blip911)
                break
            end
        end
    elseif job == "ambulance" then
        local blip311 = AddBlipForCoord(konum.x, konum.y, konum.x)
        SetBlipSprite(blip311, 280)
        SetBlipDisplay(blip311, 2)
        SetBlipScale(blip311, 1.0)
        SetBlipColour(blip311, 44)
        SetBlipAsShortRange(blip311, false)
        SetBlipAlpha(blip311, alpha)
    
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("[311 Notice] - " ..msg)
        EndTextCommandSetBlipName(blip311)
    
        local alpha = 200
        while alpha ~= 0 do
            Citizen.Wait(500)
            alpha = alpha - 1
            SetBlipAlpha(blip311, alpha)
    
            if alpha == 0 then
                RemoveBlip(blip311)
                break
            end
        end
    end
    end
end)

RegisterNetEvent('alert:client:addAlert')
AddEventHandler('alert:client:addAlert', function(id, isim, konum, msg, coords, job)
    local pData = QBCore.Functions.GetPlayerData()
    prefix = ""
    if job == "police" then
        prefix = "911"
        color = "pd"
    elseif job == "ambulance" then
        prefix = "311"
        color = "ems"
    end
    if pData.job.name == job then 
        TriggerEvent('chatMessage', prefix.." | "..isim.." #"..id.."", color, msg)

    if job == "police" then
        local blip911 = AddBlipForCoord(konum.x, konum.y, konum.x)
        SetBlipSprite(blip911, 480)
        SetBlipDisplay(blip911, 2)
        SetBlipScale(blip911, 1.60)
        SetBlipColour(blip911, 75)
        SetBlipAsShortRange(blip911, false)
        SetBlipAlpha(blip911, alpha)
    
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("[911 Notice] - "..msg)
        EndTextCommandSetBlipName(blip911)
    
        local alpha = 200
        while alpha ~= 0 do
            Citizen.Wait(500)
            alpha = alpha - 1
            SetBlipAlpha(blip911, alpha)
    
            if alpha == 0 then
                RemoveBlip(blip911)
                break
            end
        end
    elseif job == "ambulance" then
        local blip311 = AddBlipForCoord(konum.x, konum.y, konum.x)
        SetBlipSprite(blip311, 280)
        SetBlipDisplay(blip311, 2)
        SetBlipScale(blip311, 1.0)
        SetBlipColour(blip311, 44)
        SetBlipAsShortRange(blip311, false)
        SetBlipAlpha(blip311, alpha)
    
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("[311 Notice] - " ..msg)
        EndTextCommandSetBlipName(blip311)
    
        local alpha = 200
        while alpha ~= 0 do
            Citizen.Wait(500)
            alpha = alpha - 1
            SetBlipAlpha(blip311, alpha)
    
            if alpha == 0 then
                RemoveBlip(blip311)
                break
            end
        end
    end
    end
end)

RegisterNetEvent('alert:client:addAlertd')
AddEventHandler('alert:client:addAlertd', function(id, isim, konum, msg, coords, job)
    local pData = QBCore.Functions.GetPlayerData()
    prefix = ""
    if job == "police" then
        prefix = "PD Message"
        color = "pd"
    elseif job == "ambulance" then
        prefix = "EMS Message"
        color = "ems"
    end
    if pData.job.name == job then 
        TriggerEvent('chatMessage', prefix.." | "..isim.." #"..id.."", color, msg)

    if job == "police" then
        local blip911 = AddBlipForCoord(konum.x, konum.y, konum.x)
        SetBlipSprite(blip911, 480)
        SetBlipDisplay(blip911, 2)
        SetBlipScale(blip911, 1.60)
        SetBlipColour(blip911, 75)
        SetBlipAsShortRange(blip911, false)
        SetBlipAlpha(blip911, alpha)
    
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("[911 Notice] - "..msg)
        EndTextCommandSetBlipName(blip911)
    
        local alpha = 200
        while alpha ~= 0 do
            Citizen.Wait(500)
            alpha = alpha - 1
            SetBlipAlpha(blip911, alpha)
    
            if alpha == 0 then
                RemoveBlip(blip911)
                break
            end
        end
    elseif job == "ambulance" then
        local blip311 = AddBlipForCoord(konum.x, konum.y, konum.x)
        SetBlipSprite(blip311, 280)
        SetBlipDisplay(blip311, 2)
        SetBlipScale(blip311, 1.0)
        SetBlipColour(blip311, 44)
        SetBlipAsShortRange(blip311, false)
        SetBlipAlpha(blip311, alpha)
    
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("[311 Notice] - " ..msg)
        EndTextCommandSetBlipName(blip311)
    
        local alpha = 200
        while alpha ~= 0 do
            Citizen.Wait(500)
            alpha = alpha - 1
            SetBlipAlpha(blip311, alpha)
    
            if alpha == 0 then
                RemoveBlip(blip311)
                break
            end
        end
    end
    end
end)
