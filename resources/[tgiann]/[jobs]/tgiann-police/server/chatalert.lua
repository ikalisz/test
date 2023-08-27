QBCore = nil

TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

QBCore.Commands.Add("report", "Notifies the authorities.", {{name="message", help="Message"}}, true, function(source, args)
    local message = table.concat(args, " ")
    local Player = QBCore.Functions.GetPlayer(source)
    local Players = QBCore.Functions.GetPlayers()
    TriggerClientEvent("QBCore:Notify", source, "Your message has been sent successfully.")
    for k,v in pairs(Players) do
        if QBCore.Functions.GetPermission(v) ~= "user" then
            TriggerClientEvent('chatMessage', v,"[REPORT] ID: "..source.." | Steam: "..Player.PlayerData.name.. " | Ad Surname: "..Player.PlayerData.charinfo.firstname .. " " .. Player.PlayerData.charinfo.lastname, "normal", message)
        end
    end
end)

QBCore.Commands.Add("911", "Sends a report to the police.", {{name="message", help="Message"}}, true, function(source, args)
    local message = table.concat(args, " ")
    local Player = QBCore.Functions.GetPlayer(source)
    if Player ~= nil then
        TriggerClientEvent("alert:client:SendPolice", source, message)
        --TriggerClientEvent("QBCore:Notify", source, "Mesajınız başarıyla gönderildi.")
    end
end)

QBCore.Commands.Add("911r", "Message back the report", {{name="id", help="ID of the sender of the message"}, {name="mesaj", help="Message"}}, true, function(source, args)
    local Player = QBCore.Functions.GetPlayer(source)
    local OtherPlayer = QBCore.Functions.GetPlayer(tonumber(args[1]))
    table.remove(args, 1)
    local msg = table.concat(args, " ")
    local a = string.upper(Player.PlayerData.job.name)
    if a == "POLICE" then
        if OtherPlayer ~= nil then 
            TriggerClientEvent("alert:client:SendPolicer", source, msg)
            TriggerEvent("InteractSound_SV:PlayWithinDistance", 10,  "emergency", 0.8)
            TriggerClientEvent('chatMessage', OtherPlayer.PlayerData.source, "911r | "..Player.PlayerData.charinfo.firstname.." "..Player.PlayerData.charinfo.lastname, "np911", msg)
        end
    end
end)

QBCore.Commands.Add("311", "Sends a report to the ambulance.", {{name="message", help="Message"}}, true, function(source, args)
    local message = table.concat(args, " ")
    local Player = QBCore.Functions.GetPlayer(source)
    if Player ~= nil then
        TriggerClientEvent("alert:client:SendAmbulancer", source, message)
    end
end)

QBCore.Commands.Add("311r", "Message back the report", {{name="id", help="ID of the sender of the message"}, {name="mesaj", help="Message"}}, true, function(source, args)
    local Player = QBCore.Functions.GetPlayer(source)
    local OtherPlayer = QBCore.Functions.GetPlayer(tonumber(args[1]))
    table.remove(args, 1)
    local msg = table.concat(args, " ")
    local a = string.upper(Player.PlayerData.job.name)
    if a == "AMBULANCE" then
        if OtherPlayer ~= nil then
            TriggerClientEvent("alert:client:SendAmbulance", source, msg)
            TriggerEvent("InteractSound_SV:PlayWithinDistance", 10,  "emergency", 0.8)
            TriggerClientEvent('chatMessage', OtherPlayer.PlayerData.source, "311r | "..Player.PlayerData.charinfo.firstname.." "..Player.PlayerData.charinfo.lastname, "np311", msg)
        end
    end
end)

QBCore.Commands.Add("pd", "Police Occupation Dispatch.", {{name="message", help="Message"}}, true, function(source, args)
    local message = table.concat(args, " ")
    local Player = QBCore.Functions.GetPlayer(source)
    if Player ~= nil then
        TriggerClientEvent("alert:client:SendPoliced", source, message)
    end
end)

RegisterServerEvent('alert:server:SendEmergencyMessage')
AddEventHandler('alert:server:SendEmergencyMessage', function(coords, message, job)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    coords = {x = coords.x, y = coords.y, z = coords.z}
    TriggerClientEvent('alert:client:addAlert', -1, src, Player.PlayerData.charinfo.firstname.." "..Player.PlayerData.charinfo.lastname, coords, message, coords, job)
end)

RegisterServerEvent('alert:server:SendEmergencyMessager')
AddEventHandler('alert:server:SendEmergencyMessager', function(coords, message, job)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    coords = {x = coords.x, y = coords.y, z = coords.z}
    TriggerClientEvent('alert:client:addAlertr', -1, src, Player.PlayerData.charinfo.firstname.." "..Player.PlayerData.charinfo.lastname, coords, message, coords, job)
end)

RegisterServerEvent('alert:server:SendEmergencyMessaged')
AddEventHandler('alert:server:SendEmergencyMessaged', function(coords, message, job)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    coords = {x = coords.x, y = coords.y, z = coords.z}
    TriggerClientEvent('alert:client:addAlertd', -1, src, Player.PlayerData.charinfo.firstname.." "..Player.PlayerData.charinfo.lastname, coords, message, coords, job)
end)

