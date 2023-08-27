QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

QBCore.Functions.CreateUseableItem('armor', function(source)
    local xPlayer = QBCore.Functions.GetPlayer(source)
    if xPlayer then
        TriggerClientEvent('armor', xPlayer.PlayerData.source)
    end
end)

RegisterNetEvent('delete-item')
AddEventHandler('delete-item', function(item)
    local xPlayer = QBCore.Functions.GetPlayer(source)
    if xPlayer then
        if item == "armor" then
            xPlayer.Functions.RemoveItem(item, 1, xPlayer.Functions.GetItemByName(item).slot)
        end
    end
end)

QBCore.Functions.CreateUseableItem('binoculars', function(source)
    TriggerClientEvent('binoculars', source)
end)

RegisterNetEvent('give-item')
AddEventHandler('give-item', function(item, key)
    if QBCore.Functions.kickHacKer(source, key) then
        local xPlayer = QBCore.Functions.GetPlayer(source)
        if xPlayer then
            if item == "armor" then
                xPlayer.Functions.AddItem(item, 1, xPlayer.Functions.GetItemByName(item).slot)
            end
        end
    end
end)