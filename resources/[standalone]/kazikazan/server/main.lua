local QBCore = exports['qb-core']:GetCoreObject()



QBCore.Functions.CreateUseableItem("kazikazan", function(source)
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	Player.Functions.RemoveItem('kazikazan', 1)
	TriggerClientEvent('inventory:client:ItemBox', src,  QBCore.Shared.Items['kazikazan'], "remove")
    TriggerClientEvent("esx_kazikazan:onStart", src)

end)

RegisterNetEvent('esx_kazikazan:withdraw', function(amount)
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	amount = tonumber(amount)
	Wait(10)
	Player.Functions.AddMoney("cash", amount, "kazi-money")
	TriggerEvent('um-customlog',"casino","Scratchcard","blue","Won: $"..amount,src)
end)
