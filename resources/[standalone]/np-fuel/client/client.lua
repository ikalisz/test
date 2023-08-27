-- Variables

local QBCore = exports['qb-core']:GetCoreObject()
local fuelSynced = false
local inBlacklisted = false
local inGasStation = false
local haveNozzle = false
local isNearPump = false
local NozzlePrice = Config.nozzleprice
local props = {
	'prop_gas_pump_1d',
	'prop_gas_pump_1a',
	'prop_gas_pump_1b',
	'prop_gas_pump_1c',
	'prop_vintage_pump',
	'prop_gas_pump_old2',
	'prop_gas_pump_old3',
}
local CurrentWeaponData = {}


-- Functions

local function ManageFuelUsage(vehicle)
	if not DecorExistOn(vehicle, Config.FuelDecor) then
		SetFuel(vehicle, math.random(200, 800) / 10)
	elseif not fuelSynced then
		SetFuel(vehicle, GetFuel(vehicle))
		fuelSynced = true
	end
	if IsVehicleEngineOn(vehicle) then
		SetFuel(vehicle, GetVehicleFuelLevel(vehicle) - Config.FuelUsage[Round(GetVehicleCurrentRpm(vehicle), 1)] * (Config.Classes[GetVehicleClass(vehicle)] or 1.0) / 10)
		SetVehicleEngineOn(veh, true, true, true)
	else
		SetVehicleEngineOn(veh, true, true, true)
	end
end

-- Threads

CreateThread(function()
	while true do
		Wait(500)

		local pumpObject, pumpDistance = FindNearestFuelPump()

		if pumpDistance < 5 then
			isNearPump = pumpObject
			currentCash = QBCore.Functions.GetPlayerData().money['cash']
			Wait(500)
		else
			isNearPump = false
			if haveNozzle == true then
				QBCore.Functions.Notify("$100 Penalty for Breaking the Pops", "error")
				TriggerServerEvent('np-fuel:server:Ceza')
				TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(PlayerId()), 'banka', "Benzity Operation Penalty", 100)
				DeleteEntity(Nozzle)
				DeleteObject(Nozzle)
				haveNozzle = false
			end
			Wait(2000)
		end
	end
end)

CreateThread(function()
	local bones = {
		"petroltank",
		"petroltank_l",
		"petroltank_r",
		"wheel_rf",
		"wheel_rr",
		"petrolcap ",
		"seat_dside_r",
		"engine",
		}
	exports['qb-target']:AddTargetBone(bones, {
		options = {
		{
			type = "client",
			event = "np-fuel:client:SendMenuToServer",
			icon = "fas fa-gas-pump",
			label = "Fill Vehicle with Gasoline",
			canInteract = function()
				return haveNozzle == true
			end
		}
	},
		distance = 1.5,
	})
end)

if Config.LeaveEngineRunning then
	CreateThread(function()
		while true do
			Wait(100)
			local ped = GetPlayerPed(-1)
			if DoesEntityExist(ped) and IsPedInAnyVehicle(ped, false) and IsControlPressed(2, 75) and not IsEntityDead(ped) and not IsPauseMenuActive() then
				local engineWasRunning = GetIsVehicleEngineRunning(GetVehiclePedIsIn(ped, true))
				Wait(1000)
				if DoesEntityExist(ped) and not IsPedInAnyVehicle(ped, false) and not IsEntityDead(ped) and not IsPauseMenuActive() then
					local veh = GetVehiclePedIsIn(ped, true)
					if engineWasRunning then
						SetVehicleEngineOn(veh, true, true, true)
					end
				end
			end
		end
	end)
end



CreateThread(function()
	DecorRegister(Config.FuelDecor, 1)
	for index = 1, #Config.Blacklist do
		if type(Config.Blacklist[index]) == 'string' then
			Config.Blacklist[GetHashKey(Config.Blacklist[index])] = true
		else
			Config.Blacklist[Config.Blacklist[index]] = true
		end
	end
	for index = #Config.Blacklist, 1, -1 do
		Config.Blacklist[index] = nil
	end
	while true do
		Wait(1000)
		local ped = PlayerPedId()
		if IsPedInAnyVehicle(ped) then
			local vehicle = GetVehiclePedIsIn(ped)
			if Config.Blacklist[GetEntityModel(vehicle)] then
				inBlacklisted = true
			else
				inBlacklisted = false
			end
			if not inBlacklisted and GetPedInVehicleSeat(vehicle, -1) == ped then
				ManageFuelUsage(vehicle)
			end
		else
			if fuelSynced then
				fuelSynced = false
			end
			if inBlacklisted then
				inBlacklisted = false
			end
		end
	end
end)

