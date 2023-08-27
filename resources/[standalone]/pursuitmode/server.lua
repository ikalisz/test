local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('nitrous:server:SyncPurge', function(veh, status)
    TriggerClientEvent('nitrous:client:SyncPurge', -1, veh, status, source)
end)