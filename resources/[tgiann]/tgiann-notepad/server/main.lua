QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

QBCore.Functions.CreateUseableItem('notd', function(source)
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)
    exports.oxmysql:execute("SELECT * FROM tgiann_notlar WHERE citizenid = @citizenid", {
        ['@citizenid'] = xPlayer.PlayerData.citizenid
    }, function(result)
        TriggerClientEvent("lkrp_notepad:openNoteMenu", xPlayer.PlayerData.source, result)
    end)
end)

RegisterNetEvent("server:saveNewNote")
AddEventHandler("server:saveNewNote", function(text)
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)
    exports.oxmysql:execute("INSERT INTO tgiann_notlar (citizenid, yazi) VALUES (@citizenid, @yazi)", {
        ['citizenid'] = xPlayer.PlayerData.citizenid, 
        ['yazi'] = text,
    }, function()
        TriggerClientEvent("QBCore:Notify", xPlayer.PlayerData.source, "Yeni Not Kaydedildi")
    end)
end)

RegisterNetEvent("server:saveNote")
AddEventHandler("server:saveNote", function(id, text)
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)
    exports.oxmysql:execute("UPDATE tgiann_notlar SET yazi = @yazi WHERE id = @id", {
        ['id'] = id, 
        ['yazi'] = text,
    }, function()
        TriggerClientEvent("QBCore:Notify", xPlayer.PlayerData.source, "Not Güncellendi")
    end)
end)

RegisterNetEvent("server:deleteNote")
AddEventHandler("server:deleteNote", function(id)
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)
    exports.oxmysql:execute("DELETE FROM tgiann_notlar WHERE id = @id", {
        ['id'] = id, 
    }, function()
        TriggerClientEvent("QBCore:Notify", xPlayer.PlayerData.source, "Not Silindi")
    end)
end)

RegisterNetEvent("server:kopyala")
AddEventHandler("server:kopyala", function(target, text)
    local srcTarget = target
    local tPlayer = QBCore.Functions.GetPlayer(srcTarget)
    if tPlayer then
        exports.oxmysql:execute("INSERT INTO tgiann_notlar (citizenid, yazi) VALUES (@citizenid, @yazi)", {
            ['citizenid'] = tPlayer.PlayerData.citizenid, 
            ['yazi'] = text,
        }, function()
            TriggerClientEvent("QBCore:Notify", tPlayer.PlayerData.source, "The Person Near You Gave You A Note")
        end)
    end
end)