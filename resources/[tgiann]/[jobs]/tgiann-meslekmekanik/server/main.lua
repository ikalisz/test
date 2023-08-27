QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

TriggerEvent('esx_society:registerSociety', 'mechanic', 'mechanic', 'society_mechanic', 'society_mechanic', 'society_mechanic', {type = 'private'})
TriggerEvent('esx_society:registerSociety', 'mechanic_bennys', 'mechanic_bennys', 'society_mechanic_bennys', 'society_mechanic_bennys', 'society_mechanic_bennys', {type = 'private'})
TriggerEvent('esx_society:registerSociety', 'mechanic_gabz', 'mechanic_gabz', 'society_mechanic_gabz', 'society_mechanic_gabz', 'society_mechanic_gabz', {type = 'private'})
TriggerEvent('esx_society:registerSociety', 'mechanic_hayes', 'mechanic_hayes', 'society_mechanic_hayes', 'society_mechanic_hayes', 'society_mechanic_hayes', {type = 'private'})
TriggerEvent('esx_society:registerSociety', 'mechanic_hayes2', 'mechanic_hayes2', 'society_mechanic_haye2s', 'society_mechanic_hayes2', 'society_mechanic_hayes2', {type = 'private'})
TriggerEvent('esx_society:registerSociety', 'mechanic_tunner', 'mechanic_tunner', 'society_mechanic_tunner', 'society_mechanic_tunner', 'society_mechanic_tunner', {type = 'private'})

RegisterServerEvent('tgiann-meslekmekanik:onNPCJobMissionCompleted')
AddEventHandler('tgiann-meslekmekanik:onNPCJobMissionCompleted', function(key)
	local src = source
	if QBCore.Functions.kickHacKer(src, key) then -- QBCore.Key
		local xPlayer = QBCore.Functions.GetPlayer(src)
		local total   = math.random(50, 90)
		local playerTotal = total*0.8
		QBCore.Functions.addJobMoney(xPlayer.PlayerData.job.name, total*0.2)
		xPlayer.Functions.AddMoney('bank', total*0.8)
		TriggerClientEvent("QBCore:Notify",  src, playerTotal .. ' you won')
	end
end)

QBCore.Functions.CreateUseableItem('fixkit', function(source)
	local src = source
	local xPlayer  = QBCore.Functions.GetPlayer(src)
	TriggerClientEvent('tgiann-meslekmekanik:tamirkiti', xPlayer.PlayerData.source, "fixkit")
end)

QBCore.Functions.CreateUseableItem('tamirkiti', function(source)
	local src = source
	local xPlayer  = QBCore.Functions.GetPlayer(src)
	TriggerClientEvent('tgiann-meslekmekanik:tamirkiti', xPlayer.PlayerData.source, "tamirkiti")
end)

RegisterServerEvent('tgiann-meslekmekanik:kitsil')
AddEventHandler('tgiann-meslekmekanik:kitsil', function(item)
	local src = source
	local xPlayer = QBCore.Functions.GetPlayer(src)
	xPlayer.Functions.RemoveItem(item, 1, xPlayer.Functions.GetItemByName(item).slot)
end)
