QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)
local plakalar = {}

QBCore.Functions.CreateCallback('edrp-plaka:plaka-kontrol', function(source, cb, plate)
    local xPlayer = QBCore.Functions.GetPlayer(source)
    if xPlayer then  
        if plakalar[plate] then
            cb(false, "Fake License Plate Already Installed in Vehicle")
        else
            cb(true)
        end
    end
end)

QBCore.Functions.CreateUseableItem("splaka", function(source, item)
    TriggerClientEvent("edrp-plaka:splaka-tak", source)
end)

QBCore.Functions.CreateCallback('edrp-plaka:plaka-tak', function(source, cb, plaka, orjinalp)
    local xPlayer = QBCore.Functions.GetPlayer(source)
    if xPlayer.Functions.RemoveItem("splaka", 1) then
        plakalar[orjinalp] = plaka
        cb(true)
    else
        cb(false)
    end
end)

QBCore.Functions.CreateCallback('edrp-plaka:sahte-plaka-kontrol', function(source, cb, plate)
    if plakalar[plate] then 
        cb(plakalar[plate])
    else
        cb(false)
    end
end)

RegisterNetEvent('edrp-plaka:s-plaka-sok')
AddEventHandler('edrp-plaka:s-plaka-sok', function(plaka, orjinalp)
    if plakalar[plate] then 
        plakalar[plate] = nil
    end
end)