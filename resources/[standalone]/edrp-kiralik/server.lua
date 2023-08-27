local Plakalar = {}

QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

QBCore.Functions.CreateCallback("edrp:kira-kontrol", function(source, cb, price)
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)
    if Plakalar[xPlayer.PlayerData.citizenid] then
        TriggerClientEvent("QBCore:Notify", src, "You Already Have a Rental Car!", "error")
        cb(false)
    else
        if xPlayer.Functions.RemoveMoney("bank", price) then
            local plaka = "K"..src
            Plakalar[xPlayer.PlayerData.citizenid] = plaka
            cb(true, plaka)
        else
            TriggerClientEvent("QBCore:Notify", src, "Not Enough Money In The Bank Account!", "error")
            cb(false)
        end
    end
end)

QBCore.Functions.CreateCallback("edrp:aracBirak", function(source, cb, plaka, price)
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)
    if Plakalar[xPlayer.PlayerData.citizenid] then
        if Plakalar[xPlayer.PlayerData.citizenid] == QBCore.Shared.Trim(plaka) then
            xPlayer.Functions.AddMoney('bank', price)
            Plakalar[xPlayer.PlayerData.citizenid] = nil
            cb(true)
        else
            TriggerClientEvent("QBCore:Notify", src, "This Is Not The Vehicle You Rented!", "error")
            cb(false)
        end
    else
        TriggerClientEvent("QBCore:Notify", src, "You Don't Have a Rental Vehicle!", "error")
        cb(false)
    end
end)