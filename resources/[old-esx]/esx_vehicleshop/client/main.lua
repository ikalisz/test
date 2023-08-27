local IsInShopMenu, coreLoaded, inSuleyman = false, false, false
local PlayerData = {}
local currentDisplayVehicle, playerLastCoord, playerLastHeading = nil, nil, nil

QBCore = nil
Citizen.CreateThread(function()
    while QBCore == nil do
		TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)
        Citizen.Wait(200)
	end
	coreLoaded = true
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
	PlayerData = QBCore.Functions.GetPlayerData()
end)

-- Meslek Update
RegisterNetEvent('QBCore:Client:OnJobUpdate')
AddEventHandler('QBCore:Client:OnJobUpdate', function(job)
	PlayerData.job = job
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

exports['qb-target']:AddBoxZone("galeri", vector3(-40.3104, -1106.93, 27.187), 0.5, 0.3, {
    name="NewRentalMenu4",
    heading=162,
    debugPoly=false,
    minZ=25.301415,
    maxZ=26.801415
    }, {
        options = {
            {
                event = "galeriac",
                icon = "fas fa-circle",
                label = "View Catalog",
            },
        },
        job = {"all"},
        distance = 2
  })

function ReturnVehicleProvider()
	QBCore.Functions.TriggerCallback('esx_vehicleshop:getCommercialVehicles', function(vehicles)
		local elements = {}

		if #vehicles > 0 then
			for k,v in ipairs(vehicles) do
				local returnPrice = QBCore.Shared.Round(v.price * 0.75)
				local vehicleLabel = getVehicleLabelFromModel(v.vehicle)
				table.insert(elements, {
					label = ('%s [<span style="color:orange;">%s</span>]'):format(vehicleLabel, "$"..QBCore.Shared.GroupDigits(returnPrice)),
					value = v.vehicle
				})
			end
		else
			table.insert(elements, {label = "No Vehicles in Stock!"})
		end

		QBCore.UI.Menu.Open('default', GetCurrentResourceName(), 'return_provider_menu', {
			title    = "Vehicle Gallery - Return vehicle to manufacturer",
			align    = 'top-left',
			elements = elements
		}, function(data, menu)
			if data.current.value then
				TriggerServerEvent('esx_vehicleshop:returnProvider', data.current.value)

				Citizen.Wait(300)
				menu.close()
				ReturnVehicleProvider()
			end
		end, function(data, menu)
			menu.close()
		end)
	end)
end

function StartShopRestriction()
	Citizen.CreateThread(function()
		IsInShopMenu = true
		while IsInShopMenu do
			Citizen.Wait(0)
			DisableAllControlActions(0)
			EnableControlAction(0, 1, true)
			EnableControlAction(0, 2, true)
		end
	end)
end





CreateThread(function()
	while true do Citizen.Wait(1000)
		if PlayerData.job and PlayerData.job.name == 'cardealer' then
			exports['qb-target']:AddBoxZone("galericimenu", vector3(-33.5887, -1103.69, 26.964), 0.5, 0.3, {
				name="galericimenu",
			heading=250,
			debugPoly=false,
			minZ=24.301415,
			maxZ=26.801415
			}, {
				options = {
					{
						event = "galericimenu",
						icon = "fas fa-circle",
						label = "Gallery Catalog",
					},
				},
				job = {"cardealer"},
				distance = 2
			})
		end
	end
end)
	

RegisterNetEvent("galericimenu", function()
	if PlayerData.job == nil then PlayerData = QBCore.Functions.GetPlayerData() end
		if PlayerData.job.name == "cardealer" then
		OpenResellerMenu()
	else
	QBCore.Functions.Notify("Who told you, you could open this place??")
	end
end)

function OpenResellerMenu()
	QBCore.UI.Menu.CloseAll()

	QBCore.UI.Menu.Open('default', GetCurrentResourceName(), 'reseller', {
		title    = "Vehicle Gallery",
		align    = 'top-left',
		elements = {
			{label = "Buy Vehicle", value = 'buy_vehicle'},
			{label = "Subtract Vehicle from Stock", value = 'pop_vehicle'},
			{label = "Put Vehicle Back in Stock", value = 'depop_vehicle'},
			{label = "Return Vehicle to Manufacturer", value = 'return_provider'},
			{label = "Create Invoice", value = 'create_bill'},
			{label = "Sell Vehicle [Nearby Player]", value = 'set_vehicle_owner_sell'},
		}
	}, function(data, menu)
		local action = data.current.value

		if action == 'buy_vehicle' then
			OpenShopMenu()
		elseif action == 'pop_vehicle' then
			OpenPopVehicleMenu()
		elseif action == 'depop_vehicle' then
			if currentDisplayVehicle then
				DeleteDisplayVehicleInsideShop()
			else
				QBCore.Functions.Notify("No Vehicle Found")
			end
		elseif action == 'return_provider' then
			ReturnVehicleProvider()
		elseif action == 'create_bill' then
			QBCore.UI.Menu.Open('dialog', GetCurrentResourceName(), 'billing', {
				title = "Total Amount of Fine to be Deducted"
			}, function(data, menu)
				local amount = tonumber(data.value)
		
				if amount == nil or amount < 0 then
					QBCore.Functions.Notify("Incorrect Value")
				else
					local closestPlayer, closestDistance = QBCore.Functions.GetClosestPlayer()
					if closestPlayer == -1 or closestDistance > 3.0 then
						QBCore.Functions.Notify("No One Near")
					else
						menu.close()
						QBCore.Functions.Notify('$ Invoice with ' ..amount.. 'Sent to Person!')
						TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(closestPlayer), 'police', "Premium Deluxo Sport", amount)
					end
				end
			end, function(data, menu)
				menu.close()
			end)
		elseif action == 'set_vehicle_owner_sell' then
			if currentDisplayVehicle then
				local closestPlayer, closestDistance = QBCore.Functions.GetClosestPlayer()
				if closestPlayer ~= -1 and closestDistance < 3 then
					local vehicleProps = {}
					vehicleProps.plate = GeneratePlate()
					QBCore.Functions.SetVehicleProperties(currentDisplayVehicle, vehicleProps)
					TriggerServerEvent('esx_vehicleshop:setVehicleOwnedPlayerId', GetPlayerServerId(closestPlayer), QBCore.Functions.GetVehicleProperties(currentDisplayVehicle), CurrentVehicleData.model, CurrentVehicleData.name, currentDisplayVehicle, QBCore.Key)
					currentDisplayVehicle = nil
					QBCore.UI.Menu.CloseAll()
				else
					QBCore.Functions.Notify("No players found recently")
				end
			else
				QBCore.Functions.Notify("No Vehicle Found")
			end
		end
	end, function(data, menu)
		menu.close()
	end)
