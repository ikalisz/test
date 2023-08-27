QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

local gerekenMalzemeler = {
    ["sarma_ot"] = {
        ["seviye-1"] = {
            {item = "plastik", miktar = 36}
        },
        ["seviye-2"] = {
            {item = "lowgradefemaleseed", miktar = 36},
            {item = "water", miktar = 36},
            {item = "lowgradefert", miktar = 36},
        }
    },
    ["doping"] = {
        ["seviye-1"] = {
            {item = "cam", miktar = 18}
        },
        ["seviye-2"] = {
            {item = "turtle_soup", miktar = 36},
            {item = "water", miktar = 36}
        }
    },
    ["abc"] = {
        ["seviye-1"] = {
            {item = "asit", miktar = 36},
            {item = "azot", miktar = 36}
        }
    },
    ["money"] = {
        ["seviye-1"] = {
            {item = "madde_x", miktar = 5},
            {item = "ipara", miktar = 50000},
        }
    },
}

Citizen.CreateThread(function()
    exports.oxmysql:execute("SELECT * FROM tgiann_dg", {
    }, function(result)
        if result[1] then
            depoData = json.decode(result[1].depolar)
        else
            exports.oxmysql:execute("INSERT INTO tgiann_dg (depolar) VALUES (@depolar)", {
                ['depolar'] = json.encode(depoData), 
            })
        end
    end)
end)

RegisterServerEvent('tgiann-dg:durum')
AddEventHandler('tgiann-dg:durum', function(girilenDepo)
    TriggerClientEvent("tgiann-dg:depo-guncelle", source, depoData)
end)

RegisterServerEvent('tgiann-dg:satin-al')
AddEventHandler('tgiann-dg:satin-al', function(girilenDepo)
    local xPlayer = QBCore.Functions.GetPlayer(source)
    if xPlayer.Functions.RemoveItem('madde_x', 20) then
        local xPlayer = QBCore.Functions.GetPlayer(source)
        depoData[girilenDepo]["satinAlindi"] = true
        depoData[girilenDepo]["depoSahibi"] = xPlayer.PlayerData.citizenid
        depoData[girilenDepo]["satinAlmaSaati"] = os.time() + 86400 -- depo kaç saniye sonra sıfırlancak (orjinal 24 saat [86400])
        depolariKaydet()
    else
        TriggerClientEvent("QBCore:Notify", source, "20x Items None!", "error")
    end
end)

QBCore.Functions.CreateCallback("tgiann-dg:malzeme-kontrol", function(source, cb, tip, seviye, girilenDepo)
    local malzemeVar = false
    local xPlayer = QBCore.Functions.GetPlayer(source)
    local gerekenMalzemleSayisi = #gerekenMalzemeler[tip][seviye]
    local olanMalzeme = 0
    for tip, data in pairs(gerekenMalzemeler[tip][seviye]) do
        local item = xPlayer.Functions.GetItemByName(data.item)
        if item.amount >= data.miktar then
            olanMalzeme = olanMalzeme + 1
            if olanMalzeme == gerekenMalzemleSayisi then
                malzemeVar = true
            end
        else
            TriggerClientEvent("QBCore:Notify", source, "This Transaction requires "..data.miktar.." Grain "..QBCore.Shared.Items[data.item].label.."!", "error")
        end
    end

    if malzemeVar then
        for tip, data in pairs(gerekenMalzemeler[tip][seviye]) do -- Var Olan Malzemeleri Silme
            xPlayer.Functions.RemoveItem(data.item, data.miktar)
        end

        depoData[girilenDepo]["tip"] = tip
        depoData[girilenDepo]["seviye"] = seviye

        if tip == "sarma_ot" or tip == "doping" then
            if seviye == "seviye-2" then
                depoData[girilenDepo]["buyume-aktif"] = true
                depoData[girilenDepo]["buyume-seviye"] = 1
            end
        elseif tip == "abc" or tip =="money" then
            if seviye == "seviye-1" then
                depoData[girilenDepo]["buyume-aktif"] = true
                depoData[girilenDepo]["buyume-seviye"] = 1
            end
        end

        depolariKaydet()
        cb(true)
    else
        cb(false)
    end
end)

local buyut = false
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1800000) -- 30 dakikada bir
        local guncelle = false
        for depo, data in pairs(depoData) do
            if data["buyume-aktif"] then
                if data["tip"] == "sarma_ot" and data["buyume-seviye"] < 10 then
                    guncelle = true
                    data["buyume-seviye"] = data["buyume-seviye"] + 1
                end

                if data["tip"] == "doping" and data["buyume-seviye"] < 10 then
                    guncelle = true
                    data["buyume-seviye"] = data["buyume-seviye"] + 1
                end

                if data["tip"] == "abc" and data["buyume-seviye"] < 6 then
                    guncelle = true
                    data["buyume-seviye"] = data["buyume-seviye"] + 1
                end

                if data["tip"] == "money" and data["buyume-seviye"] < 4 then
                    guncelle = true
                    data["buyume-seviye"] = data["buyume-seviye"] + 1
                end
            end

            if data["satinAlmaSaati"] ~= 0 then
                if os.time() > data["satinAlmaSaati"] then
                    depoData[depo]["satinAlindi"] = false
                    depoData[depo]["satinAlmaSaati"] = 0
                    depoData[depo]["depoSahibi"] = ""
                    depoSifirla(depo)
                end
            end
        end
        if guncelle then
            depolariKaydet()
        end
    end
end)

RegisterServerEvent('tgiann-dg:son-asama')
AddEventHandler('tgiann-dg:son-asama', function(durum, girilenDepo)
    if durum == "topla" then
        local xPlayer = QBCore.Functions.GetPlayer(source)
        if depoData[girilenDepo]["tip"] == "sarma_ot" then -- sarma_ot işlemi bitince verilecek eşyalar
            xPlayer.Functions.AddItem("sarma_ot", 36)
        elseif depoData[girilenDepo]["tip"] == "doping" then -- doping işlemi bitince verilecek eşyalar
            xPlayer.Functions.AddItem("shark_doping", 36)
        elseif depoData[girilenDepo]["tip"] == "abc" then -- abc işlemi bitince verilecek eşyalar
            xPlayer.Functions.AddItem("abc", 36)
        elseif depoData[girilenDepo]["tip"] == "money" then -- money işlemi bitince verilecek eşyalar
            xPlayer.Functions.AddMoney('cash', math.random(40000,45000))
        end
    end
    depoSifirla(girilenDepo)
end)

function depoSifirla(girilenDepo)
    depoData[girilenDepo]["tip"] = ""
    depoData[girilenDepo]["seviye"] = ""
    depoData[girilenDepo]["buyume-aktif"] = false
    depoData[girilenDepo]["buyume-seviye"] = 1
    depolariKaydet()
end

function depolariKaydet()
    TriggerClientEvent("tgiann-dg:depo-guncelle", -1, depoData)
    exports.oxmysql:scalar("UPDATE tgiann_dg SET depolar = @depolar", {
        ['@depolar'] = json.encode(depoData), 
    })
end