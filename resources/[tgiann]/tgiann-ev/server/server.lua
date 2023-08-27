QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

QBCore.Functions.CreateCallback("tgiann-ev:ilg-giris", function(source, cb)
    local xPlayer = QBCore.Functions.GetPlayer(source)
    if xPlayer then
        local evivar, evData = oyuncuEvKontrol(xPlayer.PlayerData.citizenid)
        if evivar then
            cb(evData)
        else
            cb(false)
        end
    else
        cb(nil)
    end
end)

RegisterServerEvent('tgiann-ev:satin-al')
AddEventHandler('tgiann-ev:satin-al', function(evId, para)
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)
    local evivar = oyuncuEvKontrol(xPlayer.PlayerData.citizenid)
    if not evivar then
        local evSatilmis = EvKontrol(evId)
        if not evSatilmis then
            if xPlayer.Functions.RemoveMoney('bank', para) then
                exports.oxmysql:execute("INSERT INTO tgiann_ev (id, anahtar1) VALUES (@evId, @anahtar1)", {
                    ['evId'] = evId, 
                    ['anahtar1'] = xPlayer.PlayerData.citizenid,
                })
                TriggerClientEvent("tgiann-ev:ev-ayarla", src)
                TriggerClientEvent("QBCore:Notify", src, "You Bought the House for "..para.."$!", "success")
            else
                TriggerClientEvent("QBCore:Notify", src, "No "..para.."$ in Bank Account", "error")
            end
        else
            TriggerClientEvent("QBCore:Notify", src, "This House Belongs to Someone Else!", "error")
        end
    else
        TriggerClientEvent("QBCore:Notify", src, "You Already Have a Home!", "error")
    end
end)

RegisterServerEvent('tgiann-ev:sat')
AddEventHandler('tgiann-ev:sat', function(para, evId, key)
    local src = source
    if QBCore.Functions.kickHacKer(src, key) then -- QBCore.Key
        local xPlayer = QBCore.Functions.GetPlayer(src)
        xPlayer.Functions.AddMoney('bank', para)
        TriggerClientEvent("QBCore:Notify", src, "You Sold Your House For "..para.."$")
        exports.oxmysql:scalar("DELETE FROM tgiann_ev WHERE id = @id", {
            ['@id'] = evId
        })
    end
end)

RegisterServerEvent('tgiann-ev:anahtar-degis')
AddEventHandler('tgiann-ev:anahtar-degis', function(evId, key)
    local src = source
    if QBCore.Functions.kickHacKer(src, key) then -- QBCore.Key
        exports.oxmysql:execute("SELECT * FROM tgiann_ev WHERE id = @id", {
            ['@id'] = evId, 
        }, function(result)
            for anahtar, citizenid in pairs(result[1]) do
                if anahtar ~= "anahtar1" and anahtar ~= "id" then
                    local tPlayer = QBCore.Functions.GetPlayerByCitizenId(citizenid)
                    if tPlayer then
                        TriggerClientEvent("tgiann-ev:sifirla", tPlayer.PlayerData.source)
                    end
                end
            end
            exports.oxmysql:scalar("UPDATE tgiann_ev SET anahtar2 = @anahtar, anahtar3 = @anahtar, anahtar4 = @anahtar, anahtar5 = @anahtar WHERE id = @id", {
                ['@id'] = evId, 
                ['@anahtar'] = nil
            })
            TriggerClientEvent("QBCore:Notify", src, "You Changed Your House Key", "success")
        end)
    end
end)

RegisterServerEvent('tgiann-ev:anahtar-ver')
AddEventHandler('tgiann-ev:anahtar-ver', function(target, evId, key)
    local src = source
    local anahtarlar = {"anahtar2","anahtar3","anahtar4","anahtar5"}
    if QBCore.Functions.kickHacKer(src, key) then -- QBCore.Key
        local tPlayer = QBCore.Functions.GetPlayer(target)
        if tPlayer then
            exports.oxmysql:execute("SELECT * FROM tgiann_ev WHERE (anahtar1 = @anahtar OR anahtar2 = @anahtar OR anahtar3 = @anahtar OR anahtar4 = @anahtar OR anahtar5 = @anahtar)", {
                ['@anahtar'] = tPlayer.PlayerData.citizenid
            }, function(result)
                if result[1] then
                    TriggerClientEvent("QBCore:Notify",src, "The Person Already Has a Home!", "error") 
                else
                    exports.oxmysql:execute("SELECT * FROM tgiann_ev WHERE id = @id", {
                        ['@id'] = evId, 
                    }, function(result)
                        local bosAnahtar = false
                        local bosAnahtarNo = 0
                        for i=1, #anahtarlar do
                            local stringAnahtar = tostring(anahtarlar[i])
                            if result[1][stringAnahtar] == nil then
                                bosAnahtar = true
                                bosAnahtarNo = stringAnahtar
                                break
                            end
                        end
                        if not bosAnahtar then
                            TriggerClientEvent("QBCore:Notify", src, "You Can't Give More Keys Because You Give The Key To The House "..#anahtarlar.." To Different Person!", "error")
                        else
                            exports.oxmysql:scalar("UPDATE tgiann_ev SET "..bosAnahtarNo.." = @anahtar WHERE id = @id", {
                                ['@id'] = evId, 
                                ['@anahtar'] = tPlayer.PlayerData.citizenid
                            })
                            TriggerClientEvent("tgiann-ev:sifirla", tPlayer.PlayerData.source)
                            TriggerClientEvent("QBCore:Notify", tPlayer.PlayerData.source, "Someone Near You Gave You The Key To His House")
                            TriggerClientEvent("QBCore:Notify", src, "You Give the Key to the Person Near You", "success")
                        end
                    end)
                end
            end)
        else
            TriggerClientEvent("QBCore:Notify", src, "No One Near!", "error") 
        end
    end
end)

RegisterServerEvent('tgiann-ev:anahtar-birak')
AddEventHandler('tgiann-ev:anahtar-birak', function(evId, anahtar)
    local src = source
    exports.oxmysql:scalar("UPDATE tgiann_ev SET "..anahtar.." = @anahtar WHERE id = @id", {
        ['@id'] = evId, 
        ['@anahtar'] = nil
    }, function()
        TriggerClientEvent("tgiann-ev:ev-ayarla", src)
        TriggerClientEvent("QBCore:Notify", src, "You Left the Key of the House!", "success")
    end)
end)

function oyuncuEvKontrol(citizenid)
    local result = exports.oxmysql:execute("SELECT * FROM tgiann_ev WHERE  (anahtar1 = @citizenid OR anahtar2 = @citizenid OR anahtar3 = @citizenid OR anahtar4 = @citizenid OR anahtar5 = @citizenid)", {
        ['@citizenid'] = citizenid
    })

    if result[1] then
        return true, result[1]
    else
        return false
    end
end

function EvKontrol(id)
    local result = exports.oxmysql:execute("SELECT * FROM tgiann_ev WHERE id = @id", {
        ['@id'] = id
    })

    if result[1] then
        return true
    else
        return false
    end
end