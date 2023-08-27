local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateUseableItem("wheelchair", function(source)
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(source)
    TriggerClientEvent('spawn:wheelchair', source)
end)

RegisterServerEvent('wheelchair:add')
AddEventHandler('wheelchair:add', function()
    local _source = source
    local xPlayer = QBCore.Functions.GetPlayer(_source)
    xPlayer.Functions.AddItem('wheelchair', '1')
end)