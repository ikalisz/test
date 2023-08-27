local QBCore = exports['qb-core']:GetCoreObject()
local VehicleNitrous = {}

QBCore.Functions.CreateUseableItem("nos", function(source, item)
    TriggerClientEvent('qb-nitrous:client:LoadNitrous', source)
end)

RegisterServerEvent("nitrous:delete", function(item)
    local xPlayer = QBCore.Functions.GetPlayer(source)
    xPlayer.Functions.RemoveItem("nos", 1)
end)

RegisterServerEvent("nitrous:emptynitrous", function(item)
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(source)
    Wait(3000)
    xPlayer.Functions.AddItem("bos_tup", 1)
    TriggerClientEvent('QBCore:Notify', src, "Tube Left in Hand", "primary")
end)

RegisterNetEvent('nitrous:server:LoadNitrous', function(Plate)
    VehicleNitrous[Plate] = {
        hasnitro = true,
        level = 100,
    }
    TriggerClientEvent('nitrous:client:LoadNitrous', -1, Plate)
end)

RegisterNetEvent('nitrous:server:SyncFlames', function(netId, source, status)
    TriggerClientEvent('nitrous:client:SyncFlames', -1, netId, source, status)
end)

RegisterNetEvent('nitrous:server:UnloadNitrous', function(Plate)
    VehicleNitrous[Plate] = nil
    TriggerClientEvent('nitrous:client:UnloadNitrous', -1, Plate)
end)

RegisterNetEvent('nitrous:server:UpdateNitroLevel', function(Plate, level)
    VehicleNitrous[Plate].level = level
    TriggerClientEvent('nitrous:client:UpdateNitroLevel', -1, Plate, level)
end)

RegisterNetEvent('nitrous:server:StopSync', function(plate)
    TriggerClientEvent('nitrous:client:StopSync', -1, plate)
end)

RegisterNetEvent('nitrous:server:SyncPurge', function(veh, status, purgeflowrate)
    TriggerClientEvent('nitrous:client:SyncPurge', -1, veh, status, source, purgeflowrate)
end)