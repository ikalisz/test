QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

local izinler = {
    ["PUO32188"] = "PQJ63638",
    ["PQJ63638"] = "PUO32188"
}
   
RegisterServerEvent('tgiann-erp:ok')
AddEventHandler('tgiann-erp:ok', function(gonderen)
    local xPlayer = QBCore.Functions.GetPlayer(source)
    local tPlayer = QBCore.Functions.GetPlayer(gonderen)
    izinler[xPlayer.PlayerData.citizenid] = tPlayer.PlayerData.citizenid
    izinler[tPlayer.PlayerData.citizenid] = xPlayer.PlayerData.citizenid
    TriggerClientEvent("QBCore:Notify", gonderen, "Player Accepted E-RP request", "success")
end)

RegisterServerEvent('tgiann-erp:cancel')
AddEventHandler('tgiann-erp:cancel', function(gonderen)
    TriggerClientEvent("QBCore:Notify", gonderen, "Player Denied E-RP Request", "error")
end)

RegisterServerEvent('tgiann-erp:clear-anim')
AddEventHandler('tgiann-erp:clear-anim', function(targetId)
    TriggerClientEvent("tgiann-erp:client:clear-anim", targetId)
end)

QBCore.Commands.Add("erp", "Sends E-RP Permission to Player! commands: /p1 - /p7", {{name="id", help="Player ID"}}, true, function(source, args) -- name, help, arguments, argsrequired,  end sonuna persmission
    local tPlayer = QBCore.Functions.GetPlayer(tonumber(args[1]))
    if tPlayer then 
        local xPlayer = QBCore.Functions.GetPlayer(source) 
        if checkDistance(source, tPlayer.PlayerData.source) then
            if izinler[tPlayer.PlayerData.citizenid] == xPlayer.PlayerData.citizenid then
                TriggerClientEvent("QBCore:Notify", source, "You Already Have E-RP Permission With This Player", "error")
            else
                TriggerClientEvent("tgiann-erp:izin", tPlayer.PlayerData.source, source, xPlayer.PlayerData.charinfo.firstname.. " " ..xPlayer.PlayerData.charinfo.lastname)
                TriggerClientEvent("QBCore:Notify", source, "Request Sent to Player")
            end
        end
    else
        TriggerClientEvent("QBCore:Notify", source, "Player Not Online", "error")
    end
end)

QBCore.Commands.Add("revokeerp", "E-RP Revokes Permission of Granted Player!", {}, false, function(source, args) -- name, help, arguments, argsrequired,  end sonuna persmission
    local xPlayer = QBCore.Functions.GetPlayer(source) 
    local izinVerilen = izinler[xPlayer.PlayerData.citizenid]
    if izinVerilen then
        izinler[xPlayer.PlayerData.citizenid] = nil
        izinler[izinVerilen] = nil
        TriggerClientEvent("QBCore:Notify", source, "You Revoked E-RP Permissions!", "error")
    end
end)

QBCore.Commands.Add("p1", "Position 1(Male)", {}, true, function(source, args) -- name, help, arguments, argsrequired,  end sonuna persmission
    local xPlayer = QBCore.Functions.GetPlayer(source) 
    if izinler[xPlayer.PlayerData.citizenid] then
        local tPlayer = QBCore.Functions.GetPlayerByCitizenId(izinler[xPlayer.PlayerData.citizenid])
        if tPlayer then 
            if checkDistance(source, tPlayer.PlayerData.source) then
                local xPlayer = QBCore.Functions.GetPlayer(source) 
                if izinler[tPlayer.PlayerData.citizenid] == xPlayer.PlayerData.citizenid then
                    TriggerClientEvent("tgiann-erp:animasyon", tPlayer.PlayerData.source, false, false, 15, "rcmpaparazzo_2", "shag_loop_poppy", false, xPlayer.PlayerData.source)
                    TriggerClientEvent("tgiann-erp:animasyon", xPlayer.PlayerData.source, false, false, 15, "rcmpaparazzo_2", "shag_loop_a", true, tPlayer.PlayerData.source, false, -0.18, -0.18)
                else
                    TriggerClientEvent("QBCore:Notify", source, "No E-RP Permission With Player!", "error")
                end
            end
        else
            TriggerClientEvent("QBCore:Notify", source, "Player Not Online", "error")
        end
    else
        TriggerClientEvent("QBCore:Notify", source, "No ERP Permission With Any Player!", "error")
    end
end)

