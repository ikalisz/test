QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

--- Target için
QBCore.Functions.CreateCallback('tgiann-kelepce:target-kelepcelimi', function(source, cb, targetPlayerPed)
    local src = targetPlayerPed
    local xPlayer = QBCore.Functions.GetPlayer(src)
    if xPlayer then
        local data = {
            pkelepce = xPlayer.PlayerData.metadata.pkelepce,
            kelepce = xPlayer.PlayerData.metadata.kelepce,
            isDead = xPlayer.PlayerData.metadata.isdead
        }
        cb(data)
    end
end)

-- QBCore.Commands.Add("taşı", "Kelepçeli Oyuncuyu Taşı", {}, false, function(source, args) -- name, help, arguments, argsrequired,  end sonuna persmission
-- 	TriggerClientEvent('tgiann-kelepce:client:tasi', source)
-- end)

QBCore.Commands.Add("putin", "Embark/Download Injured Player", {}, false, function(source, args) -- name, help, arguments, argsrequired,  end sonuna persmission
	TriggerClientEvent('tgiann-kelepce:client:ybindir', source)
end)

QBCore.Commands.Add("takeout", "Kelepçeli Oyuncuyu Araca Bindir/İndir", {}, false, function(source, args) -- name, help, arguments, argsrequired,  end sonuna persmission
	TriggerClientEvent('tgiann-kelepce:client:arac', source)
end)

QBCore.Commands.Add("cuff", "Handcuffs the Player", {}, false, function(source, args) -- name, help, arguments, argsrequired,  end sonuna persmission
	TriggerClientEvent('tgiann-kelepce:polis-kelepce-tak-client', source)
end)

QBCore.Commands.Add("uncuff", "Uncuffs the Player", {}, false, function(source, args) -- name, help, arguments, argsrequired,  end sonuna persmission
	TriggerClientEvent("tgiann-kelepce:polis-kelepce-coz-client", source)
end)

-- Data Polis Kelepce True
RegisterServerEvent('tgiann-kelepce:polis-kelepce-tak-takilan')
AddEventHandler('tgiann-kelepce:polis-kelepce-tak-takilan', function(targetPlayerPed, playerlocation, playerheading, playerCoords)
    local xPlayer = QBCore.Functions.GetPlayer(targetPlayerPed)
    if xPlayer then
        TriggerClientEvent("tgiann-kelepce:polis-kelepce-tak-yakin-oyuncu-client", targetPlayerPed, playerlocation, playerheading, playerCoords, source)
        xPlayer.Functions.SetMetaData("pkelepce", true)
    end
end)

RegisterServerEvent('tgiann-kelepce:polis-kelepce-tak-takan')
AddEventHandler('tgiann-kelepce:polis-kelepce-tak-takan', function()
    local xPlayer  = QBCore.Functions.GetPlayer(source)
    xPlayer.Functions.RemoveItem('pkelepce', 1, xPlayer.Functions.GetItemByName("pkelepce").slot) -- Kelepçeyi Sil
end)


-- Data Polis Kelepceler False
RegisterServerEvent('tgiann-kelepce:polis-kelepce-coz-takilan')
AddEventHandler('tgiann-kelepce:polis-kelepce-coz-takilan', function(targetPlayerPed, playerlocation, playerheading, playerCoords)
    local xPlayer  = QBCore.Functions.GetPlayer(targetPlayerPed)
    if xPlayer then
        TriggerClientEvent("tgiann-kelepce:polis-kelepce-coz-yakin-oyuncu-client", targetPlayerPed, playerlocation, playerheading, playerCoords)
        xPlayer.Functions.SetMetaData("pkelepce", false)
    end
end)

RegisterServerEvent('tgiann-kelepce:polis-kelepce-coz-takan')
AddEventHandler('tgiann-kelepce:polis-kelepce-coz-takan', function()
    local xPlayer  = QBCore.Functions.GetPlayer(source)
    xPlayer.Functions.AddItem('pkelepce', 1) -- Kelepçeyi Sil
end)


-- İtem Kontrol
QBCore.Functions.CreateCallback('tgiann-kelepce:item-kontrol', function(source, cb, item)
    local xPlayer = QBCore.Functions.GetPlayer(source)
    local items = xPlayer.getInventoryItem(item)
    if items == nil then
        cb(0)
    else
        cb(items.count)
    end
end)

-- Taşıma
RegisterServerEvent('tgiann-kelepce:tasi-target-server')
AddEventHandler('tgiann-kelepce:tasi-target-server', function(targetPlayerPed)
    TriggerClientEvent("tgiann-kelepce:tasi-target-client", targetPlayerPed, source)
end)

RegisterServerEvent('tgiann-kelepce:arac-ici-koy-server')
AddEventHandler('tgiann-kelepce:arac-ici-koy-server', function(targetPlayerPed, type)
    if targetPlayerPed then
        TriggerClientEvent("tgiann-kelepce:arac-ici-koy-client", targetPlayerPed, type)
    end
end)

-- Polis Kelepçe, Polisler Anahtarı item olarak alacakları için anahtar verilmiyor
QBCore.Functions.CreateUseableItem('pkelepce', function(source)
    TriggerClientEvent("tgiann-kelepce:polis-kelepce-tak-client", source)
end)

QBCore.Functions.CreateUseableItem('pkelepceanahtar', function(source)
    TriggerClientEvent("tgiann-kelepce:polis-kelepce-coz-client", source)
end)

RegisterServerEvent('tgiann-kelepce:anim-cancel')
AddEventHandler('tgiann-kelepce:anim-cancel', function(takan, type)
    local xPlayer = QBCore.Functions.GetPlayer(source)
    local tPlayer = QBCore.Functions.GetPlayer(takan)
    if xPlayer then
        TriggerClientEvent("tgiann-kelepce:client:anim-cancel", takan)
        if type == "police" then
            xPlayer.Functions.SetMetaData("pkelepce", false)
            tPlayer.Functions.AddItem('pkelepce', 1) -- kelepçe ver
        else
            xPlayer.Functions.SetMetaData("kelepce", false)
            tPlayer.Functions.AddItem('kelepce', 1) -- kelepçe ver
        end
    end
end)