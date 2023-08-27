local QBCore = exports['qb-core']:GetCoreObject()
--===================================================
--                 JOB CASH
--===================================================
RegisterServerEvent('qb-delivery:cash')
AddEventHandler('qb-delivery:cash', function(currentJobPay, value)
	local _source = source
	local Player = QBCore.Functions.GetPlayer(_source)
	if value == "job" then
		Player.Functions.AddMoney("bank", currentJobPay, "postal-job")		
		TriggerClientEvent("QBCore:Notify", _source, "You received your salary payment $"..currentJobPay)	
	elseif value == "add" then		
		Player.Functions.AddMoney("cash", currentJobPay, "postal-deposit-return")
		TriggerClientEvent("QBCore:Notify", _source, "$"..currentJobPay.." You got it back.")
	elseif value == "remove" and Player.PlayerData.money.cash >= currentJobPay then
		Player.Functions.RemoveMoney("cash", currentJobPay, "postal-deposit-pay")
		TriggerClientEvent("QBCore:Notify", _source, "$"..currentJobPay.." DEPOSITON FULLY RECEIVED.")
	end
end)
