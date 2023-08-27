QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)


QBCore.Commands.Add("givecar", "Tool to a player's data (only god)", {}, true, function(source, args)
	TriggerClientEvent("ra1der:givecar", source)
end, "god")

QBCore.Functions.CreateCallback("ra1der:givecar:check", function(source, cb, args)
	local Player = QBCore.Functions.GetPlayer(tonumber(args.input))
	if Player == nil then
		cb(false) 
	else
		TriggerClientEvent('QBCore:Command:SpawnVehicle', tonumber(args.input), args.input2, true)
		cb(true)
	end
end)

RegisterServerEvent("giveSpawnVehicle", function(vehicleProps, vehicle)
	local oyuncu = QBCore.Functions.GetPlayer(source)
	local xPlayer = QBCore.Functions.GetPlayer(source)
	exports.oxmysql:execute('INSERT INTO owned_vehicles (citizenid, plate, vehicle, carName) VALUES (@citizenid, @plate, @vehicle, @carName)', {
		['@citizenid']   = xPlayer.PlayerData.citizenid,
		['@plate']   = vehicleProps.plate,
		['@vehicle'] = json.encode(vehicleProps),
		['@carName'] = string.lower(vehicleProps.carName)
	}, function()
		TriggerClientEvent("x-hotwire:give-keys", xPlayer.PlayerData.source, vehicle, vehicleProps.plate)
		TriggerClientEvent("QBCore:Notify", xPlayer.PlayerData.source, vehicleProps.plate.." license plate is now yours")
		TriggerEvent('DiscordBot:ToDiscord', 'adminlog', "\n Admin, araç verdi. \n Model: ``"..vehicleProps.carName.."``\n Plaka: ``"..vehicleProps.plate.."`` \n ID: ``"..xPlayer.PlayerData.source.."`` \n İsim Soyisim: ``"..xPlayer.PlayerData.charinfo.firstname.." " ..xPlayer.PlayerData.charinfo.lastname.."``", oyuncu.PlayerData.source)
	end)
end)
