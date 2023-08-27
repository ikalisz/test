QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

RegisterNetEvent("shisha:pay")
AddEventHandler("shisha:pay", function()
	local xPlayer = QBCore.Functions.GetPlayer(source)
	xPlayer.Functions.RemoveMoney('bank', 20)
end)

RegisterServerEvent("eff_smokes")
AddEventHandler("eff_smokes", function(coords)
	TriggerClientEvent("c_eff_smokes", -1, coords)
end)