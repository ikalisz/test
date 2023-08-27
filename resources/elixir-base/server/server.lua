local testPolice = false
local npcOn = true
local sifirPolis = false

QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

QBCore.Commands.Add("clear", "Chat Geçmişini Temizle", {}, false, function(source, args) -- name, help, arguments, argsrequired,  end sonuna persmission
	TriggerClientEvent('chat:clear', source)
end)

RegisterServerEvent('elixir-base:mesaj')
AddEventHandler('elixir-base:mesaj', function()
    local src = source
    local identifier = GetPlayerIdentifiers(src)[1]
    local nick = GetPlayerName(src)
    TriggerEvent('DiscordBot:ToDiscord', 'hile', '@here ```Nick: ('.. nick .. ') Steam İd: (' .. identifier .. ') Muhtemel Dumpcı```')
    DropPlayer(src, "Your ping is too high :)") 
end)

QBCore.Commands.Add("giveadmin", "Give a player admin or god privileges.", {{name="id", help="Player ID"}, {name="permission", help="Permission level"}}, true, function(source, args)
	local Player = QBCore.Functions.GetPlayer(tonumber(args[1]))
	local permission = tostring(args[2]):lower()
	if Player ~= nil then
		QBCore.Functions.AddPermission(Player.PlayerData.source, permission)
		TriggerEvent('DiscordBot:ToDiscord', 'adminlog', '/giveadmin '..permission, source, Player.PlayerData.source)
	else
		TriggerClientEvent('QBCore:Notify', source, "Player Not Online", "error")
	end
end, "admin")

QBCore.Functions.CreateCallback('elixir-base:removeItem', function(source, cb, item, amount)
	local src = source
	local xPlayer = QBCore.Functions.GetPlayer(src)
	if xPlayer.Functions.RemoveItem(item, amount) then
        cb(true)
    else
        cb(false)
    end
end)

RegisterServerEvent('elixir-base:event:removeItem')
AddEventHandler('elixir-base:event:removeItem', function(item, amount)
    local src = source
	local xPlayer = QBCore.Functions.GetPlayer(src)
	xPlayer.Functions.RemoveItem(item, amount)
end)

QBCore.Functions.CreateCallback('elixir-base:xplayer-kullanici-bilgi', function(source, cb, id)
    local xPlayer = QBCore.Functions.GetPlayer(id)
    if xPlayer then
        local data = {
            firstname = xPlayer.PlayerData.charinfo.firstname,
            lastname = xPlayer.PlayerData.charinfo.lastname,
            kelepce = xPlayer.PlayerData.metadata.kelepce,
            pkelepce = xPlayer.PlayerData.metadata.pkelepce,
            is_dead = xPlayer.PlayerData.metadata.isdead,
            job = xPlayer.PlayerData.job.name,
            onduty = xPlayer.PlayerData.job.onduty,
        }
        cb(data)
    end
end) 

RegisterServerEvent('elixir-base:ana-siken')
AddEventHandler('elixir-base:ana-siken', function()
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(source)
    if not xPlayer then return; end
    local idedentifier = GetPlayerIdentifiers(src)
    local discord = nil
    for i=1, #idedentifier do
        if string.find(idedentifier[i], "discord") then
            discord = string.sub(idedentifier[i], 9)
        end
    end
	exports.oxmysql:execute('UPDATE whitelist SET songiris = @songiris, discord = @discord WHERE identifier = @identifier', {
        ['@songiris'] = os.date("%d-%m-%Y"),
        ['@identifier'] = xPlayer.PlayerData.steam,
        ['@discord'] = discord
	})
end)

