local QBCore = exports['qb-core']:GetCoreObject()
local motels = {}
RegisterServerEvent('ra1derMotel:server:exitMotelRoom')
AddEventHandler('ra1derMotel:server:exitMotelRoom', function()
    local src = source
    motels[src] = nil
    SetPlayerRoutingBucket(src, 0)
    TriggerClientEvent('ra1derMotel:client:exitMotelRoom', src)
end)

RegisterServerEvent('ra1derMotel:server:enterMotelRoom')
AddEventHandler('ra1derMotel:server:enterMotelRoom', function()
    local src = source
    motels[src] = nil
    local bucket = getFirstBucket()
    if bucket < 64 then
        motels[src] = bucket
        SetPlayerRoutingBucket(src, motels[src])
        TriggerClientEvent('ra1derMotel:client:enterMotelRoom', src)
    end
end)

QBCore.Commands.Add('room0', 'Help Text', {}, false, function(source, args)
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(source)
    xPlayer.Functions.SetMetaData("motelroom", 0)
    TriggerClientEvent('QBCore:Notify', src, "I've been!", "error")
end, "admin")



RegisterNetEvent("ra1derMotel:server:motellevel")
AddEventHandler("ra1derMotel:server:motellevel", function();
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(source)
    if xPlayer.PlayerData.metadata['motelroom'] == 1 then
       TriggerClientEvent('QBCore:Notify', src, 'Zaten Lüks Odaya Sahipsin', "error")
    elseif xPlayer.Functions.RemoveMoney('cash', 5000) then
        xPlayer.Functions.SetMetaData("motelroom", 1)
        exports.oxmysql:update("UPDATE stashitemsnew SET stash = @stash WHERE stash = @stash2 ", {
            ["@stash2"] = "ClassicOda_" ..xPlayer.PlayerData.citizenid, 
            ["@stash"] = "LuksOda_" ..xPlayer.PlayerData.citizenid, 
        })
        TriggerClientEvent('QBCore:Notify', src, 'You Bought the Luxury Room', "success")
    else
        TriggerClientEvent('QBCore:Notify', src, "You Don't Have Enough Money!!", "error")
    end 
end)

function getFirstBucket()
    local i = 1
    repeat
        local founded = false
        for k, v in pairs(motels) do
            if motels[k] == i then
                founded = true
                i=i+1
                break
            end
        end
    until not founded
    return i
end