-- Client Events

RegisterNetEvent('np-fuel:client:SendMenuToServer', function()
	local vehicle = QBCore.Functions.GetClosestVehicle()
	local CurFuel = GetVehicleFuelLevel(vehicle)
	local refillCost = Round(Config.RefillCost - CurFuel) * Config.CostMultiplier
	local ped = PlayerPedId()
		if haveNozzle == true then
		    if CurFuel < 95 then
		     	TriggerServerEvent('np-fuel:server:OpenMenu', refillCost, inGasStation, false)
	     	else
			   QBCore.Functions.Notify("Vehicle Already Full of Gasoline", "error")
		    end
		else
			QBCore.Functions.Notify("You Have to Take the Pump to Fill Gas", "error")
		end
end)

RegisterNetEvent('np-fuel:client:RefuelVehicle', function(refillCost)
	local ped = PlayerPedId()
	local vehicle = QBCore.Functions.GetClosestVehicle()
	local ped = PlayerPedId()
	local CurFuel = GetFuel(vehicle)
	local time = (100 - CurFuel) * 600
	local vehicleCoords = GetEntityCoords(vehicle)
			if isCloseVeh() then
				if QBCore.Functions.GetPlayerData().money['cash'] <= refillCost then 
					QBCore.Functions.Notify("You Don't Have Enough Money", "error")
				else
				LoadAnimDict("timetable@gardener@filling_can")
				RequestAnimDict("friends@")
				while not HasAnimDictLoaded('friends@') do Wait(100) end
				TaskPlayAnim(ped, "friends@", "pickupwait", 8.0, 1.0, -1, 1, 0, 0, 0, 0 )
				TaskPlayAnim(ped, "timetable@gardener@filling_can", "gar_ig_5_filling_can", 2.0, 8.0, -1, 50, 0, false, false, false)

				if GetIsVehicleEngineRunning(vehicle) and Config.VehicleBlowUp then
					local Chance = math.random(1, 100)
				if Chance <= Config.BlowUpChance then
					AddExplosion(vehicleCoords, 5, 50.0, true, false, true)
						return
					end
				end
				--[[ TriggerEvent('np-fuel:deleteNozzle') ]]
				QBCore.Functions.Progressbar("refuel-car", "Filling Gasoline...", time, false, true, {
					disableMovement = true,
					disableCarMovement = true,
					disableMouse = false,
					disableCombat = true,
				}, {}, {}, {}, function() -- Done
					TriggerServerEvent('np-fuel:server:PayForFuel', refillCost, GetPlayerServerId(PlayerId()))
					SetFuel(vehicle, 100)
					PlaySound(-1, "5_SEC_WARNING", "HUD_MINI_GAME_SOUNDSET", 0, 0, 1)
					StopAnimTask(ped, "timetable@gardener@filling_can", "gar_ig_5_filling_can", 2.0, 8.0, -1, 50, 0, false, false, false)
					StopAnimTask(ped, "friends@", "pickupwait", 2.0, 8.0, -1, 50, 0, false, false, false)
					TriggerEvent('np-fuel:createNozzle')
					QBCore.Functions.Notify("Benzin Dolduruldu, Don't Forget to Drop the Pump Back!", "primary")
				end, function() -- Cancel
					QBCore.Functions.Notify("Refueling Canceled", "error")
					TriggerEvent('np-fuel:createNozzle')
					StopAnimTask(ped, "timetable@gardener@filling_can", "gar_ig_5_filling_can", 2.0, 8.0, -1, 50, 0, false, false, false)
					StopAnimTask(ped, "friends@", "pickupwait", 2.0, 8.0, -1, 50, 0, false, false, false)
					end)
				end
			end
end)

-- fuel Nozzle

RegisterNetEvent('np-fuel:createNozzle', function (model)
	local ped = PlayerPedId()
	local model = 'prop_cs_fuel_nozle'
	local boneId = 60309
	local modelHash = type(model) == 'string' and GetHashKey(model) or model
    local bone = GetPedBoneIndex(ped, boneId)

	if haveNozzle == false then
    QBCore.Functions.LoadModel(modelHash)
    Nozzle = CreateObject(modelHash, -50.0, -50.0, 5.0, 4, 10)
    AttachEntityToEntity(Nozzle, ped, bone, 0.04, 0.0, 0.03, 10.0, 240.0, -100.0, false, false, false, false, 2, true)
    SetModelAsNoLongerNeeded(modelHash)
	haveNozzle = true
	QBCore.Functions.Notify("You Got the Pump")
	end
end)

