QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

QBCore.Functions.CreateCallback('tgiann-arackilit:araclarim', function(source, cb)
	local src = source
	local xPlayer = QBCore.Functions.GetPlayer(src)
	exports.oxmysql:execute('SELECT * FROM owned_vehicles WHERE citizenid = @citizenid', {
		["@citizenid"] = xPlayer.PlayerData.citizenid
	}, function(data)
		if data[1] then
			local Plakalar = {}
			for _,v in pairs(data) do
				table.insert(Plakalar, {
					plate = v.plate
				})
			end
			cb(Plakalar)
		end
	end)
end)

RegisterServerEvent('tgiann-arackilit:lock-car-server')
AddEventHandler('tgiann-arackilit:lock-car-server', function(durum, plate)
    TriggerClientEvent("tgiann-arackilit:lock-car", -1, durum, plate)
end)