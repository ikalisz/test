QBCore = nil
coreLoaded = false
Citizen.CreateThread(function()
    while QBCore == nil do
        TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)
        Citizen.Wait(200)
    end
    coreLoaded = true
end)

isInShopMenu = false
local spawnedVehicles = {}

function OpenBoatShop(shop)
	isInShopMenu = true

	local playerPed = PlayerPedId()
	local elements  = {}

	for k,v in ipairs(Config.Vehicles) do
		table.insert(elements, {
			label = ('%s - <span style="color:green;">$%s</span>'):format(v.label, QBCore.Shared.GroupDigits(v.price)),
			name  = v.label,
			model = v.model,
			price = v.price,
			props = v.props or nil
		})
	end

	QBCore.UI.Menu.Open('default', GetCurrentResourceName(), 'boat_shop', {
		title    = "Boat Sale",
		align    = 'top-left',
		elements = elements
	}, function (data, menu)
		QBCore.UI.Menu.Open('default', GetCurrentResourceName(), 'boat_shop_confirm', {
			title    = data.current.name.. " Buy / $"..QBCore.Shared.GroupDigits(data.current.price),
			align    = 'top-left',
			elements = {
				{label = "No", value = 'no'},
				{label = "Yes", value = 'yes'}
		}}, function (data2, menu2)
			if data2.current.value == 'yes' then
				local plate = exports['esx_vehicleshop']:GeneratePlate()
				local vehicle = GetVehiclePedIsIn(playerPed, false)
				local props = QBCore.Functions.GetVehicleProperties(vehicle)
				props.plate = plate

				QBCore.Functions.TriggerCallback('esx_boat:buyBoat', function(bought)
					if bought then
						QBCore.Functions.Notify("Purchased!")

						DeleteSpawnedVehicles()
						isInShopMenu = false
						QBCore.UI.Menu.CloseAll()

						FreezeEntityPosition(playerPed, false)
						SetEntityVisible(playerPed, true)
						SetEntityCoords(playerPed, shop.Outside.x, shop.Outside.y, shop.Outside.z)
					else
						QBCore.Functions.Notify("You Don't Have Enough Money!")
						menu2.close()
					end
				end, props)
			else
				menu2.close()
			end
		end, function (data2, menu2)
			menu2.close()
		end)
	end, function (data, menu)
		menu.close()
		isInShopMenu = false
		DeleteSpawnedVehicles()

		FreezeEntityPosition(playerPed, false)
		SetEntityVisible(playerPed, true)
		SetEntityCoords(playerPed, shop.Outside.x, shop.Outside.y, shop.Outside.z)
	end, function (data, menu)
		DeleteSpawnedVehicles()

		 QBCore.Functions.SpawnVehicle(data.current.model, function (vehicle)
			table.insert(spawnedVehicles, vehicle)
			TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
			FreezeEntityPosition(vehicle, true)
			TriggerEvent("x-hotwire:give-keys", vehicle)
			if data.current.props then
				QBCore.Functions.SetVehicleProperties(vehicle, data.current.props)
			end
		end, {x=shop.Inside.x, y=shop.Inside.y, z=shop.Inside.z, h= shop.Inside.w}, false)
	end)

	-- spawn first vehicle
	
	QBCore.Functions.SpawnVehicle(Config.Vehicles[1].model, function (vehicle)
		DeleteSpawnedVehicles()
		table.insert(spawnedVehicles, vehicle)
		TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
		FreezeEntityPosition(vehicle, true)
		TriggerEvent("x-hotwire:give-keys", vehicle)
		if Config.Vehicles[1].props then
			QBCore.Functions.SetVehicleProperties(vehicle, Config.Vehicles[1].props)
		end
	end, {x=shop.Inside.x, y=shop.Inside.y, z=shop.Inside.z, h= shop.Inside.w}, false)
end

function OpenLisance()
	QBCore.UI.Menu.Open('default', GetCurrentResourceName(), 'boat_shop', {
		title    = "Buy License",
		align    = 'top-left',
		elements = {
			{label = "Buy License - 50.000$", value = 'yes'},
			{label = "No", value = 'no'},
		}
	}, function(data, menu)
		if data.current.value == 'yes' then
			TriggerServerEvent("esx_boat:addLicense", QBCore.Key)
			menu.close()
		else
			menu.close()
		end
	end, function (data, menu)
		menu.close()
	end)
end

-- Key controls
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if isInShopMenu then
			DisableControlAction(0, 75, true)  -- Disable exit vehicle
			DisableControlAction(27, 75, true) -- Disable exit vehicle
		else
			Citizen.Wait(500)
		end
	end
end)

function DeleteSpawnedVehicles()
	while #spawnedVehicles > 0 do
		local vehicle = spawnedVehicles[1]
		QBCore.Functions.DeleteVehicle(vehicle)
		table.remove(spawnedVehicles, 1)
	end
end