RegisterNetEvent('np-fuel:deleteNozzle', function ()
	if haveNozzle == true then
    DeleteEntity(Nozzle)
	DeleteObject(Nozzle)
	haveNozzle = false
	QBCore.Functions.Notify('Gas Pump Released', 'info', 7500)
	end
end)

RegisterNetEvent('np-fuel:pumpmenu', function ()
        local myMenu = {
                {
                    header = "Gas Station",
					icon = "fas fa-gas-pump",
                    txt = "If you walk away without releasing the pump, you will be fined.!",
                    isMenuHeader = true
                },
                {
                    id = 1,
                    header = "Get Gas Pump",
					icon = "fas fa-hand-holding",
                    txt = "",
                    params = {
                        event = "np-fuel:createNozzle",
                    }
                },
				{
                    id = 1,
                    header = "Drop the Gas Pump",
					icon = "fas fa-sign-out-alt",
                    txt = "",
                    params = {
                        event = "np-fuel:deleteNozzle",
                    }
                },
                {
                    id = 7,
                    header = 'Close Menu',
					icon = "fas fa-times-square",
                    params = {
                        event = 'qb-menu:client:closeMenu',
                    }
                },
            }
            exports['qb-menu']:openMenu(myMenu)

end)

-- Target Export

exports['qb-target']:AddTargetModel(props, {
	options = {
		{
			type = "client",
			event = "np-fuel:pumpmenu",
			icon = "fas fa-burn",
			label = "Petrol Pump",
			
		},
	},
	distance = 2.0
})


GasStations = {
	vector3(49.4187, 2778.793, 58.043),
	vector3(263.894, 2606.463, 44.983),
	vector3(1039.958, 2671.134, 39.550),
	vector3(1207.260, 2660.175, 37.899),
	vector3(2539.685, 2594.192, 37.944),
	vector3(2679.858, 3263.946, 55.240),
	vector3(2005.055, 3773.887, 32.403),
	vector3(1687.156, 4929.392, 42.078),
	vector3(1701.314, 6416.028, 32.763),
	vector3(179.857, 6602.839, 31.868),
	vector3(-94.4619, 6419.594, 31.489),
	vector3(-2554.996, 2334.40, 33.078),
	vector3(-1800.375, 803.661, 138.651),
	vector3(-1437.622, -276.747, 46.207),
	vector3(-2096.243, -320.286, 13.168),
	vector3(-724.619, -935.1631, 19.213),
	vector3(-526.019, -1211.003, 18.184),
	vector3(-70.2148, -1761.792, 29.534),
	vector3(265.648, -1261.309, 29.292),
	vector3(819.653, -1028.846, 26.403),
	vector3(1208.951, -1402.567,35.224),
	vector3(1181.381, -330.847, 69.316),
	vector3(620.843, 269.100, 103.089),
	vector3(2581.321, 362.039, 108.468),
	vector3(176.631, -1562.025, 29.263),
	vector3(176.631, -1562.025, 29.263),
	vector3(-319.292, -1471.715, 30.549),
	vector3(1784.324, 3330.55, 41.253),
}



local aktifblipler = {}
local blip = false
RegisterNetEvent("LegacyFuel:blipAcKapa")
AddEventHandler("LegacyFuel:blipAcKapa", function()
	if blip then
		pasifblip()
		exports["elix1rBase"]:SendAlert('Gas Station Blips Closed', 'error', 2500)
		blip = false
	else
		aktifblip()
		exports["elix1rBase"]:SendAlert('Gas Station Blips Opened', 'success', 2500)
		blip = true
	end
end)

function aktifblip()
	for i=1, #GasStations do
		local blip = AddBlipForCoord(GasStations[i])
		SetBlipSprite(blip, 361)
		SetBlipScale(blip, 0.5)
		SetBlipColour(blip, 1)
		SetBlipDisplay(blip, 4)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Gas Station")
		EndTextCommandSetBlipName(blip)
		table.insert(aktifblipler, blip)
	end
end

function pasifblip()
	for i=1, #aktifblipler do
		RemoveBlip(aktifblipler[i])
	end
	aktifblipler = {}
end