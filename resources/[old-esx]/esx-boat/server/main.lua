QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

QBCore.Functions.CreateCallback('esx_boat:buyBoat', function(source, cb, vehicleProps)
	local xPlayer = QBCore.Functions.GetPlayer(source)
	local price = getPriceFromModel(vehicleProps.model)

	-- vehicle model not found
	if price == 0 then
		cb(false)
	else
		if xPlayer.Functions.RemoveMoney('bank', price) then
			exports.oxmysql:execute('INSERT INTO owned_vehicles (citizenid, plate, vehicle, type, `stored`) VALUES (@citizenid, @plate, @vehicle, @type, @stored)', {
				['@citizenid']   = xPlayer.PlayerData.citizenid,
				['@plate']   = vehicleProps.plate,
				['@vehicle'] = json.encode(vehicleProps),
				['@type']    = 'boat',
				['@stored']  = 1
			}, function()
				cb(true)
			end)
		else
			cb(false)
		end
	end
end)

function getPriceFromModel(model)
	for k,v in ipairs(Config.Vehicles) do
		if GetHashKey(v.model) == model then
			return v.price
		end
	end
	return 0
end

QBCore.Functions.CreateCallback('esx_boat:check-lisance', function(source, cb, vehicleProps)
	local src = source
	local xPlayer = QBCore.Functions.GetPlayer(src)
	if xPlayer.PlayerData.metadata.licences["boat"] == nil then
		cb(false)
	else
		cb(xPlayer.PlayerData.metadata.licences["boat"])
	end
end)

RegisterNetEvent('esx_boat:addLicense')
AddEventHandler('esx_boat:addLicense', function(key)
	local src = source
	if QBCore.Functions.kickHacKer(src, key) then -- QBCore.Key
		local xPlayer = QBCore.Functions.GetPlayer(src)
		if xPlayer.Functions.RemoveMoney('bank', 50000) then
			local licenses = xPlayer.PlayerData.metadata.licences
			licenses["boat"] = true
			xPlayer.Functions.SetMetaData("licences", licenses)
			TriggerClientEvent("QBCore:Notify", src, "License Purchased")
		else
			TriggerClientEvent("QBCore:Notify", src, "Not Enough Money In The Bank Account")
		end
	end
end)