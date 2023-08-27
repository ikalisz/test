local HasAlreadyEnteredMarker, LastZone = false, nil
local CurrentAction, CurrentActionMsg, CurrentActionData = nil, '', {}
local CurrentlyTowedVehicle, Blips, NPCOnJob, NPCTargetTowable, NPCTargetTowableZone = nil, {}, false, nil, nil
local NPCHasSpawnedTowable, NPCLastCancel, NPCHasBeenNextToTowable = false, GetGameTimer(), false
local PlayerData = {}

QBCore = nil
Citizen.CreateThread(function()
    while QBCore == nil do
        TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)
        Citizen.Wait(200)
    end
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    PlayerData = QBCore.Functions.GetPlayerData()
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate')
AddEventHandler('QBCore:Client:OnJobUpdate', function(job)
	PlayerData.job = job
end)

function SelectRandomTowable()
	if PlayerData.job ~= nil and PlayerData.job.name ~= 'unemployed' and (PlayerData.job.name == "mechanic" or PlayerData.job.name == "mechanic_gabz" or PlayerData.job.name == "mechanic_hayes" or PlayerData.job.name == "mechanic_bennys") then
		return Config.Towables[math.random(1, #Config.Towables)]
	end
end

function StartNPCJob()
	NPCOnJob = true
	NPCTargetTowableZone = SelectRandomTowable()

	Blips['NPCTargetTowableZone'] = AddBlipForCoord(NPCTargetTowableZone.x, NPCTargetTowableZone.y, NPCTargetTowableZone.z)
	SetBlipRoute(Blips['NPCTargetTowableZone'], true)

	QBCore.Functions.Notify("The vehicle to be brought into service is marked.")
end

function StopNPCJob(cancel)
	if Blips['NPCTargetTowableZone'] then
		RemoveBlip(Blips['NPCTargetTowableZone'])
		Blips['NPCTargetTowableZone'] = nil
	end

	if Blips['NPCDelivery'] then
		RemoveBlip(Blips['NPCDelivery'])
		Blips['NPCDelivery'] = nil
	end

	NPCOnJob                = false
	NPCTargetTowable        = nil
	NPCTargetTowableZone    = nil
	NPCHasSpawnedTowable    = false
	NPCHasBeenNextToTowable = false

	if cancel then
		QBCore.Functions.Notify('Mission canceled')
		NPCLastCancel = GetGameTimer() * 300000
	end
end

function OpenMechanicActionsMenu()
	QBCore.UI.Menu.CloseAll()
	local elements = {{label = 'Mechanic Service Tool List', value = 'vehicle_list'}}

	if PlayerData.job and PlayerData.job.boss then
		table.insert(elements, {label = "Boss Actions", value = 'boss_actions'})
	end
	
	QBCore.UI.Menu.Open('default', GetCurrentResourceName(), 'mechanic_actions', {
		title    = "Mechanic",
		align    = 'top-left',
		elements = elements
	}, function(data, menu)
		if data.current.value == 'vehicle_list' then
			local elements = {
				{label = 'Vehicle Carrier',  value = 'flatbed'},
				{label = 'Small Attractor', value = 'towtruck2'}
			}
			if PlayerData.job.boss then
				table.insert(elements, {label = 'Slam Van', value = 'slamvan3'})
			end

			QBCore.UI.Menu.CloseAll()
			QBCore.UI.Menu.Open('default', GetCurrentResourceName(), 'spawn_vehicle', {
				title    = 'Service Tools',
				align    = 'top-left',
				elements = elements
			}, function(data, menu)
				QBCore.Functions.SpawnVehicle(data.current.value, function(vehicle)
					local playerPed = PlayerPedId()
					TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
					TriggerEvent("x-hotwire:give-keys", vehicle)
				end, {x = Config.Zones[PlayerData.job.name].VehicleSpawnPoint.x, y= Config.Zones[PlayerData.job.name].VehicleSpawnPoint.y, z= Config.Zones[PlayerData.job.name].VehicleSpawnPoint.z, h= 90.0}, true)
			
				menu.close()
			end, function(data, menu)
				menu.close()
				OpenMechanicActionsMenu()
			end)
		elseif data.current.value == 'boss_actions' then
			TriggerEvent('esx_society:openBossMenu', PlayerData.job.name, function(data, menu)
				menu.close()
			end)
			
		end
	end, function(data, menu)
		menu.close()

	end)
end

local bussy = true
RegisterNetEvent('tgiann-meslekmekanik:tamirkiti')
AddEventHandler('tgiann-meslekmekanik:tamirkiti', function(item)
	if bussy then
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)

		if IsPedInAnyVehicle(playerPed, false) then
			QBCore.Functions.Notify("You Can't Repair the Engine From Inside the Vehicle")
			return
		else
			vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
		end
		
		local motorcani = GetVehicleEngineHealth(vehicle)
		local kaput = GetEntityBoneIndexByName(vehicle, 'engine')
		local kaputkordinat = GetWorldPositionOfEntityBone(vehicle, kaput)
		
		if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), kaputkordinat, true) <= 2.3 then
			if motorcani < 999 then
				if DoesEntityExist(vehicle) then
					bussy = false
					SetVehicleEngineOn(vehicle, false, false)
					SetVehicleDoorOpen(vehicle, 4, 0, 0)
					TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_BUM_BIN", 0, true)
					if math.random(1,4) == 1 then
						TriggerServerEvent("tgiann-meslekmekanik:kitsil", item)
					end
					if item == "tamirkiti" then -- gelişmiş
						local finished = exports["tgiann-skillbar"]:taskBar(85000,math.random(12,16))
						if finished then
							local finished2 = exports["tgiann-skillbar"]:taskBar(65000,math.random(10,12))
							if finished2 then
								local finished3 = exports["tgiann-skillbar"]:taskBar(45000,math.random(11,12))
							if finished3 then
								local finished4 = exports["tgiann-skillbar"]:taskBar(30000,math.random(8,11))
								if finished4 then
								QBCore.Functions.Notify('Repair Successful!', 'success')
								TriggerEvent("iens:motortamiret",vehicle ,1000.0)
								SetVehicleUndriveable(vehicle, false)	
								SetVehicleFixed(vehicle)
								SetVehicleTyreFixed(vehicle, 0)
								SetVehicleWheelHealth(vehicle, 0, 100.0)

								SetVehicleTyreFixed(vehicle, 1)
								SetVehicleWheelHealth(vehicle, 1, 100.0)

								SetVehicleTyreFixed(vehicle, 4)
								SetVehicleWheelHealth(vehicle, 4, 100.0)

								SetVehicleTyreFixed(vehicle, 5)
								SetVehicleWheelHealth(vehicle, 5, 100.0)
							end
						end
					end
				end

					elseif item == "fixkit" then -- normal kit
						local finished = exports["tgiann-skillbar"]:taskBar(35000,math.random(13,16))
						if finished then
							local finished2 = exports["tgiann-skillbar"]:taskBar(25000,math.random(10,13))
							if finished2 then
								local finished3 = exports["tgiann-skillbar"]:taskBar(10000,math.random(8,11))
							if finished3 then
								QBCore.Functions.Notify('Repair Successful!', 'success')
								TriggerEvent("iens:motortamiret",vehicle ,700.0)
								SetVehicleUndriveable(vehicle, false)	
							end
						end
					end
				end
					Citizen.Wait(2000)
					ClearPedTasksImmediately(playerPed)
					SetVehicleDoorShut(vehicle, 4, 0)
					bussy = true
				end
			else
				QBCore.Functions.Notify("Engine Is Already Running")
			end
		else
			QBCore.Functions.Notify("You Need To Be Close To The Engine For Repair")
		end
	end
