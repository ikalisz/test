local QBCore = exports['qb-core']:GetCoreObject()



QBCore.Functions.CreateCallback("test:yeet", function(source, cb)
    local steamId = GetPlayerIdentifiers(source)[1]
    local plyChars = {}
    
    MySQL.query('SELECT * FROM players WHERE steam = @steam', {['@steam'] = steamId}, function(result)
        for i = 1, (#result), 1 do
            result[i].charinfo = json.decode(result[i].charinfo)
            result[i].money = json.decode(result[i].money)
            result[i].job = json.decode(result[i].job)
            plyChars[result[i].cid] = result[i]
        end
        cb(plyChars)
    end)
end)


-- Commands

QBCore.Commands.Add("char", "Logout of Character (Admin Only)", {}, false, function(source)
    local src = source
    QBCore.Player.Logout(src)
    TriggerClientEvent('qb-multicharacter:client:chooseChar', src)
end, "admin")

QBCore.Commands.Add("closenui", "Close Multi NUI", {}, false, function(source)
    local src = source
    TriggerClientEvent('qb-multicharacter:client:closeNUI', src)
end)

RegisterServerEvent('qb-multicharacter:server:disconnect')
AddEventHandler('qb-multicharacter:server:disconnect', function()
    local src = source
    DropPlayer(src, "You Log Out of the ElixirFW QB v1.5 Server!")
end)

RegisterServerEvent('qb-multicharacter:server:loadUserData')
AddEventHandler('qb-multicharacter:server:loadUserData', function(cData)
    local src = source
    if QBCore.Player.Login(src, cData.citizenid) then
        QBCore.Commands.Refresh(src)
        TriggerClientEvent('qb-spawn:opennui', src)
        -- qb-spawn event
	end
end)


RegisterServerEvent('qb-multicharacter:server:createCharacter')
AddEventHandler('qb-multicharacter:server:createCharacter', function(data)
    local src = source
    local newData = {}
    local PlayerData = QBCore.Functions.GetPlayer(src)
    local pData = QBCore.Functions.GetPlayer(src)
    newData.cid = data.cid
    newData.charinfo = data
    if QBCore.Player.Login(src, false, newData) then
        QBCore.Commands.Refresh(src)
        TriggerClientEvent("qb-multicharacter:client:closeNUI", src, data.gender)
        TriggerEvent('DiscordBot:ToDiscord', 'karakterlog', "Player Named " ..data.gender.. " Gender ``Character Created``", src)
	end
end)


RegisterNetEvent('qb-multicharacter:server:deleteCharacter', function(citizenid)
    local src = source
    QBCore.Player.DeleteCharacter(src, citizenid)
end)

-- Callbacks

QBCore.Functions.CreateCallback("qb-multicharacter:server:GetUserCharacters", function(source, cb)
    local steamId = GetPlayerIdentifier(source, 0)

    MySQL.query('SELECT * FROM players WHERE steam = @steam', {['@steam'] = steamId}, function(result)
        cb(result)
    end)
end)

QBCore.Functions.CreateCallback("qb-multicharacter:server:GetServerLogs", function(source, cb)
    MySQL.query('SELECT * FROM server_logs', function(result)
        cb(result)
    end)
end)

QBCore.Functions.CreateCallback("qb-multicharacter:server:setupCharacters", function(source, cb)
    local steam = QBCore.Functions.GetIdentifier(source, 'steam')
    local plyChars = {}
    MySQL.query('SELECT * FROM players WHERE steam = ?', {steam}, function(result)
        for i = 1, (#result), 1 do
            result[i].charinfo = json.decode(result[i].charinfo)
            result[i].money = json.decode(result[i].money)
            result[i].job = json.decode(result[i].job)
            plyChars[#plyChars+1] = result[i]
            Citizen.Wait(10)
        end
        cb(plyChars)
        TriggerEvent("girislog")
    end)
end)




--fivem-appearance getSkin event
QBCore.Functions.CreateCallback("qb-multicharacter:server:getSkin", function(source, cb, cid)
    local result = MySQL.query.await('SELECT * FROM players_appearance WHERE citizenid = ?', {cid})
    if result[1] ~= nil then
        cb(result[1].model, result[1].appearance)
    else
        cb(nil)
    end
end)



QBCore.Functions.CreateCallback("ra1derLastCharacter", function(source, cb)
    local steam = QBCore.Functions.GetIdentifier(source, 'steam')
    local numOfChars = 0

    if next(Config.izinlikarakterler) then
        for i, v in pairs(Config.izinlikarakterler) do
            if v.steam == steam then
                numOfChars = v.izinlikarakter
                break
            else 
                numOfChars = 1
            end
        end
    else
        numOfChars = 1
    end
    cb(numOfChars)
end)


RegisterNetEvent("girislog", function()
    local src = source
    local reason = reasons
    if src == nil then return end
    local Name = GetPlayerName(src)
    local Ip = GetPlayerEP(src)
    local discord = nil
    local idedentifier = {}
    local idedentifier = GetPlayerIdentifiers(source) 
    for i=1, #idedentifier do
        if string.find(idedentifier[i], "discord") then
            discord = string.sub(idedentifier[i], 9)
        end
    end
    
    if idedentifier[1] == nil then idedentifier[1] = "Identifier Unknown" end
    if reason == nil then reason = "Why Not Known" end
    if discord == nil then discord = "DC Unknown" end
    if Ip == nil then Ip = "IP Unknown" end
    if Name == nil then Name = "Name Unknown" end
    -- if reason ~= "Reconnecting" and src > 60000 then return false end
    local player = QBCore.Players[src]
    if(src==nil or (player == nil)) then return false end
    -- local gircik = player.PlayerData.metadata.sure
    -- if gircik == nil then gircik = 0 end
    -- QBCore.Players[src].PlayerData.metadata.surefull = QBCore.Players[src].PlayerData.metadata.surefull + gircik
    -- local sure = "**".. gircik .. " / " .. player.PlayerData.metadata.surefull .."** "
    -- QBCore.Debug(GetCurrentResourceName(), 'error', '^7["'..src..'"/"'..Name..'"/"'..Ip..'"/"'..idedentifier[1]..'"]^1 Sunucudan ayrildi! Neden: '..reason)
    TriggerEvent("DiscordBot:ToDiscord", 'giriscikis', '**ID: '..src..'** **Steam Name:** '..Name..' **Steam Hex:** '..idedentifier[1]..'\n**Discord:** <@'.. discord ..'> Login to Server')

    
    player.Functions.Save()
    QBCore.Players[src] = nil
end)
