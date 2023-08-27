local spike = {}

RegisterServerEvent('esx_policejob:spikesLocation')
AddEventHandler('esx_policejob:spikesLocation', function(x,y,z,h,amount)
    local src = source
    local spikeName = tostring(src.."S"..amount)
    local list = {
        id = src,
        x = x,
        y = y,
        z = z,
        h = h,
        watching = false,
        placed = false,
    }
    spike[spikeName] = list
    TriggerClientEvent("addSpikes", -1, list, spikeName)
end)

RegisterServerEvent('esx_policejob:removespikes')
AddEventHandler('esx_policejob:removespikes', function(spikeName)
    spike[spikeName] = nil
    TriggerClientEvent("removeSpikes", -1, spikeName)
end)