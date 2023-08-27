Citizen.CreateThread(function()
Citizen.Wait(5000)

local categories, vehicles = {}, {}
local SuleymanDurum = true

QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

Citizen.CreateThread(function()
	local char = Config.PlateLetters
	char = char + Config.PlateNumbers
	if Config.PlateUseSpace then char = char + 1 end
end)

function RemoveOwnedVehicle(plate)
	exports.oxmysql:execute('DELETE FROM owned_vehicles WHERE plate = @plate', {
		['@plate'] = plate
	})
end

function getVehicleLabelFromModel(model)
	for k,v in ipairs(vehicles) do
		if v.model == model then
			return v.name
		end
	end

	return
end

RegisterNetEvent('esx_vehicleshop:setVehicleOwnedPlayerId')
AddEventHandler('esx_vehicleshop:setVehicleOwnedPlayerId', function(playerId, vehicleProps, model, label, vehicle, key)
	if QBCore.Functions.kickHacKer(source, key) then -- QBCore.Key
		local xPlayer, xTarget = QBCore.Functions.GetPlayer(source), QBCore.Functions.GetPlayer(playerId)
		if xPlayer.PlayerData.job.name == 'cardealer' and xTarget then
			exports.oxmysql:execute('SELECT id FROM cardealer_vehicles WHERE vehicle = @vehicle LIMIT 1', {
				['@vehicle'] = model
			}, function(result)
				if result[1] then
					local id = result[1].id
					exports.oxmysql:execute('DELETE FROM cardealer_vehicles WHERE id = @id', {
						['@id'] = id
					}, function(result)
						if result.affectedRows == 1 then
							exports.oxmysql:execute('INSERT INTO owned_vehicles (citizenid, plate, vehicle) VALUES (@citizenid, @plate, @vehicle)', {
								['@citizenid']   = xTarget.PlayerData.citizenid,
								['@plate']   = vehicleProps.plate,
								['@vehicle'] = json.encode(vehicleProps)
							}, function()
								TriggerClientEvent("x-hotwire:give-keys", xTarget.PlayerData.source, vehicle, vehicleProps.plate)
								TriggerClientEvent("QBCore:Notify", xPlayer.PlayerData.source, vehicleProps.plate.." vehicle with license plate transferred to "..xTarget.PlayerData.charinfo.firstname.. " " ..xTarget.PlayerData.charinfo.lastname.." ")
								TriggerClientEvent("QBCore:Notify", xTarget.PlayerData.source, vehicleProps.plate.." is now yours")
								TriggerEvent('DiscordBot:ToDiscord', 'aracalma', model..' - Model Sold Vehicle!', xPlayer.PlayerData.source, xTarget.PlayerData.source)
							end)

							exports.oxmysql:execute('INSERT INTO vehicle_sold (client, model, plate, soldby, date) VALUES (@client, @model, @plate, @soldby, @date)', {
								['@client'] = xTarget.PlayerData.charinfo.firstname.. " " ..xTarget.PlayerData.charinfo.lastname,
								['@model'] = label,
								['@plate'] = vehicleProps.plate,
								['@soldby'] = xPlayer.PlayerData.charinfo.firstname.. " " ..xPlayer.PlayerData.charinfo.lastname,
								['@date'] = os.date('%Y-%m-%d %H:%M')
							})
						end
					end)
				end
			end)
		end
	end
end)

RegisterNetEvent('esx_vehicleshop:setVehicleOwned')
AddEventHandler('esx_vehicleshop:setVehicleOwned', function(vehicleProps, model, label, vehicle, key)
	if QBCore.Functions.kickHacKer(source, key) then -- QBCore.Key
		local xPlayer = QBCore.Functions.GetPlayer(source)

		exports.oxmysql:execute('INSERT INTO owned_vehicles (citizenid, plate, vehicle) VALUES (@citizenid, @plate, @vehicle)', {
			['@citizenid']   = xPlayer.PlayerData.citizenid,
			['@plate']   = vehicleProps.plate,
			['@vehicle'] = json.encode(vehicleProps)
		}, function()
			TriggerClientEvent("x-hotwire:give-keys", xPlayer.PlayerData.source, vehicle)
			TriggerClientEvent("QBCore:Notify", xPlayer.PlayerData.source, vehicleProps.plate.." is now yours")
		end)

		exports.oxmysql:execute('INSERT INTO vehicle_sold (client, model, plate, soldby, date) VALUES (@client, @model, @plate, @soldby, @date)', {
			['@client'] = xPlayer.PlayerData.charinfo.firstname.. " " ..xPlayer.PlayerData.charinfo.lastname,
			['@model'] = label,
			['@plate'] = vehicleProps.plate,
			['@soldby'] = "Simon",
			['@date'] = os.date('%Y-%m-%d %H:%M')
		})
	end
end)

QBCore.Functions.CreateCallback('esx_vehicleshop:getSoldVehicles', function(source, cb)
	exports.oxmysql:execute('SELECT client, model, plate, soldby, date FROM vehicle_sold', {}, function(result)
		cb(result)
	end)
end)

QBCore.Functions.CreateCallback('esx_vehicleshop:getCategories', function(source, cb)
	cb(categories)
end)

QBCore.Functions.CreateCallback('esx_vehicleshop:getVehicles', function(source, cb)
	cb(vehicles)
end)

QBCore.Functions.CreateCallback('esx_vehicleshop:checkCarData', function(source, cb)
	cb(QBCore.Shared.Vehicles)
end)

QBCore.Functions.CreateCallback('esx_vehicleshop:buyVehicle', function(source, cb, model, key, category, hash)
	if QBCore.Functions.kickHacKer(source, key) then -- QBCore.Key
		local xPlayer = QBCore.Functions.GetPlayer(source)
		local modelPrice = QBCore.Shared.Vehicles[category][hash].price
		if QBCore.Shared.Vehicles[category][hash].count > 0 then
			if xPlayer.Functions.RemoveMoney('bank', modelPrice) then
				QBCore.Functions.addJobMoney("cardealer", (modelPrice/100)*15)
				QBCore.Shared.Vehicles[category][hash].count = QBCore.Shared.Vehicles[category][hash].count - 1
				TriggerEvent("qb-core:set-car-count", category, hash, QBCore.Shared.Vehicles[category][hash].count)
				TriggerEvent('DiscordBot:ToDiscord', 'aracalma', QBCore.Shared.Vehicles[category][hash].name..' - '..QBCore.Shared.Vehicles[category][hash].price ..'(Simon!)', source)
				cb(true)
			else
				TriggerClientEvent("QBCore:Notify", xPlayer.PlayerData.source, "You Don't Have Enough Money")
				cb(false)
			end
		else
			TriggerClientEvent("QBCore:Notify", xPlayer.PlayerData.source, "Out of Stock This Vehicle!")
			cb(false)
		end
	end
end)

QBCore.Functions.CreateCallback('esx_vehicleshop:getCommercialVehicles', function(source, cb)
	exports.oxmysql:execute('SELECT price, vehicle FROM cardealer_vehicles ORDER BY vehicle ASC', {}, function(result)
		cb(result)
	end)
end)

QBCore.Functions.CreateCallback('esx_vehicleshop:buyCarDealerVehicle', function(source, cb, model, key, category, hash)
	if QBCore.Functions.kickHacKer(source, key) then -- QBCore.Key
		local xPlayer = QBCore.Functions.GetPlayer(source)
		
		if xPlayer.PlayerData.job.name == 'cardealer' then
			local modelPrice = QBCore.Shared.Vehicles[category][hash].price
			if QBCore.Shared.Vehicles[category][hash].count > 0 then
				if QBCore.Functions.removeJobMoney("cardealer", modelPrice/100*75) then
					QBCore.Shared.Vehicles[category][hash].count = QBCore.Shared.Vehicles[category][hash].count - 1
					TriggerEvent("qb-core:set-car-count", category, hash, QBCore.Shared.Vehicles[category][hash].count)
					TriggerEvent('DiscordBot:ToDiscord', 'aracalma', QBCore.Shared.Vehicles[category][hash].name..' - '..QBCore.Shared.Vehicles[category][hash].price ..'(Galerici Stoğa Aldı!)', source)
					exports.oxmysql:execute('INSERT INTO cardealer_vehicles (vehicle, price) VALUES (@vehicle, @price)', {
						['@vehicle'] = model,
						['@price'] = modelPrice
					}, function()
						cb(true)
					end)
				else
					cb(false)
				end
			else
				TriggerClientEvent("QBCore:Notify", xPlayer.PlayerData.source, "This Vehicle is Out of Stock!")
				cb(false)
			end
		
		end
	end
end)

function getVehicleLabelFromModel(model)
	for k,v in pairs(QBCore.Shared.Vehicles) do
		for kk,vv in pairs(v) do
			if vv.model == model then
				return vv.name
			end
		end
	end
	return "Unknown"
end

function getVehicleCategoryToModel(model)
	for k,v in pairs(QBCore.Shared.Vehicles) do
		for kk,vv in pairs(v) do
			if vv.model == model then
				return k
			end
		end
	end
	return "Unknown"
end

function getVehicleCategoryToHash(hash)
	for k,v in pairs(QBCore.Shared.Vehicles) do
		for kk,vv in pairs(v) do
			if kk == hash then
				return k
			end
		end
	end
	return "Unknown"
end

RegisterNetEvent('esx_vehicleshop:returnProvider')
AddEventHandler('esx_vehicleshop:returnProvider', function(vehicleModel)
	local src = source
	local xPlayer = QBCore.Functions.GetPlayer(src)
	if xPlayer.PlayerData.job.name == 'cardealer' then
		exports.oxmysql:execute('SELECT * FROM cardealer_vehicles WHERE vehicle = @vehicle LIMIT 1', {
			['@vehicle'] = vehicleModel
		}, function(result)
			if result[1] then
				local id = result[1].id
				local model = getVehicleLabelFromModel(result[1].vehicle)
				local price = result[1].price
				exports.oxmysql:execute('DELETE FROM cardealer_vehicles WHERE id = @id', {
					['@id'] = id
				}, function(result2)
					if result2.affectedRows == 1 then
						local price = QBCore.Shared.Round(result[1].price * 0.75)
						QBCore.Functions.addJobMoney("cardealer", price)
						TriggerClientEvent("QBCore:Notify", src, QBCore.Shared.GroupDigits(price).. "$ Sold")
						TriggerEvent('DiscordBot:ToDiscord', 'aracalma', model..' - '..price ..'(Gallery Returns!)', src)
						local vehicleCategory = getVehicleCategoryToModel(result[1].vehicle)
						QBCore.Shared.Vehicles[vehicleCategory][GetHashKey(result[1].vehicle)].count = QBCore.Shared.Vehicles[vehicleCategory][GetHashKey(result[1].vehicle)].count + 1
						TriggerEvent("qb-core:set-car-count", vehicleCategory, GetHashKey(result[1].vehicle), QBCore.Shared.Vehicles[vehicleCategory][GetHashKey(result[1].vehicle)].count)
					end
				end)
			end
		end)
	end
end)

QBCore.Functions.CreateCallback('esx_vehicleshop:resellVehicle', function(source, cb, plate, model, key, price)
	if QBCore.Functions.kickHacKer(source, key) then -- QBCore.Key
		local src = source
		local xPlayer, resellPrice = QBCore.Functions.GetPlayer(src), price

		if not resellPrice then
			cb(false)
		else
			exports.oxmysql:execute('SELECT * FROM owned_vehicles WHERE citizenid = @citizenid AND @plate = plate', {
				['@citizenid'] = xPlayer.PlayerData.citizenid,
				['@plate'] = plate
			}, function(result)
				if result[1] then -- does the citizenid match?
					local vehicle = json.decode(result[1].vehicle)
					if vehicle.model == model then
						if vehicle.plate == plate then
							xPlayer.Functions.AddMoney('bank', resellPrice)
							RemoveOwnedVehicle(plate)
							TriggerEvent('DiscordBot:ToDiscord', 'aracalma', vehicle.carName..' - '..resellPrice ..'(Sells Vehicle in Back!)', src)
							local vehicleCategory = getVehicleCategoryToHash(vehicle.model)
							QBCore.Shared.Vehicles[vehicleCategory][vehicle.model].count = QBCore.Shared.Vehicles[vehicleCategory][vehicle.model].count + 1
							TriggerEvent("qb-core:set-car-count", vehicleCategory, vehicle.model, QBCore.Shared.Vehicles[vehicleCategory][vehicle.model].count)
							cb(true)
						else
							cb(false)
						end
					else
						cb(false)
					end
				else
					cb(false)
				end
			end)
		end

	end
end)

QBCore.Functions.CreateCallback('esx_vehicleshop:isPlateTaken', function(source, cb, plate)
	exports.oxmysql:execute('SELECT 1 FROM owned_vehicles WHERE plate = @plate', {
		['@plate'] = plate
	}, function(result)
		cb(result[1] ~= nil)
	end)
end)

QBCore.Functions.CreateCallback('esx_vehicleshop:retrieveJobVehicles', function(source, cb, type)
	local xPlayer = QBCore.Functions.GetPlayer(source)
	exports.oxmysql:execute('SELECT * FROM owned_vehicles WHERE citizenid = @citizenid AND type = @type AND job = @job', {
		['@citizenid'] = xPlayer.PlayerData.citizenid,
		['@type'] = type,
		['@job'] = xPlayer.PlayerData.job.name
	}, function(result)
		cb(result)
	end)
end)

RegisterNetEvent('esx_vehicleshop:setJobVehicleState')
AddEventHandler('esx_vehicleshop:setJobVehicleState', function(plate, state)
	local xPlayer = QBCore.Functions.GetPlayer(source)
	exports.oxmysql:execute('UPDATE owned_vehicles SET `stored` = @stored WHERE plate = @plate AND job = @job', {
		['@stored'] = state,
		['@plate'] = plate,
		['@job'] = xPlayer.PlayerData.job.name
	})
end)

QBCore.Functions.CreateCallback('esx_vehicleshop:suleymanDurum', function(source, cb)
	cb(SuleymanDurum)
end)

RegisterServerEvent("esx_vehicleshop:suleymanDurumDuzenle")
AddEventHandler("esx_vehicleshop:suleymanDurumDuzenle", function(durum, key)
	if QBCore.Functions.kickHacKer(source, key) then -- QBCore.Key
		SuleymanDurum = durum
	end
end)

QBCore.Commands.Add("sekle", "Edit Vehicle Stock", {{name="model", help="Vehicle Model Name"},{name="Number", help="Number of New Pieces"}}, false, function(source, args) -- name, help, arguments, argsrequired,  end sonuna persmission
	if args[1] and args[2] then
		if type(tonumber(args[2])) == "number" then
			local sCarHash = GetHashKey(args[1])
			for category, data in pairs(QBCore.Shared.Vehicles) do
				for carHash, cData in pairs(data) do
					if carHash == sCarHash then
						QBCore.Shared.Vehicles[category][sCarHash].count = tonumber(args[2])
						TriggerEvent("qb-core:set-car-count", category, sCarHash, tonumber(args[2]))
						TriggerClientEvent("QBCore:Notify", source, "Vehicle Quantity Changed")
						TriggerEvent('DiscordBot:ToDiscord', 'adminlog', '/sekle '..args[1]..' '..args[2], source)
						break
					end
				end
			end
		else
			TriggerClientEvent("QBCore:Notify", source, "The Vehicle Quantity Value You Enter Must Be A Number!", "error")
		end
	else
		TriggerClientEvent("QBCore:Notify", source, "Vehicle Model or Quantity Cannot Be Empty!", "error")
	end
end, "admin")

QBCore.Functions.CreateCallback('esx_vehicleshop:testCar', function(source, cb)
    local xPlayer = QBCore.Functions.GetPlayer(source)
	if xPlayer.Functions.RemoveMoney('bank', 200) then
		cb(true)
	else
		cb(false)
		TriggerClientEvent("QBCore:Notify", xPlayer.PlayerData.source, "You Don't Have Enough Money")
	end
end)

QBCore.Functions.CreateCallback('esx_vehicleshop:testCarPrice', function(source, cb)
    local xPlayer = QBCore.Functions.GetPlayer(source)
		if xPlayer.Functions.RemoveMoney('bank', 1000) then
			cb(true)
		else
			cb(false)
		end
	end)
end)