QBCore.Commands.Add("p2", "Position 2(Vehicle)(Male)", {}, false, function(source, args) -- name, help, arguments, argsrequired,  end sonuna persmission
    local xPlayer = QBCore.Functions.GetPlayer(source) 
    if izinler[xPlayer.PlayerData.citizenid] then
        local tPlayer = QBCore.Functions.GetPlayerByCitizenId(izinler[xPlayer.PlayerData.citizenid])
        if tPlayer then 
            if checkDistance(source, tPlayer.PlayerData.source) then
                if izinler[tPlayer.PlayerData.citizenid] == xPlayer.PlayerData.citizenid then
                    TriggerClientEvent("tgiann-erp:animasyon", tPlayer.PlayerData.source, false, false, 1, "misscarsteal2pimpsex", "pimpsex_hooker", false, xPlayer.PlayerData.source)
                    TriggerClientEvent("tgiann-erp:animasyon", xPlayer.PlayerData.source, false, true, 1, "misscarsteal2pimpsex", "pimpsex_punter", true, tPlayer.PlayerData.source, true, 0.60, 0.46)
                else
                    TriggerClientEvent("QBCore:Notify", source, "No E-RP Permission With Player!", "error")
                end
            end
        else
            TriggerClientEvent("QBCore:Notify", source, "Player Not Online", "error")
        end
    else
        TriggerClientEvent("QBCore:Notify", source, "No ERP Permission With Any Player!", "error")
    end
end)

QBCore.Commands.Add("p3", "Position 3 (Male)", {}, false, function(source, args) -- name, help, arguments, argsrequired,  end sonuna persmission
    local xPlayer = QBCore.Functions.GetPlayer(source) 
    if izinler[xPlayer.PlayerData.citizenid] then
        local tPlayer = QBCore.Functions.GetPlayerByCitizenId(izinler[xPlayer.PlayerData.citizenid])
        if tPlayer then 
            if checkDistance(source, tPlayer.PlayerData.source) then
                if izinler[tPlayer.PlayerData.citizenid] == xPlayer.PlayerData.citizenid then
                    TriggerClientEvent("tgiann-erp:animasyon", tPlayer.PlayerData.source, false, false, 1, "misscarsteal2pimpsex", "shagloop_hooker", false, xPlayer.PlayerData.source)
                    TriggerClientEvent("tgiann-erp:animasyon", xPlayer.PlayerData.source, false, false, 1, "misscarsteal2pimpsex", "shagloop_pimp", true, tPlayer.PlayerData.source, true, 0.38, 0.15)
                else
                    TriggerClientEvent("QBCore:Notify", source, "You Don't Have E-RP Permission With Player!", "error")
                end
            end
        else
            TriggerClientEvent("QBCore:Notify", source, "Player Not Online", "error")
        end
    else
        TriggerClientEvent("QBCore:Notify", source, "No ERP Permission With Any Player!", "error")
    end
end)

QBCore.Commands.Add("p4", "Position 4 (Male) (Vehicle)", {}, false, function(source, args) -- name, help, arguments, argsrequired,  end sonuna persmission
    local xPlayer = QBCore.Functions.GetPlayer(source) 
    if izinler[xPlayer.PlayerData.citizenid] then
        local tPlayer = QBCore.Functions.GetPlayerByCitizenId(izinler[xPlayer.PlayerData.citizenid])
        if tPlayer then 
            if checkDistance(source, tPlayer.PlayerData.source) then
                if izinler[tPlayer.PlayerData.citizenid] == xPlayer.PlayerData.citizenid then
                    TriggerClientEvent("tgiann-erp:animasyon", tPlayer.PlayerData.source, true, false, 1, "oddjobs@assassinate@vice@sex", "frontseat_carsex_loop_f", false, xPlayer.PlayerData.source)
                    TriggerClientEvent("tgiann-erp:animasyon", xPlayer.PlayerData.source, true, true, 1, "oddjobs@assassinate@vice@sex", "frontseat_carsex_loop_m", false, tPlayer.PlayerData.source)
                else
                    TriggerClientEvent("QBCore:Notify", source, "No E-RP Permission With Player!", "error")
                end
            end
        else
            TriggerClientEvent("QBCore:Notify", source, "Player Not Online", "error")
        end
    else
        TriggerClientEvent("QBCore:Notify", source, "No ERP Permission With Any Player!", "error")
    end
end)

