QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

RegisterNetEvent('esx_dmvschool:addLicense')
AddEventHandler('esx_dmvschool:addLicense', function(type, key)
	if QBCore.Functions.kickHacKer(source, key) then -- QBCore.Key
		local src = source
		local xPlayer = QBCore.Functions.GetPlayer(src)
		local licenses = xPlayer.PlayerData.metadata.licences
		licenses[type] = true
		xPlayer.Functions.SetMetaData("licences", licenses)
		TriggerClientEvent('esx_dmvschool:loadLicenses', src, licenses)
		TriggerClientEvent("QBCore:Notify", src, "Ehliyet Sınavını Geçtin Tebrikler")
	end
end)

RegisterNetEvent('esx_dmvschool:pay')
AddEventHandler('esx_dmvschool:pay', function(price)
	local src = source
	local xPlayer = QBCore.Functions.GetPlayer(src)
	if xPlayer.Functions.RemoveMoney('bank', 10) then
		TriggerClientEvent("QBCore:Notify", src, "Sürüş kursu için $"..QBCore.Shared.GroupDigits(price).." ödendi")
	end
end)