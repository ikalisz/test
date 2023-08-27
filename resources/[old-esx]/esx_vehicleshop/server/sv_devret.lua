QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

QBCore.Functions.CreateCallback('esx_givecarkeys:requestPlayerCars', function(source, cb, plate)
	local xPlayer = QBCore.Functions.GetPlayer(source)
	local vehiclePlate = QBCore.Shared.Trim(plate)
	exports.oxmysql:execute('SELECT * FROM owned_vehicles WHERE citizenid = @citizenid AND plate = @plate', {
		['@citizenid'] = xPlayer.PlayerData.citizenid,
		['@plate'] = vehiclePlate
	}, function(result)
		if result[1] then 
			cb(true)
		else
			cb(false)
		end
	end)
end)

RegisterServerEvent('esx_givecarkeys:setVehicleOwnedPlayerId')
AddEventHandler('esx_givecarkeys:setVehicleOwnedPlayerId', function (playerId, vehicleProps, key)
	local src = source
	if QBCore.Functions.kickHacKer(src, key) then -- QBCore.Key
		local zPlayer = QBCore.Functions.GetPlayer(playerId)
		exports.oxmysql:execute('UPDATE owned_vehicles SET citizenid = @citizenid WHERE plate = @plate', {
			['@citizenid'] = zPlayer.PlayerData.citizenid,
			['@plate'] = vehicleProps.plate
		}, function()
			TriggerEvent('DiscordBot:ToDiscord', 'aracdevret', vehicleProps.plate .." Plakalı Aracını Devretti", src, zPlayer.PlayerData.source)
			TriggerClientEvent("QBCore:Notify", zPlayer.PlayerData.source, vehicleProps.plate..' took the key of the car with this license plate!')
			TriggerClientEvent("gr-arackilit:plakaekle", zPlayer.PlayerData.source, vehicleProps.plate)
			TriggerClientEvent("gr-arackilit:plakaekle-xhotwire", zPlayer.PlayerData.source, vehicleProps.plate)
		end)
	end
end)