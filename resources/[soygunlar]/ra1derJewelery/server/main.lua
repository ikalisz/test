local QBCore = exports['qb-core']:GetCoreObject()
local timeOut = false

-- Callback

QBCore.Functions.CreateCallback('ra1derJewelery:server:getCops', function(source, cb)
	local amount = 0
    for k, v in pairs(QBCore.Functions.GetQBPlayers()) do
        if v.PlayerData.job.name == "police"  then
            amount = amount + 1
        end
    end
    cb(amount)
end)

-- Events
RegisterNetEvent('ra1derJewelery:server:ThermitePtfx', function()
    TriggerClientEvent('ra1derJewelery:client:ThermitePtfx', -1)
end)

RegisterNetEvent('ra1derJewelery:server:setVitrineState', function(stateType, state, k)
    Config.Locations[k][stateType] = state
    TriggerClientEvent('ra1derJewelery:client:setVitrineState', -1, stateType, state, k)
end)

RegisterNetEvent('ra1derJewelery:server:vitrineReward', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local otherchance = math.random(1, 4)
    local odd = math.random(1, 4)

    if otherchance == odd then
        local item = math.random(1, #Config.VitrineRewards)
        local amount = math.random(Config.VitrineRewards[item]["amount"]["min"], Config.VitrineRewards[item]["amount"]["max"])
        if Player.Functions.AddItem(Config.VitrineRewards[item]["item"], amount) then
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[Config.VitrineRewards[item]["item"]], 'add')
        else
            TriggerClientEvent('QBCore:Notify', src, 'full of.', 'error')
        end
    else
        local amount = math.random(2, 4)
        if Player.Functions.AddItem("altinkolye", amount) then
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["altinkolye"], 'add')
        else
            TriggerClientEvent('QBCore:Notify', src, 'full of.', 'error')
        end
    end
end)

RegisterNetEvent('ra1derJewelery:server:setTimeout', function()
    if not timeOut then
        timeOut = true
        CreateThread(function()
            Wait(Config.Timeout)

            for k, v in pairs(Config.Locations) do
                Config.Locations[k]["isOpened"] = false
                TriggerClientEvent('ra1derJewelery:client:setVitrineState', -1, 'isOpened', false, k)
                Triggervent('qb-doorlock:server:updateState', "jewelery", true, true, true, true, true, true)
            end
            timeOut = false
        end)
    end
end)

RegisterServerEvent('ra1derJewelery:elektrik-kes')
AddEventHandler('ra1derJewelery:elektrik-kes', function()
	TriggerClientEvent("ra1derJewelery:elektrikKes:client", -1, true)
	Citizen.Wait(1800000)
	TriggerClientEvent("ra1derJewelery:elektrikKes:client", -1, false)
end)
