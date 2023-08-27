QBCore = exports['qb-core']:GetCoreObject()
onlinePlayers = {}


RegisterServerEvent('disc-showid:add-id')
AddEventHandler('disc-showid:add-id', function()
    local Player = QBCore.Functions.GetPlayer(source)
    local cid = Player.PlayerData.citizenid
    TriggerClientEvent("disc-showid:client:add-id", source, onlinePlayers)
    onlinePlayers[tostring(source)] = cid
    TriggerClientEvent("disc-showid:client:add-id", -1, cid, tostring(source))
end)

AddEventHandler('playerDropped', function(reason)
    onlinePlayers[tostring(source)] = nil
end)

RegisterServerEvent("idbakla", function()
    local src = source
    TriggerClientEvent('QBCore:Notify', src,  "ID : " ..src.. "", "primary", 5000)
end)