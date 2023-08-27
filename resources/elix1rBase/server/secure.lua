-- QBCore = nil

-- TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

-- -- secure komutu
-- local secure = false

-- QBCore.Functions.CreateCallback("tgiann:check:secure", function(source, cb)
--     cb(secure)
-- end)

-- RegisterCommand("secure", function(source)
-- local xPlayer = QBCore.Functions.GetPlayer(source)
--     -- if xPlayer.PlayerData.job.boss or if PlayerData.job.grade >= 6 then 
--       if xPlayer.PlayerData.job.boss and xPlayer.PlayerData.job.grade >= 6 then
--         if secure then
--             secure = false
--             TriggerClientEvent("QBCore:Notify", xPlayer.PlayerData.source, 'Güvenlik sistemlerini devre dışı.', "error")
--             TriggerClientEvent("tgiann:secure:client:setSecureStatus", -1, false)
--         else
--             secure = true
--             TriggerClientEvent("QBCore:Notify", xPlayer.PlayerData.source, 'Güvenlik sistemlerini aktif.', "success")
--             TriggerClientEvent("tgiann:secure:client:setSecureStatus", -1, true)
--             Citizen.CreateThread(function()
--                 while true do
--                     secure = true
--                     TriggerClientEvent("QBCore:Notify", xPlayer.PlayerData.source, 'Güvenlik Sistemleri Devrede.', "success", 5000)
--                     Citizen.Wait(20000)
--                 end
--             end)
--         end
--     end
-- end)


QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

-- secure komutu
local secure = false

QBCore.Functions.CreateCallback("tqcore:check:secure", function(source, cb)
    cb(secure)
end)

RegisterCommand("secure", function(source)
    local xPlayer = QBCore.Functions.GetPlayer(source)
    if xPlayer.PlayerData.job.name == "police" and xPlayer.PlayerData.job.grade >= 7 then
        if secure then
            secure = false
            TriggerClientEvent("QBCore:Notify", xPlayer.PlayerData.source, 'You turned off the security systems.', "error")
            TriggerClientEvent("tqcore:secure:client:setSecureStatus", -1, false)
        else
            secure = true
            TriggerClientEvent("QBCore:Notify", xPlayer.PlayerData.source, 'You turned on the security systems.', "success")
            TriggerClientEvent("tqcore:secure:client:setSecureStatus", -1, true)
        end
    else
        if secure == true then
            TriggerClientEvent("QBCore:Notify", xPlayer.PlayerData.source, 'Security systems off.')
        else
            TriggerClientEvent("QBCore:Notify", xPlayer.PlayerData.source, 'Security systems on.')
        end
    end
end, false)