QBCore.Commands.Add("p5", "Position 5(Male) (Vehicle)", {}, false, function(source, args) -- name, help, arguments, argsrequired,  end sonuna persmission
    local xPlayer = QBCore.Functions.GetPlayer(source) 
    if izinler[xPlayer.PlayerData.citizenid] then
        local tPlayer = QBCore.Functions.GetPlayerByCitizenId(izinler[xPlayer.PlayerData.citizenid])
        if tPlayer then 
            if checkDistance(source, tPlayer.PlayerData.source) then
                if izinler[tPlayer.PlayerData.citizenid] == xPlayer.PlayerData.citizenid then
                    TriggerClientEvent("tgiann-erp:animasyon", tPlayer.PlayerData.source, true, true, 1, "random@drunk_driver_2", "cardrunksex_loop_f", false, xPlayer.PlayerData.source)
                    TriggerClientEvent("tgiann-erp:animasyon", xPlayer.PlayerData.source, true, false, 1, "random@drunk_driver_2", "cardrunksex_loop_m", false, tPlayer.PlayerData.source)
                else
                    TriggerClientEvent("QBCore:Notify", source, "No E-RP Permission With Player!", "error")
                end
            end
        else
            TriggerClientEvent("QBCore:Notify", source, "Player Not Online", "error")
        end
    else
        TriggerClientEvent("QBCore:Notify", source, "No ERP Permission With Any Player!", "error")
    end
end)

QBCore.Commands.Add("p6", "Pozisyon 6(Erkek) (Araç)", {}, true, function(source, args) -- name, help, arguments, argsrequired,  end sonuna persmission
    local xPlayer = QBCore.Functions.GetPlayer(source) 
    if izinler[xPlayer.PlayerData.citizenid] then
        local tPlayer = QBCore.Functions.GetPlayerByCitizenId(izinler[xPlayer.PlayerData.citizenid])
        if tPlayer then 
            if checkDistance(source, tPlayer.PlayerData.source) then
                if izinler[tPlayer.PlayerData.citizenid] == xPlayer.PlayerData.citizenid then
                    TriggerClientEvent("tgiann-erp:animasyon", tPlayer.PlayerData.source, true, false, 32, "mini@prostitutes@sexnorm_veh", "bj_loop_prostitute", false, xPlayer.PlayerData.source)
                    TriggerClientEvent("tgiann-erp:animasyon", xPlayer.PlayerData.source, true, true, 49, "mini@prostitutes@sexnorm_veh", "bj_loop_male", false, tPlayer.PlayerData.source)
                else
                    TriggerClientEvent("QBCore:Notify", source, "No E-RP Permission With Player!", "error")
                end
            end
        else
            TriggerClientEvent("QBCore:Notify", source, "Player Not Online", "error")
        end
    else
        TriggerClientEvent("QBCore:Notify", source, "No ERP Permission With Any Player!", "error")
    end
end)

QBCore.Commands.Add("p7", "Pozisyon 7(Erkek) (Araç)", {}, true, function(source, args) -- name, help, arguments, argsrequired,  end sonuna persmission
    local xPlayer = QBCore.Functions.GetPlayer(source) 
    if izinler[xPlayer.PlayerData.citizenid] then
        local tPlayer = QBCore.Functions.GetPlayerByCitizenId(izinler[xPlayer.PlayerData.citizenid])
        if tPlayer then 
            if checkDistance(source, tPlayer.PlayerData.source) then
                if izinler[tPlayer.PlayerData.citizenid] == xPlayer.PlayerData.citizenid then
                    TriggerClientEvent("tgiann-erp:animasyon", tPlayer.PlayerData.source, true, false, 32, "oddjobs@towing", "f_blow_job_loop", false, xPlayer.PlayerData.source)
                    TriggerClientEvent("tgiann-erp:animasyon", xPlayer.PlayerData.source, true, true, 49, "oddjobs@towing", "m_blow_job_loop", false, tPlayer.PlayerData.source)
                else
                    TriggerClientEvent("QBCore:Notify", source, "No E-RP Permission With Player!", "error")
                end
            end
        else
            TriggerClientEvent("QBCore:Notify", source, "Player Not Online", "error")
        end
    else
        TriggerClientEvent("QBCore:Notify", source, "No ERP Permission With Any Player!", "error")
    end
end)

function checkDistance(player, target)
    local PlayerPos = GetEntityCoords(GetPlayerPed(player))
    local TargetPos = GetEntityCoords(GetPlayerPed(target))
    if #(PlayerPos - TargetPos) < 3 then
        return true
    else
        TriggerClientEvent("QBCore:Notify", player, "Not Near the Player", "error")
        return false
    end
end