QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

RegisterServerEvent('esx_lapdance:Buy')
AddEventHandler('esx_lapdance:Buy', function()
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)
	if xPlayer.Functions.RemoveMoney('bank', 500) then
	    TriggerClientEvent('esx_lapdance:lapdance', src)
        QBCore.Functions.addJobMoney("unicorn", 400)
	else
	    TriggerClientEvent("QBCore:Notify", src, 'Bank Account Does Not Have Enough Money!', 'error')
	end
end)

RegisterServerEvent('lapdance:delete-ped')
AddEventHandler('lapdance:delete-ped', function(netId)
    TriggerClientEvent("lapdance:client:delete-ped", -1, netId)
end)