end


function OpenPopVehicleMenu()
	QBCore.Functions.TriggerCallback('esx_vehicleshop:getCommercialVehicles', function(vehicles)
		local elements = {}

		if #vehicles > 0 then
			for k,v in ipairs(vehicles) do
				local vehicleLabel = GetDisplayNameFromVehicleModel(v.vehicle)
				table.insert(elements, {
					label = ('%s [<span style="color:green;">%s</span>]'):format(vehicleLabel, "$"..QBCore.Shared.GroupDigits(v.price)),
					value = v.vehicle
				})
			end
		else
			table.insert(elements, {label = "No Vehicles in Stock!"})
		end

		QBCore.UI.Menu.Open('default', GetCurrentResourceName(), 'commercial_vehicles', {
			title    = "Vehicle - Vehicle gallery",
			align    = 'top-left',
			elements = elements
		}, function(data, menu)
			local model = data.current.value
			DeleteDisplayVehicleInsideShop()
			QBCore.Functions.SpawnVehicle(model, function(vehicle)
				currentDisplayVehicle = vehicle
				for Categories, car in pairs(QBCore.Shared.Vehicles) do 
					for hash, cars in pairs(QBCore.Shared.Vehicles[Categories]) do
						if GetHashKey(model) == GetHashKey(cars.model) then
							CurrentVehicleData = cars
							break
						end
					end
				end
			end, {x=Config.DealerCarSpawn.x, y=Config.DealerCarSpawn.y, z=Config.DealerCarSpawn.z, h = Config.DealerCarSpawn.w}, true)
		end, function(data, menu)
			menu.close()
		end)
	end)
end

