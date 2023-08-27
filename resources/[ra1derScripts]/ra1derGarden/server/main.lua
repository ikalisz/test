local QBCore = exports['qb-core']:GetCoreObject()
local jobPlayers = 0
local isBusy = false
local gardenCD = false

RegisterNetEvent('ra1derGarden:server:work', function()
    if Config.MaxPlayers > 0 then
            if jobPlayers < Config.MaxPlayers then
                jobPlayers = jobPlayers + 1
                TriggerClientEvent('ra1derGarden:client:joinJob', source)
            else
                TriggerClientEvent('torpak:notify', source, "full of work! ", "error")
            end
    else
        TriggerClientEvent('ra1derGarden:client:joinJob', source)
    end
end)

RegisterNetEvent('ra1derGarden:server:leave', function()
    jobPlayers = jobPlayers - 1
    TriggerClientEvent('ra1derGarden:client:leaveJob', source)
end)

RegisterNetEvent('ra1derGarden:server:setState', function(curShrub)
    Shrubs[curShrub]["isBusy"] = true
    Wait(Config.Cooldown * 1000)  
    Shrubs[curShrub]["isBusy"] = false
end)

RegisterNetEvent('ra1derGarden:server:checkStatus', function(curShrub)
    if not Shrubs[curShrub]["isBusy"] then
        TriggerClientEvent('ra1derGarden:client:pruningShrub', source, curShrub)
    else
        TriggerClientEvent('torpak:notify', source, "You can't cut it now!", "error")
    end
end)

RegisterNetEvent('ra1derGarden:server:paycheck', function(paycheck)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    if Config.Cash then
        if paycheck <= 0 then
            TriggerClientEvent('torpak:notify', source, "Are you kidding, do your job first!", "error")
        else
            Player.Functions.AddMoney('cash', paycheck)
        end
    else
        if paycheck <= 0 then
            TriggerClientEvent('torpak:notify', source, "Are you kidding, do your job first!", "error")
        else
            Player.Functions.AddMoney('bank', paycheck)
        end
    end
end)
