
QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

RegisterServerEvent('np-bennys:attemptPurchase')
AddEventHandler('np-bennys:attemptPurchase', function(admin, type, npcMechanic, mechanic, vehPrice, polis, upgradeLevel)
	if not admin then
		local xPlayer = QBCore.Functions.GetPlayer(source)
		local price = 0
		local buy = false
		if type == "repair" then
			price = vehicleCustomisationPrices[type].price
		elseif upgradeLevel then
			price = calcPrice(vehicleCustomisationPrices[type].prices[upgradeLevel], npcMechanic, vehPrice, false)
		else
			price = calcPrice(vehicleCustomisationPrices[type].price, npcMechanic, vehPrice, false)
		end
		
		if price == 0 or price ==  0.0 then
			TriggerClientEvent("QBCore:Notify", source, "Parça Satın Alındı")
			buy = true
		else
			if polis then
				buy = true
				TriggerClientEvent("QBCore:Notify", source, "Parça Satın Alındı")
			elseif type == "repair" then
				if xPlayer.Functions.RemoveMoney('bank', price) then
					buy = true
					QBCore.Functions.addJobMoney(mechanic, price)
					TriggerClientEvent("QBCore:Notify", source, "Araç "..price.."$ Karşılığında Tamir Edildi!")
				else
					TriggerClientEvent("QBCore:Notify", source, "Banka Hesabında Yeterli Paran Yok!", "error")
				end
			elseif npcMechanic then
				if xPlayer.Functions.RemoveMoney('bank', price) then
					buy = true
					QBCore.Functions.addJobMoney(mechanic, price / 100 * 15)
					TriggerClientEvent("QBCore:Notify", source, price.."$ Karşılığında Satın Alındı")
				else
					TriggerClientEvent("QBCore:Notify", source, "Banka Hesabında Yeterli Paran Yok!", "error")
				end
			else
				if QBCore.Functions.removeJobMoney(mechanic, price) then
					buy = true
					TriggerClientEvent("QBCore:Notify", source, price.."$ Karşılığında Satın Alındı")
				else
					TriggerClientEvent("QBCore:Notify", source, "Mekanik kasasında Yeterli Para Yok", "error")
				end
			end
		end


		if buy then
			TriggerClientEvent("np-bennys:purchaseSuccessful", source)
		else
			TriggerClientEvent("np-bennys:purchaseFailed", source)
		end
	else
		TriggerClientEvent("np-bennys:purchaseSuccessful", source)
	end
end)

RegisterServerEvent('updateVehicle')
AddEventHandler('updateVehicle', function(props)
	exports.oxmysql:execute('UPDATE owned_vehicles SET vehicle = @vehicle WHERE plate = @plate', {
		['@plate'] = props.plate,
		['@vehicle'] = json.encode(props)
	})
end)