end)

-- Pop NPC mission vehicle when inside area
Citizen.CreateThread(function()
	while true do
		if NPCTargetTowableZone and not NPCHasSpawnedTowable then
			local playerCoords = GetEntityCoords(PlayerPedId())
			if #(playerCoords - NPCTargetTowableZone) < Config.NPCSpawnDistance then
				local model = Config.Vehicles[math.random(1, #Config.Vehicles)]
				QBCore.Functions.SpawnVehicle(model, function(vehicle)
					NPCTargetTowable = vehicle
				end, {x = NPCTargetTowableZone.x, y = NPCTargetTowableZone.y, z = NPCTargetTowableZone.z, h = 0}, true)
				NPCHasSpawnedTowable = true
			end
		end

		if NPCTargetTowableZone and NPCHasSpawnedTowable and not NPCHasBeenNextToTowable then
			local playerCoords = GetEntityCoords(PlayerPedId())
			if #(playerCoords - NPCTargetTowableZone) < Config.NPCNextToDistance then
				QBCore.Functions.Notify('here is the vehicle, please load the vehicle on the vehicle carrier')
				NPCHasBeenNextToTowable = true
			end
		end
		Citizen.Wait(1000)
	end
end)

-- Create Blips
Citizen.CreateThread(function()
	for i=1, #Config.Blips do
		local mechanic = AddBlipForCoord(Config.Blips[i].coord)
		SetBlipSprite (mechanic, 446)
		SetBlipDisplay(mechanic, 4)
		SetBlipScale  (mechanic, 0.6)
		SetBlipColour (mechanic, Config.Blips[i].colour)
		SetBlipAsShortRange(mechanic, true)
	
		BeginTextCommandSetBlipName('STRING')
		AddTextComponentSubstringPlayerName(Config.Blips[i].name)
		EndTextCommandSetBlipName(mechanic)
	end
end)

local playerPed = PlayerPedId()
local playerCoord = GetEntityCoords(playerPed)
Citizen.CreateThread(function()
	while true do
		playerPed = PlayerPedId()
		playerCoord = GetEntityCoords(playerPed)
		Citizen.Wait(500)
	end
end)

-- Display markers
Citizen.CreateThread(function()
	for job, data in pairs(Config.Zones) do
		exports["elixir-base"]:addNotif("E", "Mechanic Operations", 2, 1, Config.Zones[job].MechanicActions, false, job, true)
	end

	for job, data in pairs(Config.Zones) do
		exports["elixir-base"]:addNotif("E", "Put Profession Tool in Garage", 5, 3, Config.Zones[job].VehicleSpawnPoint, true, job, true)
	end

	for job, data in pairs(Config.Zones) do
		exports["elixir-base"]:addNotif("E", "Depo", 3, 1, Config.Zones[job].Stash, false, job, true)
	end
end)


RegisterNetEvent('mechanicKeybindGeneral')
AddEventHandler('mechanicKeybindGeneral', function(job)
	if IsPedInAnyVehicle(playerPed) then
		local vehicle = GetVehiclePedIsIn(playerPed, false)
		if #(Config.Zones[job].VehicleSpawnPoint - playerCoord) < 3 then
			if GetEntityModel(vehicle) == `flatbed` or GetEntityModel(vehicle) == `towtruck2` or GetEntityModel(vehicle) == `slamvan3` then
				TriggerServerEvent('esx_service:disableService', 'mechanic')
				QBCore.Functions.DeleteVehicle(vehicle)
			end
		end
	end

	if #(Config.Zones[job].MechanicActions - playerCoord) < 1 then
		OpenMechanicActionsMenu()
	end

	if #(Config.Zones[job].Stash - playerCoord) < 1 then
		TriggerEvent("inventory:client:SetCurrentStash", "stash"..job, QBCore.Key)
		TriggerServerEvent("inventory:server:OpenInventory", "stash", "stash"..job, {maxweight = 1000000,slots = 50})
	end
end)

RegisterNetEvent('mechanicKeybindGeneralDelete')
AddEventHandler('mechanicKeybindGeneralDelete', function(job)
	if NPCOnJob then
		StopNPCJob(true)
	else
		local playerPed = PlayerPedId()
		if IsPedInAnyVehicle(playerPed, false) and IsVehicleModel(GetVehiclePedIsIn(playerPed, false), `flatbed`) then
			if GetGameTimer() > NPCLastCancel then
				StartNPCJob()
			else
				QBCore.Functions.Notify('Try Again In 5 Minutes!', 'error')
			end
		else
			QBCore.Functions.Notify('You must be in the Tow Truck to Start the Mission!', 'error')
		end
	end
end)

RegisterNetEvent('tgiann-meslekmekanik:TgiannFatura')
AddEventHandler('tgiann-meslekmekanik:TgiannFatura', function(closestPlayer)
	QBCore.UI.Menu.Open('dialog', GetCurrentResourceName(), 'billing', {
		title = 'Invoice Amount'
	}, function(data, menu)
		local amount = tonumber(data.value)

		if amount == nil or amount < 0 then
			QBCore.Functions.Notify('Invalid Amount')
		else
			local closestPlayer, closestDistance = QBCore.Functions.GetClosestPlayer()
			if closestPlayer == -1 or closestDistance > 3.0 then
				QBCore.Functions.Notify('No players found recently')
			else
				menu.close()
				TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(closestPlayer), PlayerData.job.name, "Mekanik", amount)
			end
		end
	end, function(data, menu)
		menu.close()
	end)	
end)

RegisterNetEvent('tgiann-meslekmekanik:yukleyici')
AddEventHandler('tgiann-meslekmekanik:yukleyici', function(targetVehicle)
	local playerPed = PlayerPedId()
	local vehicle = GetVehiclePedIsIn(playerPed, true)
	local towmodel = `flatbed`
	local isVehicleTow = IsVehicleModel(vehicle, towmodel)

	if isVehicleTow then
		if CurrentlyTowedVehicle == nil then
			if targetVehicle ~= 0 then
				if not IsPedInAnyVehicle(playerPed, true) then
					if vehicle ~= targetVehicle then
						AttachEntityToEntity(targetVehicle, vehicle, 20, -0.5, -5.0, 1.0, 0.0, 0.0, 0.0, false, false, false, false, 20, true)
						CurrentlyTowedVehicle = targetVehicle
						QBCore.Functions.Notify('Vehicle Loaded on Tow Truck')

						if NPCOnJob then
							if NPCTargetTowable == targetVehicle then
								QBCore.Functions.Notify('Take the Vehicle to the Location Specified on the Map and Download it from the Vehicle!')
								
								if Blips['NPCTargetTowableZone'] then
									RemoveBlip(Blips['NPCTargetTowableZone'])
									Blips['NPCTargetTowableZone'] = nil
								end
	
								Blips['NPCDelivery'] = AddBlipForCoord(Config.VehicleDelivery.x, Config.VehicleDelivery.y, Config.VehicleDelivery.z)
							
								SetBlipRoute(Blips['NPCDelivery'], true)
							end
						end
					else
						QBCore.Functions.Notify('You Cannot Load the Tow Truck on the Tow Truck')
					end
				end
			else
				QBCore.Functions.Notify('No Vehicles to be Installed Soon')
			end
		else
			AttachEntityToEntity(CurrentlyTowedVehicle, vehicle, 20, -0.5, -12.0, 1.0, 0.0, 0.0, 0.0, false, false, false, false, 20, true)
			DetachEntity(CurrentlyTowedVehicle, true, true)

			if NPCOnJob then
				if Config.VehicleDeliveryPolyZone:isPointInside(GetEntityCoords(playerPed)) then
					if CurrentlyTowedVehicle == NPCTargetTowable then
						QBCore.Functions.DeleteVehicle(NPCTargetTowable)
						TriggerServerEvent('tgiann-meslekmekanik:onNPCJobMissionCompleted', QBCore.Key)
						StopNPCJob()
					else
						QBCore.Functions.Notify('This Is Not The Right Tool!')
					end
				end
			end

			CurrentlyTowedVehicle = nil
			QBCore.Functions.Notify('Tool Downloaded Successfully!')
		end
	else
		QBCore.Functions.Notify('There must be a tow truck soon to load the vehicle on the tow truck')
	end
end)