local QBCore = exports['qb-core']:GetCoreObject()
RegisterServerEvent("Player:Disconnect", function(src)
	local xPlayer = QBCore.Functions.GetPlayer(src)
	local src = source
    QBCore.Player.Logout(src)
    TriggerClientEvent('qb-multicharacter:client:chooseChar', src)
end)


