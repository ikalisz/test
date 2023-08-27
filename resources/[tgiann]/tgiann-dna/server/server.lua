QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

local dnalar = {}

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(2200000)
        for i=1, #dnalar do
            if dnalar[i] then
                if os.time() - dnalar[i]["data"]["saat"] > 1800 then
                    table.remove(dnalar, i)
                end
            end
        end
    end
end)

RegisterServerEvent("tgiann-dna:dna-ekle")
AddEventHandler("tgiann-dna:dna-ekle", function(dna)
    dna["data"]["saat"] = os.time()
	table.insert(dnalar, dna)
end)

RegisterServerEvent("tgiann-dna:dna-sil")
AddEventHandler("tgiann-dna:dna-sil", function(id)
    if dnalar[id] then
        table.remove(dnalar, id)
    end
end)

RegisterServerEvent("tgiann-dna:dna-topla")
AddEventHandler("tgiann-dna:dna-topla", function(id)
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)
    if dnalar[id] then
        if xPlayer then
            xPlayer.Functions.AddItem("dna", 1)
        end
    else
        TriggerClientEvent("QBCore:Notify", "Failed to Collect the DNA", "error")
    end
end)

RegisterServerEvent("tgiann-dna:bozuk-delil-sil")
AddEventHandler("tgiann-dna:bozuk-delil-sil", function()
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)
    if xPlayer then
       xPlayer.Functions.RemoveItem("dna", xPlayer.Functions.GetItemByName("dna").amount, xPlayer.Functions.GetItemByName("dna").slot)
    end
end)    


RegisterServerEvent("tgiann-dna:basarisiz-delil-sil")
AddEventHandler("tgiann-dna:basarisiz-delil-sil", function()
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)
    if xPlayer then
       xPlayer.Functions.RemoveItem("dna", 1, xPlayer.Functions.GetItemByName("dna").slot)
    end
end)

RegisterServerEvent("tgiann-dna:delil-sil")
AddEventHandler("tgiann-dna:delil-sil", function(dna)
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)
    if xPlayer then
       xPlayer.Functions.RemoveItem("dna", 1, xPlayer.Functions.GetItemByName("dna").slot)
    end
    if string.sub(dna["id"], 1, 1) == "P" then
        exports.oxmysql:execute("SELECT * FROM players WHERE citizenid = @citizenid", {
            ['@citizenid'] = dna["id"]
        }, function(result)
            if result[1] then
                local isim = result[1].firstname .. " " .. result[1].lastname
                exports.oxmysql:execute("INSERT INTO tgiann_dna (tip, isim, rastgeleid) VALUES (@tip, @isim, @rastgeleid)", {
                    ["@tip"] = dna["tip"],
                    ["@isim"] = isim,
                    ["@rastgeleid"] = dna["rastgeleid"],
                })
            end
        end)
    else
        exports.oxmysql:execute("INSERT INTO tgiann_dna (tip, isim, rastgeleid) VALUES (@tip, @isim, @rastgeleid)", {
            ["@tip"] = dna["tip"],
            ["@isim"] = dna["id"],
            ["@rastgeleid"] = dna["rastgeleid"],
        })
    end
end)

QBCore.Functions.CreateCallback('tgiann-dna:cek', function(source, cb)
    exports.oxmysql:execute("SELECT * FROM tgiann_dna ORDER BY id DESC LIMIT 25", {
    }, function(result)
        cb(result)
    end)
end)

QBCore.Functions.CreateCallback('tgiann-dna:ilk-bilgi', function(source, cb)
    cb(dnalar)
end)

QBCore.Functions.CreateUseableItem("dna", function(source)
	TriggerClientEvent("tgiann-dna:dna-menu", source)
end)