function OpenBossActionsMenu()
	QBCore.UI.Menu.CloseAll()
	QBCore.Functions.TriggerCallback('esx_vehicleshop:suleymanDurum', function(durum)
		if durum then
			durumYazi = ('<span style="color:green;">%s</span>'):format("Active")
		else
			durumYazi = ('<span style="color:red;">%s</span>'):format("Deactive")
		end
		QBCore.UI.Menu.Open('default', GetCurrentResourceName(), 'reseller',{
			title    = "Vehicle Gallery - Boss",
			align    = 'top-left',
			elements = {
				{label = "Boss Actions", value = 'boss_actions'},
				{label = "List of Vehicles Sold", value = 'sold_vehicles'},
				{label = "Simon Status: ".. durumYazi, value = "sulo"}
		}}, function(data, menu)
			if data.current.value == 'boss_actions' then
				TriggerEvent('esx_society:openBossMenu', 'cardealer', function(data2, menu2)
					menu2.close()
				end)
			elseif data.current.value == 'sold_vehicles' then
				QBCore.Functions.TriggerCallback('esx_vehicleshop:getSoldVehicles', function(customers)
					local elements = {
						head = { "Customer", "model", "Plate", "Sales Person","Date" },
						rows = {}
					}

					for i=1, #customers, 1 do
						table.insert(elements.rows, {
							data = customers[i],
							cols = {
								customers[i].client,
								customers[i].model,
								customers[i].plate,
								customers[i].soldby,
								customers[i].date
							}
						})
					end

					QBCore.UI.Menu.Open('list', GetCurrentResourceName(), 'sold_vehicles', elements, function(data2, menu2)

					end, function(data2, menu2)
						menu2.close()
					end)
				end)
			elseif data.current.value == 'sulo' then
				if durum then
					QBCore.Functions.Notify("Simon Taken Out of Hours")
					TriggerServerEvent("esx_vehicleshop:suleymanDurumDuzenle", false, QBCore.Key)
					menu.close()
					OpenBossActionsMenu()
				else
					QBCore.Functions.Notify("Simon's Back at Work")
					TriggerServerEvent("esx_vehicleshop:suleymanDurumDuzenle", true, QBCore.Key)
					menu.close()
					OpenBossActionsMenu()
				end
			end

		end, function(data, menu)
			menu.close()

		end)
	end)
end

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		if IsInShopMenu then
			SetNuiFocus(false,false)
			QBCore.UI.Menu.CloseAll()
			local playerPed = PlayerPedId()
			FreezeEntityPosition(playerPed, false)
			SetEntityVisible(playerPed, true)
			SetEntityCoords(playerPed, -33.7, -1102.0, 26.2)
			DeleteDisplayVehicleInsideShop()
		end
	end
end)

