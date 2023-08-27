QBCore = nil
Citizen.CreateThread(function()
    while QBCore == nil do
        TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)
        Citizen.Wait(200)
    end
end)

RegisterCommand("transferveh", function()
	giveCarKeys()
end)

function giveCarKeys()
	local playerPed = PlayerPedId()
	local coords    = GetEntityCoords(playerPed)
	local aracbulundu = false
	if IsPedInAnyVehicle(playerPed,  false) then
		vehicle = GetVehiclePedIsIn(playerPed, false)
		aracbulundu = true			
    else
		vehicle, distance = QBCore.Functions.GetClosestVehicle(coords)
		if distance < 5 then
			aracbulundu = true	
		end
    end
	
	if aracbulundu then
		local plate = GetVehicleNumberPlateText(vehicle)
		local vehicleProps = QBCore.Functions.GetVehicleProperties(vehicle)

		QBCore.Functions.TriggerCallback('esx_givecarkeys:requestPlayerCars', function(isOwnedVehicle)
			if isOwnedVehicle then

			local closestPlayer, closestDistance = QBCore.Functions.GetClosestPlayer()
				if closestPlayer == -1 or closestDistance > 3.0 then
					QBCore.Functions.Notify('No One Near!')
				else
					QBCore.Functions.Notify('You Transferred the Vehicle '..vehicleProps.plate..'!')
					TriggerServerEvent('esx_givecarkeys:setVehicleOwnedPlayerId', GetPlayerServerId(closestPlayer), vehicleProps, QBCore.Key)
				end
			else
				QBCore.Functions.Notify('The Vehicle Is Not Yours')
			end
		end, plate)
	else
		QBCore.Functions.Notify('No Vehicles Nearby')
	end
end