-- Polis Sayısı
--QBCore.Functions.TriggerCallback('elixir-base:polis-sayi', function(AktifPolis)
QBCore.Functions.CreateCallback('elixir-base:polis-sayi', function(source, cb)
    if sifirPolis then
        cb(0)
    elseif testPolice then
        cb(100)
    else
        cb(getJobCount("police"))
    end
end)

-- EMS Sayısı
--QBCore.Functions.TriggerCallback('elixir-base:ems-sayi', function(AktifEMS)
QBCore.Functions.CreateCallback('elixir-base:ems-sayi', function(source, cb)
    cb(getJobCount("ambulance"))
end)

QBCore.Functions.CreateCallback('elixir-base:burger-sayi', function(source, cb)
    cb(getJobCount("burger"))
end)

-- Mekanik Sayısı
--QBCore.Functions.TriggerCallback('elixir-base:mekanik-sayi', function(AktifMekanik)
QBCore.Functions.CreateCallback('elixir-base:mekanik-sayi', function(source, cb)
    cb(getJobCount("mechanic"))
end)

-- Geleri Sayısı
--QBCore.Functions.TriggerCallback('elixir-base:mekanikb-sayi', function(AktifMekanikB)
QBCore.Functions.CreateCallback('elixir-base:galeri-sayi', function(source, cb)
    cb(getJobCount("cardealer"))
end)

QBCore.Functions.CreateCallback('elixir-base:ems-police-sayi', function(source, cb)
    local policeC = getJobCount("police")
    local emsC = getJobCount("ambulance")
    cb(emsC+policeC)
end)

function getJobCount(jobName)
    local sayi = 0
    local xPlayers = QBCore.Functions.GetPlayers()
	for i=1, #xPlayers, 1 do
        local xPlayer = QBCore.Functions.GetPlayer(xPlayers[i])
        if jobName == "mechanic" then
            if xPlayer.PlayerData.job.onduty and (xPlayer.PlayerData.job.name == "mechanic" or xPlayer.PlayerData.job.name == "mechanic_illegal1" or xPlayer.PlayerData.job.name == "mechanic_illegal2" or xPlayer.PlayerData.job.name == "mechanic_hayes" or xPlayer.PlayerData.job.name == "mechanic_bennys") then
                sayi = sayi + 1
            end
        else
            if xPlayer.PlayerData.job.name == jobName and xPlayer.PlayerData.job.onduty then
                sayi = sayi + 1
            end
        end
    end
    return sayi
end

--[[İtem Sayısı Kontrol
QBCore.Functions.TriggerCallback('elixir-base:item-kontrol', function(qtty)
    if qtty > 0 then
    end
end, item)]]
QBCore.Functions.CreateCallback('elixir-base:item-kontrol', function(source, cb, item)
    local xPlayer = QBCore.Functions.GetPlayer(source)
    if xPlayer then  
        local items = xPlayer.Functions.GetItemByName(item)
        if items == nil then
            cb(0)
        else
            cb(items.amount)
        end
    end
end)

RegisterServerEvent("elixir-base:KullanciPara")
AddEventHandler("elixir-base:KullanciPara", function(key, durum, nere, miktar)
    if QBCore.Functions.kickHacKer(source, key) then -- QBCore.Key

        local xPlayer = QBCore.Functions.GetPlayer(source)
        if not xPlayer then return; end

        if durum == "ekle" then
            TriggerEvent('DiscordBot:ToDiscord', 'eventpara', 'elixir-base paraver ' .. durum.. ' ' .. nere ..' '.. miktar, source)
            if nere == "üst" then
                xPlayer.Functions.AddMoney('cash', miktar)
            elseif nere == "banka" then
                xPlayer.Functions.AddMoney('bank', miktar)
            end
        elseif durum == "sil" then
            if nere == "üst" then
                xPlayer.Functions.RemoveMoney('cash', miktar)
            elseif nere == "banka" then
                xPlayer.Functions.RemoveMoney('bank', miktar)
            end
        end
    end

end)

QBCore.Commands.Add("adminpolice", "Increases or Decreases the Number of Test Cops", {}, false, function(source, args)
    testPolice = not testPolice
	TriggerClientEvent('chatMessage', source, "SYSTEM", "primary", "Police Test: ".. tostring(testPolice))
end, "god")

QBCore.Commands.Add("police", "Removes All Cops from Working Hours or Puts them Back on Duty", {}, false, function(source, args)
--[[     local xPlayer = QBCore.Functions.GetPlayer(source)
    if xPlayer.PlayerData.job.name == "police" and xPlayer.PlayerData.job.boss then ]]
        if not sifirPolis then
            sifirPolis = true
            TriggerClientEvent('chatMessage', source, "SYSTEM", "primary", "All cops have been fired!")
        else
            sifirPolis = false
            TriggerClientEvent('chatMessage', source, "SYSTEM", "primary", "Active cops are back in work!")
        end
--[[     else
        TriggerClientEvent('chatMessage', source, "SYSTEM", "error", "Bu Komutu Kullanamazsın!")
    end ]]
end, "god")

QBCore.Commands.Add("npc", "Turns NPCs on and off", {}, false, function(source, args)
    npcOn = not npcOn
    TriggerClientEvent("set-npc", -1, npcOn)
    if npcOn then 
        TriggerClientEvent('chatMessage', -1, "SYSTEM", "primary", "The ban that restricts local citizens from traveling with their vehicles has been lifted!")
    else
        TriggerClientEvent('chatMessage', -1, "SYSTEM", "primary", "Local citizens are prohibited from driving around until further notice!")
    end
end, "god")

QBCore.Functions.CreateCallback('check-npc-on', function(source, cb)
	cb(npcOn)
end)

local soygunTime = 0
local soygunCoolDown = 1

exports('soygunKontrol', function(src)
    if (os.time() - soygunTime) < soygunCoolDown and soygunTime ~= 0 then
        TriggerClientEvent("QBCore:Notify", src, "There Is A Heist In The City Now! Try Again Later!", "error")
        return false
    else
        soygunTime = os.time()
        return true
    end
end)

exports('soygunSureKontrol', function(src)
    if (os.time() - soygunTime) < soygunCoolDown and soygunTime ~= 0 then
        TriggerClientEvent("QBCore:Notify", src, "There Is A Heist In The City Now! Try Again Later!", "error")
        return false
    end
    return true
end)

exports('soygunKontrolSureAyarla', function(src)
    soygunTime = os.time()
end)

exports('soygunKontrolReset', function()
    soygunTime = 0
end)

RegisterServerEvent("elixir-base:soygunKontrolReset")
AddEventHandler("elixir-base:soygunKontrolReset", function(key)
    -- if QBCore.Functions.kickHacKer(source, key) then
        soygunTime = 0
    -- end
end)

QBCore.Functions.CreateCallback('elixir-base:araclarim', function(source, cb)
    local xPlayer = QBCore.Functions.GetPlayer(source)
    if xPlayer then
        exports.oxmysql:execute('SELECT * FROM owned_vehicles WHERE citizenid = @citizenid', {
            ['@citizenid'] = xPlayer.PlayerData.citizenid,
        }, function(data)
            cb(data)
        end)
    end
end)

RegisterServerEvent('wipeKick')
AddEventHandler('wipeKick', function(data)
    local src = source
    TriggerEvent('DiscordBot:ToDiscord', 'hile', 'Wipe Escaped Out of Spawn Area!', src)
    DropPlayer(src, "Where Are You Going, Come And We'll Have More Tea!")
end)