Citizen.CreateThread(function()
	local blip = AddBlipForCoord(-33.7, -1102.0, 26.2)
	SetBlipSprite(blip, 326)
	SetBlipDisplay(blip, 4)
	SetBlipColour(blip, 32)
	SetBlipScale(blip, 0.59)
	SetBlipAsShortRange(blip, true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Gallery")
	EndTextCommandSetBlipName(blip)

	RequestIpl('shr_int')
	LoadInterior(7170)
	EnableInteriorProp(7170, 'csr_beforeMission')
	RefreshInterior(7170)
	
	for num,zone in pairs(Config.Zones) do
		-- exports["elixir-base"]:addNotif("E", "Galerici Simon", 2, 2, vector3(Config.SuleymanCoord.x, Config.SuleymanCoord.y, Config.SuleymanCoord.z))

		for k,location in ipairs(zone.ResellVehicle) do
			-- exports["elixir-base"]:addNotif("E", " Aracı Sat", 4, 2, location, true)
		end

		for k,location in ipairs(zone.ShopEntering) do
			-- exports["elixir-base"]:addNotif("E", "Araç Galerisi", 3, 2, location, false, "cardealer")
		end

		for k,location in ipairs(zone.BossActions) do
			-- exports["elixir-base"]:addNotif("E", "Patron İşlemleri", 3, 2, location, false, "cardealer", false, true)
		end
	end

	-- exports["elixir-base"]:pedcreate("suleyman", 0x4C7B2F05, Config.SuleymanCoord.x, Config.SuleymanCoord.y, Config.SuleymanCoord.z, Config.SuleymanCoord.w)
end)



RegisterNetEvent('vehicleShopKeybindGeneral')
AddEventHandler('vehicleShopKeybindGeneral', function()
	if coreLoaded then
		local playerPed = PlayerPedId()
		local playerCoords = GetEntityCoords(playerPed)
		local vehicle = GetVehiclePedIsIn(playerPed, false)

		for num,zone in pairs(Config.Zones) do
			for k, location in ipairs(zone.SifirSatici) do
				if  #(playerCoords - location) < 2 then
					OpenShopMenu_sifirsatici()
				end
			end

			if IsPedSittingInAnyVehicle(playerPed) and GetPedInVehicleSeat(vehicle, -1) == playerPed then
				for k,location in ipairs(zone.ResellVehicle) do
					local distance = #(playerCoords - location)
					if distance < 2 then
						local price = 0
						local name = "Unknown"
						for Categories, car in pairs(QBCore.Shared.Vehicles) do 
							for hash, cars in pairs(QBCore.Shared.Vehicles[Categories]) do
								if hash == GetEntityModel(vehicle) then
									price = cars.price
									name = cars.name
									break
								end
							end
						end

						if price > 0 then
							local resellPrice = QBCore.Shared.Round(price / 100 * Config.ResellPercentage)
							QBCore.UI.Menu.Open('default', GetCurrentResourceName(), 'return_provider_menu', {
								title    = "Vehicle Gallery - Return vehicle to manufacturer",
								align    = 'top-left',
								elements = {
									{label = "Cancel", value ="cancel"},
									{label = "Sell ​​Vehicle ("..resellPrice.."$)", value = "sell"}
								}
							}, function(data, menu)
								menu.close()

								if data.current.value == "sell" then
									local model = GetEntityModel(vehicle)
									local plate = QBCore.Shared.Trim(GetVehicleNumberPlateText(vehicle))
					
									CurrentActionData = {
										vehicle = vehicle,
										label = name,
										price = resellPrice,
										model = model,
										plate = plate
									}

									QBCore.Functions.TriggerCallback('esx_vehicleshop:resellVehicle', function(vehicleSold)
										if vehicleSold then
											QBCore.Functions.DeleteVehicle(CurrentActionData.vehicle)
											QBCore.Functions.Notify(CurrentActionData.label.." " .. QBCore.Shared.GroupDigits(CurrentActionData.price) .. " $ fiyatına satıldı")
										else
											QBCore.Functions.Notify("This vehicle does not belong to you", "error")
										end
									end, CurrentActionData.plate, CurrentActionData.model, QBCore.Key, CurrentActionData.price)
								end
							end, function(data, menu)
								menu.close()
							end)
						else
							QBCore.Functions.Notify("You Cannot Sell This Vehicle Back to the Gallery", "error")
						end
					end
				end
			end

			if PlayerData.job and PlayerData.job.name == 'cardealer' then
				for k,coords in ipairs(zone.ShopEntering) do
					if #(playerCoords - coords) < 2 then
						OpenResellerMenu()
					end
				end

				if PlayerData.job.boss then
					for k,coords in ipairs(zone.BossActions) do
						if #(playerCoords - coords) < 2 then
							OpenBossActionsMenu()
						end
					end
				end

			end
		end
	end
end)

function OpenShopMenu_sifirsatici()
	openMenu(true)
end

function OpenShopMenu()
	openMenu(false)
end

function openMenu(bool)
	TriggerEvent("chat:clear")
	QBCore.UI.Menu.CloseAll()
	QBCore.Functions.TriggerCallback("esx_vehicleshop:checkCarData", function(result)
		local tablo = {}
		for k,v in pairs(result) do
			table.insert(tablo,{sinif=k,arac=v})
			end
		StartShopRestriction()
		local playerPed = PlayerPedId()
		playerLastCoord, playerLastHeading = GetEntityCoords(playerPed), GetEntityHeading(playerPed)
		inSuleyman = bool
		SetNuiFocus(true,true)
		SendNUIMessage({type = 'open', carData = tablo, suleyman = inSuleyman})
		SetFollowVehicleCamViewMode(2)
	end)
end

RegisterNetEvent("galeriac", function()
	openMenu(true)
end)



RegisterNUICallback('getCarDataAndSpawnCar', function(data, cb)
	WaitForVehicleToLoad(data.model)
	QBCore.Functions.SpawnVehicle(data.model, function(vehicle)
		if currentDisplayVehicle ~= nil then DeleteDisplayVehicleInsideShop() end
		currentDisplayVehicle = vehicle
		TaskWarpPedIntoVehicle(PlayerPedId(), currentDisplayVehicle, -1)
		FreezeEntityPosition(currentDisplayVehicle, true)
		SetModelAsNoLongerNeeded(data.model)
		TriggerEvent("disc-hotwire:forceTurnOver", currentDisplayVehicle)

		cb({
			topspeed = math.ceil(GetVehicleHandlingFloat(currentDisplayVehicle, 'CHandlingData', 'fInitialDriveMaxFlatVel') / 1.9),
			accel = math.ceil(GetVehicleHandlingFloat(currentDisplayVehicle, 'CHandlingData', 'fInitialDriveForce') * 245),
			braking = math.ceil(GetVehicleHandlingFloat(currentDisplayVehicle, 'CHandlingData', 'fBrakeForce') * 32),
			handling = math.ceil(GetVehicleHandlingFloat(currentDisplayVehicle, 'CHandlingData', 'fSteeringLock') * 1.7),
		})

		SetFollowPedCamViewMode(2)
		SetFollowVehicleCamViewMode(2)
		SetVehicleOnGroundProperly(currentDisplayVehicle)
	end, {x=Config.ShopInside.x, y=Config.ShopInside.y, z=Config.ShopInside.z, h = Config.ShopInsideHeading}, false)
end)

function WaitForVehicleToLoad(modelHash)
	local modelHash = (type(modelHash) == 'number' and modelHash or GetHashKey(modelHash))
	if not HasModelLoaded(modelHash) then
		RequestModel(modelHash)
		BeginTextCommandBusyspinnerOn('STRING')
		AddTextComponentSubstringPlayerName("The car model is loading. Please wait")
		EndTextCommandBusyspinnerOn(4)
		while not HasModelLoaded(modelHash) do Citizen.Wait(0) end
		BusyspinnerOff()
	end
end

function DeleteDisplayVehicleInsideShop()
	local attempt = 0
	if DoesEntityExist(currentDisplayVehicle) then
		while DoesEntityExist(currentDisplayVehicle) and not NetworkHasControlOfEntity(currentDisplayVehicle) and attempt < 100 do
			Citizen.Wait(1)
			NetworkRequestControlOfEntity(currentDisplayVehicle)
			attempt = attempt + 1
		end

		if DoesEntityExist(currentDisplayVehicle) and NetworkHasControlOfEntity(currentDisplayVehicle) then
			QBCore.Functions.DeleteVehicle(currentDisplayVehicle)
		end
	end
	currentDisplayVehicle = nil
end

RegisterNUICallback('rightClick', function(data, cb)
	SetNuiFocus(false, false)
	while true do
		Citizen.Wait(1)
		if IsDisabledControlJustPressed(0, 91) or not IsInShopMenu then
			break
		end
	end
	SetNuiFocus(true, true)
	cb("")
end)

RegisterNUICallback('closeMenu', function(data, cb)
	closeMenu(data.buy, data.test)
	TriggerEvent("tgiann-hud:ui", true)
end)

function closeMenu(buy, test)
	local playerPed = PlayerPedId()
	DeleteDisplayVehicleInsideShop()
	SetNuiFocus(false, false)
	FreezeEntityPosition(playerPed, false)
	SetEntityVisible(playerPed, true)
	if not buy and not test then
		SetEntityCoords(playerPed, playerLastCoord)
		SetEntityHeading(playerPed, playerLastHeading)
		ClearPedTasksImmediately(playerPed)
	end
	SetFollowPedCamViewMode(0)
	SetFollowVehicleCamViewMode(0)
	IsInShopMenu = false
end

RegisterNUICallback('buyCar', function(data, cb)
	local playerPed = PlayerPedId()
	local selectedCarData = data
	if inSuleyman then
		QBCore.Functions.TriggerCallback('esx_vehicleshop:suleymanDurum', function(suleymanDurumu)
			QBCore.Functions.TriggerCallback('elixir-base:galeri-sayi', function(aktifGalerici)
				if QBCore.Functions.IsSpawnPointClear(vector3(Config.BuyCoord.x, Config.BuyCoord.y, Config.BuyCoord.z), 3.0) then 
					if suleymanDurumu then
						if aktifGalerici == 0 then 
							QBCore.Functions.TriggerCallback('esx_vehicleshop:buyVehicle', function(success)
								if success then
									DeleteDisplayVehicleInsideShop()
									QBCore.Functions.SpawnVehicle(selectedCarData.selectedCar.carModel, function (vehicle)
										local plate = GeneratePlate()
										local vehicleProps = {}
										vehicleProps.plate = plate
										QBCore.Functions.SetVehicleProperties(vehicle, vehicleProps)
										TriggerServerEvent('esx_vehicleshop:setVehicleOwned', QBCore.Functions.GetVehicleProperties(vehicle), selectedCarData.selectedCar.carModel, selectedCarData.selectedCar.carName, vehicle, QBCore.Key)
										TriggerEvent("x-hotwire:give-keys", vehicle)
										TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
									end, {x=Config.BuyCoord.x, y=Config.BuyCoord.y, z=Config.BuyCoord.z, h = Config.BuyCoord.w}, true)
									cb("")
								end
							end, selectedCarData.selectedCar.carModel, QBCore.Key, selectedCarData.selectedCar.class, GetHashKey(selectedCarData.selectedCar.carModel))
						else
							SendNUIMessage({type = 'notif', text = "Since there is an active dealer in the city, you can only buy a vehicle from a dealer.!"})
						end
					else
						SendNUIMessage({type = 'notif', text = 'Vehicle Purchase by Gallery Owner Turned Off'})
					end
				else
					SendNUIMessage({type = 'notif', text = "Unable to Buy Vehicles Due to Nearby Vehicle!"})
				end
			end)					
		end)
	else
		QBCore.Functions.TriggerCallback('esx_vehicleshop:getCommercialVehicles', function(vehicles)
			if #vehicles < 2 then
				QBCore.Functions.TriggerCallback('esx_vehicleshop:buyCarDealerVehicle', function(success)
					if success then
						DeleteDisplayVehicleInsideShop()
						SetEntityCoords(PlayerPedId(), playerLastCoord)
						SetEntityHeading(PlayerPedId(), playerLastHeading)
						QBCore.Functions.Notify("You bought a vehicle")
						cb("")
					else
						SendNUIMessage({type = 'notif', text = "There is not enough money in your company account"})
					end
				end, selectedCarData.selectedCar.carModel, QBCore.Key, selectedCarData.selectedCar.class, GetHashKey(selectedCarData.selectedCar.carModel))
			else
				SendNUIMessage({type = 'notif', text = "You can put a maximum of 2 vehicles in the vehicle stock"})
			end
		end)
	end
end)

RegisterNUICallback('testCar', function(selectedCarData, cb)
	if QBCore.Functions.IsSpawnPointClear(vector3(Config.BuyCoord.x, Config.BuyCoord.y, Config.BuyCoord.z), 3.0) then 
		QBCore.Functions.TriggerCallback('esx_vehicleshop:testCar', function(res)
			if res then
				local playerPed = PlayerPedId()
				local time = 120
				local spawnedVehicle = nil
				Citizen.CreateThread(function()
					QBCore.Functions.Notify(time.." Second Test Drive Started!")
					while true do
						Citizen.Wait(1000)
						time = time - 1
						QBCore.Functions.Notify(time, "primary", 800)

						if time == 0 then
							break
						end
					end
				end)
				QBCore.Functions.SpawnVehicle(selectedCarData.selectedCar.carModel, function (vehicle)
					spawnedVehicle = vehicle
					local vehicleProps = {}
					vehicleProps.plate = "TESTCAR"
					QBCore.Functions.SetVehicleProperties(spawnedVehicle, vehicleProps)
					TriggerEvent("x-hotwire:give-keys", spawnedVehicle)
					TaskWarpPedIntoVehicle(PlayerPedId(), spawnedVehicle, -1)
					cb("")
				end, {x=Config.BuyCoord.x, y=Config.BuyCoord.y, z=Config.BuyCoord.z, h = Config.BuyCoord.w}, true)
				Wait(250)
				SetNuiFocus(false, false)

				Citizen.CreateThread(function()
					while time > 0 do
						Citizen.Wait(0)
						DisablePlayerFiring(playerPed, true)
						DisableControlAction(0,21,true) -- disable sprint
						DisableControlAction(0, 24, true) -- Attack
						DisableControlAction(0, 257, true) -- Attack 2
						DisableControlAction(0, 25, true) -- Aim
						DisableControlAction(0, 263, true) -- Melee Attack 1
						DisableControlAction(0, 37, true) -- Select Weapon
						DisableControlAction(0, 56, true) -- F9
						DisableControlAction(0, 45, true) -- Reload
						DisableControlAction(0, 22, true) -- Jump
						DisableControlAction(0, 44, true) -- Cover
						DisableControlAction(0, 288, true) --F1
						DisableControlAction(0, 289, true) -- F2
						DisableControlAction(0, 170, true) -- F3
						DisableControlAction(0, 167, true) -- F6
						DisableControlAction(0, 26, true) -- Disable looking behind
						DisableControlAction(0, 73, true) -- Disable clearing animation
						DisableControlAction(2, 21, true) -- Disable going stealth
						DisableControlAction(0, 47, true)  -- Disable weapon
						DisableControlAction(0, 264, true) -- Disable melee
						DisableControlAction(0, 257, true) -- Disable melee
						DisableControlAction(0, 140, true) -- Disable melee
						DisableControlAction(0, 141, true) -- Disable melee
						DisableControlAction(0, 142, true) -- Disable melee
						DisableControlAction(0, 143, true) -- Disable melee
						DisableControlAction(0, 75, true)  -- Disable exit vehicle
						DisableControlAction(0, 301, true)  -- Disable exit vehicle
						DisableControlAction(27, 75, true) -- Disable exit vehicle
						DisableControlAction(0, 75, true) -- Disable exit vehicle
						DisableControlAction(0, 23, true)
						TaskWarpPedIntoVehicle(PlayerPedId(), spawnedVehicle, -1)
					end
					QBCore.Functions.DeleteVehicle(spawnedVehicle)
					SetEntityCoords(playerPed, Config.BuyCoord.x, Config.BuyCoord.y, Config.BuyCoord.z)
				end)
				QBCore.Functions.TriggerCallback('esx_vehicleshop:testCarPrice', function(sonuc)
					exports['qb-menu']:openMenu({
						{
							header = "Would you like to use the vehicle's Engine/Brake/Suspension/Turbo Features by Upgrading?",
							txt = "",
							icon = "fas fa-warehouse",
							isMenuHeader = true,
						},
						{
							header = "Yes, +1000$",
							txt = "",
							-- isServer = true,
							params = {
								functions = function()
									if sonuc then 
										AraciFulle()
									else
										QBCore.Functions.Notify("You Don't Have Enough Money!", 10000)
									end
								end
							}
						},
						{
							header = "No, I do not want",
							txt = "",
							params = {
								event = "qb-menu:closeMenu"
							}
						},
					})
				end)
			end
		end)
	else
		SendNUIMessage({type = 'notif', text = "Unable to Start Test Drive due to Nearby Vehicle!"})
	end
end)



local performanceModIndices = { 11, 12, 13, 15, 16 }
function PerformanceUpgradeVehicle(vehicle, customWheels)
    customWheels = customWheels or false
    local max
    if DoesEntityExist(vehicle) and IsEntityAVehicle(vehicle) then
        SetVehicleModKit(vehicle, 0)
        for _, modType in ipairs(performanceModIndices) do
            max = GetNumVehicleMods(vehicle, tonumber(modType)) - 1
            SetVehicleMod(vehicle, modType, max, customWheels)
        end
        ToggleVehicleMod(vehicle, 18, true) -- Turbo
	SetVehicleFixed(vehicle)
    end
end

function AraciFulle()
	local vehicle = GetVehiclePedIsIn(PlayerPedId())
	PerformanceUpgradeVehicle(vehicle)
	QBCore.Functions.Notify("All Features of Your Vehicle Have Been Upgraded, You Will Be able to Use Your Vehicle at the Highest Features for 120 Seconds.", 10000)
end