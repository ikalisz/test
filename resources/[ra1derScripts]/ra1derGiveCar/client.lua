QBCore = nil
Citizen.CreateThread(function()
    while QBCore == nil do
        TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)
        Citizen.Wait(200)
    end
end)

RegisterNetEvent('spawnVehicle:client')
AddEventHandler('spawnVehicle:client', function(vehiclemodel, type)
	local PlayerData = QBCore.Functions.GetPlayerData()
	local playerPed = PlayerPedId()
	local pCoords = GetEntityCoords(playerPed)
	QBCore.Functions.SpawnVehicle(vehiclemodel, pCoords, 1, function (vehicle)
		TaskWarpPedIntoVehicle(playerPed, vehicle, -1)

		local newPlate     = GeneratePlate()
		local vehicleProps = QBCore.Functions.GetVehicleProperties(vehicle)
		vehicleProps.plate = newPlate
		SetVehicleNumberPlateText(vehicle, newPlate)

		TriggerServerEvent('saveVehicle', vehicleProps, type)
		TriggerClientEvent("tgiann-arackilit:plakaekle", zPlayer.PlayerData.source, newPlate)
		TriggerClientEvent("tgiann-arackilit:plakaekle-xhotwire", zPlayer.PlayerData.source, newPlate)
	end)
end)

RegisterNetEvent("ra1der:givecar", function()
	local keyboard = exports['qb-input']:ShowInput({
		header = "Give a player a vehicle",
		submitText = "Onayla",
		inputs = {
			{
				type = 'text',
				isRequired = true,
				text = "Player ID",
				name = 'input',
			},
			{
				type = 'text',
				isRequired = true,
				text = "Vehicle Name",
				name = 'input2',
			}
		}
	})
	if not IsModelValid(keyboard.input2) then 
		QBCore.Functions.Notify(keyboard.input2.. " Named Vehicle Not Found", "error")
		return 
	end
	QBCore.Functions.TriggerCallback('ra1der:givecar:check', function(result)
		if result then 
			QBCore.Functions.Notify(keyboard.input.. " to the ID" ..keyboard.input2.. " Named Vehicle Given", "success", 5000)
		else 
			QBCore.Functions.Notify(keyboard.input.. " Player with ID not found", "error")
		end
	
	end, keyboard)
end)







