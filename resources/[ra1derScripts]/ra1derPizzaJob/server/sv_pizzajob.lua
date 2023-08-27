local QBCore = exports['qb-core']:GetCoreObject()

RegisterServerEvent('ra1derPizzaJob:server:Payment', function(jobsDone)
	local src = source
    local payment = Config.Payment * jobsDone
	local Player = QBCore.Functions.GetPlayer(source)
    jobsDone = tonumber(jobsDone)
    if jobsDone > 0 then
        Player.Functions.AddMoney("cash", payment)
        TriggerClientEvent("QBCore:Notify", source, ""..payment.. "$ Received", "success")
    end
end)

RegisterServerEvent('ra1derPizzaJob:server:Bahsis', function()
	local src = source
	local Player = QBCore.Functions.GetPlayer(source)
    if math.random(1, 100) > 50 then 
        Player.Functions.AddMoney("cash", Config.Bahsis)
        TriggerClientEvent("QBCore:Notify", source, ""..Config.Bahsis.. "$ You got a tip", "success")
    end
end)



