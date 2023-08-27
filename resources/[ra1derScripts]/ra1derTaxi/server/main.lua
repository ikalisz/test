local QBCore = exports['qb-core']:GetCoreObject()

-- Code

RegisterServerEvent('qb-taxi:server:NpcPay')
AddEventHandler('qb-taxi:server:NpcPay', function(Payment)
    local fooikansasah = math.random(1, 5)
    local r1, r2 = math.random(1, 5), math.random(1, 5)

    if fooikansasah == r1 or fooikansasah == r2 then
        Payment = Payment + math.random(50, 70)
    end
    local randomkanka = math.random(3, 10)

    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    Player.Functions.AddMoney("cash", Payment)
    Wait(1000)
    Player.Functions.AddMoney("cash", randomkanka)
    TriggerClientEvent("QBCore:Notify", src,  "".. randomkanka.. " $ You got a tip")
end)

RegisterNetEvent("ra1derTaxi:RentTaxi", function(src)
    local src = source
		local xPlayer = QBCore.Functions.GetPlayer(source)
		if xPlayer.Functions.RemoveMoney('cash', Config.TaxiRentPrice) then
            TriggerClientEvent("opentaximenu", src)
            TriggerClientEvent("QBCore:Notify", xPlayer.PlayerData.source, "Taxi Rented for $500, you will get $250 back when you return it.")
		else
			TriggerClientEvent("QBCore:Notify", xPlayer.PlayerData.source, "You Don't Have Enough Money")
		end
end)

