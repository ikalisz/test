QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

local depoFiyat = 10000

QBCore.Functions.CreateCallback("tgiann-depo:depolar", function(source, cb)
    exports.oxmysql:execute("SELECT * FROM tgiann_depo", {}, function(result)
        cb(result)
    end)
end)

RegisterServerEvent('tgiann-depo:satin-al')
AddEventHandler('tgiann-depo:satin-al', function(data)
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)
    if xPlayer.Functions.RemoveMoney('bank', depoFiyat) then
        exports.oxmysql:execute("SELECT * FROM tgiann_depo WHERE citizenid = @citizenid", {
            ["@citizenid"] = xPlayer.PlayerData.citizenid
        }, function(result)
            if not result[1] then
                exports.oxmysql:scalar("INSERT INTO tgiann_depo (citizenid, sifre, isim) VALUES (@citizenid, @sifre, @isim)", {
                    ['citizenid'] = xPlayer.PlayerData.citizenid, 
                    ['sifre'] = data.sifre,
                    ['isim'] = data.depoisim,
                }, function()
                    TriggerClientEvent("tgiann-depo:yenile", src)
                    TriggerClientEvent("QBCore:Notify", src, "Depo Purchased for"..depoFiyat.."$!", "success")
                end)
            end
        end)
    else
        TriggerClientEvent("tgiann-depo:yenile", src)
        TriggerClientEvent("QBCore:Notify", src, "You Don't Have Enough Money To Buy The Warehouse!", "error")
    end
end)

RegisterServerEvent('tgiann-depo:sat')
AddEventHandler('tgiann-depo:sat', function(data)
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)
    exports.oxmysql:execute("SELECT * FROM tgiann_depo WHERE citizenid = @citizenid", {
        ["@citizenid"] = xPlayer.PlayerData.citizenid
    }, function(result)
        if result[1] then
            exports.oxmysql:scalar("DELETE FROM tgiann_depo WHERE citizenid = @citizenid", {
                ['@citizenid'] = xPlayer.PlayerData.citizenid,
            }, function()
                local para = depoFiyat*0.5
                xPlayer.Functions.AddMoney('bank', para)
                TriggerClientEvent("QBCore:Notify", src, "Warehouse Sold for "..para.."$!", "success")
                TriggerClientEvent("tgiann-depo:yenile", src)
            end)
        end
    end)
end)

RegisterServerEvent('tgiann-depo:server:setDoorAnim')
AddEventHandler('tgiann-depo:server:setDoorAnim', function(bool)
    TriggerClientEvent("tgiann-depo:client:setDoorAnim", -1, bool)
end)