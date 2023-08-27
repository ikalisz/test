local cachedData = {}

QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

-- Fatura
QBCore.Functions.CreateCallback('tgiann-garaj:fatura', function(source, cb)
	local src = source
	local xPlayer = QBCore.Functions.GetPlayer(src)
	if xPlayer then
		if xPlayer.PlayerData.metadata.ehliyetceza > 10000000000 then
			TriggerClientEvent("QBCore:Notify", src, "You Can't Use Garages Because Your License Has Been Revoked!", "error")
			return
		end
		exports.oxmysql:execute('SELECT * FROM billing WHERE citizenid = @citizenid', {
			['@citizenid'] = xPlayer.PlayerData.citizenid
		}, function(data)
			cb(data)
		end)
	end
end)

QBCore.Functions.CreateCallback("qb-garages:server:GetVehicleWheelfit", function(source, cb, plate)
    local src = source
    local wheelfit = nil
	
	exports.oxmysql:execute('SELECT wheelfit FROM owned_vehicles WHERE plate = ?', {plate}, function(result)
	    if result[1] ~= nil then
			wheelfit = json.decode(result[1].wheelfit)
		end
		cb(wheelfit)
	end)
end)

QBCore.Functions.CreateCallback("garage:fetchPlayerVehicles", function(source, callback, durum) -- Normal Araç
	local src = source
	local player = QBCore.Functions.GetPlayer(src)
	if player then
		if durum == "menu" or durum == "meslek-motor-arac" or durum == "meslek-unemployed-arac" or durum == 'meslek-night-arac' then -- normal araç
			sqlQuery = [[
				SELECT
					*
				FROM
					owned_vehicles
				WHERE
					citizenid = @cid and stored = '1' and type = 'car' and ikinciel = '0'
			]]

		elseif durum == "meslek-polis-arac" or durum == "meslek-policesivil-arac" then -- normal araç
			sqlQuery = [[
				SELECT
					*
				FROM
					owned_vehicles
				WHERE
					citizenid = @cid and stored = '1' and type = 'car' and ikinciel = '0' and job = 'police'
			]]

		elseif durum == "meslek-ems-arac" then -- normal araç
			sqlQuery = [[
				SELECT
					*
				FROM
					owned_vehicles
				WHERE
					citizenid = @cid and stored = '1' and type = 'car' and ikinciel = '0' and job = 'ambulance'
			]]

		elseif durum == "meslek-ems-heli" then -- normal araç
			sqlQuery = [[
				SELECT
					*
				FROM
					owned_vehicles
				WHERE
					citizenid = @cid and stored = '1' and type = 'helicopter' and ikinciel = '0' and job = 'ambulance'
			]]

		elseif durum == "meslek-wn-heli" then -- normal araç
			sqlQuery = [[
				SELECT
					*
				FROM
					owned_vehicles
				WHERE
					citizenid = @cid and stored = '1' and type = 'helicopter' and ikinciel = '0' and job = 'news'
			]]

		elseif durum == "meslek-wn-arac" then -- normal araç
			sqlQuery = [[
				SELECT
					*
				FROM
					owned_vehicles
				WHERE
					citizenid = @cid and stored = '1' and type = 'car' and ikinciel = '0' and job = 'news'
			]]

		elseif durum == "meslek-police-heli" then -- normal araç
			sqlQuery = [[
				SELECT
					*
				FROM
					owned_vehicles
				WHERE
					citizenid = @cid and stored = '1' and type = 'helicopter' and ikinciel = '0' and job = 'police'
			]]

		elseif durum == "meslek-motor-arac" then -- normal araç
			sqlQuery = [[
				SELECT
					*
				FROM
					owned_vehicles
				WHERE
					citizenid = @cid and stored = '1' and type = 'car' and ikinciel = '0' and job = 'motor'
			]]

		elseif durum == "meslek-mafia-arac" then -- normal araç
			sqlQuery = [[
				SELECT
					*
				FROM
					owned_vehicles
				WHERE
					citizenid = @cid and stored = '1' and type = 'car' and ikinciel = '0' and job = 'mafia'
			]]
				
		elseif durum == "cekilmis" then -- çekilmiş araç
			sqlQuery = [[
				SELECT
					*
				FROM
					owned_vehicles
				WHERE
					citizenid = @cid and stored = '0' and type = 'car' and ikinciel = '0'
			]]

		elseif durum == "bot" then -- Bot Garajı
			sqlQuery = [[
				SELECT
					*
				FROM
					owned_vehicles
				WHERE
					citizenid = @cid and stored = '1' and type = 'boat'
			]]

		elseif durum == "meslek-police-bot" then -- polis Bot Garajı
			sqlQuery = [[
				SELECT
					*
				FROM
					owned_vehicles
				WHERE
					citizenid = @cid and stored = '1' and type = 'boat' and job = 'police'
			]]

		elseif durum == "meslek-ems-bot" then -- polis Bot Garajı
			sqlQuery = [[
				SELECT
					*
				FROM
					owned_vehicles
				WHERE
					citizenid = @cid and stored = '1' and type = 'boat' and job = 'ambulance'
			]]
			
		elseif durum == "cekilmis-bot" then -- Bot Garajı
			sqlQuery = [[
				SELECT
					*
				FROM
					owned_vehicles
				WHERE
					citizenid = @cid and stored = '0' and type = 'boat'
			]]

		elseif durum == "ucak" then -- ucak Garajı
			sqlQuery = [[
				SELECT
					*
				FROM
					owned_vehicles
				WHERE
					citizenid = @cid and stored = '1' and type = 'helicopter'
			]]

		elseif durum == "cekilmis-ucak" then -- Çekilmiş Uçak Garajı
			sqlQuery = [[
				SELECT
					*
				FROM
					owned_vehicles
				WHERE
					citizenid = @cid and stored = '0' and type = 'helicopter'
			]]
		end

		exports.oxmysql:execute(sqlQuery, {
			["@cid"] = player.PlayerData.citizenid
		}, function(result)
			callback(result)
		end)
	else
		callback(false)
	end
end)

