QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

RegisterServerEvent('tgiann-fightclub:server:revive-players')
AddEventHandler('tgiann-fightclub:server:revive-players', function()
	TriggerClientEvent("tgiann-fightclub:client:revive-players", -1)
end)