QBCore.Functions.CreateCallback("garage:validateVehicle", function(source, callback, vehicleProps, garage)
	local player = QBCore.Functions.GetPlayer(source)

	if player then
		local sqlQuery = [[
			SELECT
				citizenid
			FROM
				owned_vehicles
			WHERE
				plate = @plate
		]]

		exports.oxmysql:execute(sqlQuery, {
			["@plate"] = vehicleProps["plate"]
		}, function(responses)
			if responses[1] then
				UpdateGarage(vehicleProps, garage)

				callback(true)
			else
				callback(false)
			end
		end)
	else
		callback(false)
	end
end)

RegisterServerEvent('tgiann-garaj:arac-cekilmistemi')
AddEventHandler('tgiann-garaj:arac-cekilmistemi', function(garaj, plate, durum, fiyat)
	local src = source
	local xPlayer = QBCore.Functions.GetPlayer(src)
	if fiyat ~= nil then
		TriggerClientEvent("QBCore:Notify", xPlayer.PlayerData.source, fiyat.. "$ In return you got your car")
		xPlayer.Functions.RemoveMoney('bank', fiyat)
		TriggerEvent("inventory:server:resetTrunkGlovboxInv", plate)
	end

	exports.oxmysql:execute('UPDATE owned_vehicles SET stored = @stored, garaj = @garaj WHERE plate = @plate', {
		['@plate'] = plate,
		['@stored'] = durum,
		['@garaj'] = garaj
	})
end)

RegisterServerEvent('tgiann-garajv2:buy-car')
AddEventHandler('tgiann-garajv2:buy-car', function(vehicleData, prop)
	local src = source
	local xPlayer = QBCore.Functions.GetPlayer(src)
	local plate = QBCore.Shared.RandomInt(3) .. QBCore.Shared.RandomStr(3) .. QBCore.Shared.RandomInt(2)
	prop.plate = plate
	if xPlayer.Functions.RemoveMoney('bank', vehicleData.price) then
		exports.oxmysql:execute('INSERT INTO owned_vehicles (citizenid, plate, vehicle, type, job, stored) VALUES (@citizenid, @plate, @vehicle, @type, @job, @stored)', {
			['@citizenid'] = xPlayer.PlayerData.citizenid,
			['@plate'] = plate,
			['@vehicle'] = json.encode(prop),
			['@type'] = vehicleData.type,
			['@job'] = vehicleData.job,
			['@stored'] = 1,
		}, function()
			TriggerClientEvent("QBCore:Notify", xPlayer.PlayerData.source, 'Vehicle Purchased')
		end)

	else
		TriggerClientEvent("QBCore:Notify", xPlayer.PlayerData.source, 'Not Enough Money In The Bank Account!')
	end
end)

UpdateGarage = function(vehicleProps, newGarage)
	local sqlQuery = [[
		UPDATE
			owned_vehicles
		SET
			vehicle = @newVehicle
		WHERE
			plate = @plate
	]]

	exports.oxmysql:execute(sqlQuery, {
		["@plate"] = vehicleProps["plate"],
		["@newVehicle"] = json.encode(vehicleProps)
	})
end