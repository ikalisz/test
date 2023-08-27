local karakterYuklendi = false
local Plakalar = {}

QBCore = nil
Citizen.CreateThread(function() 
	while QBCore == nil do
		TriggerEvent("QBCore:GetObject", function(obj) QBCore = obj end)    
		Citizen.Wait(200)
	end
end)

RegisterNetEvent('elixir-base:araclarim')
AddEventHandler('elixir-base:araclarim', function(plaka)
	for i=1, #plaka do
		Plakalar[plaka[i].plate] = true
	end	
	karakterYuklendi = true
end)

--[[ RegisterCommand("sa", function()
	QBCore.Functions.TriggerCallback('tgiann-arackilit:araclarim', function(plaka)
		for i=1, #plaka do
			Plakalar[plaka[i].plate] = true
		end	
	end)
end) ]]

Citizen.CreateThread(function()
	RegisterKeyMapping('+carLock', 'Vehicle Lock', 'keyboard', 'l')
end)

RegisterCommand("+carLock", function()
	if not exports["high_phone"]:phoneIsOpen() then 
		local playerped = PlayerPedId()
		local kordinat = GetEntityCoords(playerped)
		local arac, mesafe = QBCore.Functions.GetClosestVehicle(kordinat)

		if mesafe <= 20.0 then
			local Plate = QBCore.Shared.Trim(GetVehicleNumberPlateText(arac))
			if Plakalar[Plate] then
				LockVehicle(arac, Plate)
			end
		end
	else
		QBCore.Functions.Notify("You can't lock your car while the phone is on")
	end
end, false)

function LockVehicle(veh, plate)
	if IsPedInAnyVehicle(PlayerPedId()) then
        veh = GetVehiclePedIsIn(PlayerPedId())
	end
	
	local vehLockStatus = GetVehicleDoorLockStatus(veh)

	QBCore.Shared.RequestAnimDict('anim@mp_player_intmenu@key_fob@', function()
		TaskPlayAnim(PlayerPedId(), 'anim@mp_player_intmenu@key_fob@', 'fob_click', 3.0, 3.0, -1, 49, 0, false, false, false)
	end)




	if vehLockStatus == 1 then
		Citizen.Wait(750)
		ClearPedTasks(PlayerPedId())
		TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 7.0, 'lock', 2.0)
		TriggerServerEvent("tgiann-arackilit:lock-car-server", 2, plate)
		SetVehicleDoorsLocked(veh, 2)
		if(GetVehicleDoorLockStatus(veh) == 2)then
			QBCore.Functions.Notify("Vehicle Locked", "primary")
		else
			QBCore.Functions.Notify("There is a problem with the lock system notify the authoritiesn")
		end
	else
		Citizen.Wait(750)
		ClearPedTasks(PlayerPedId())
		TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 7.0, 'lock', 2.0)
		TriggerServerEvent("tgiann-arackilit:lock-car-server", 1, plate)
		SetVehicleDoorsLocked(veh, 1)
		if(GetVehicleDoorLockStatus(veh) == 1)then
			QBCore.Functions.Notify("Vehicle Unlocked", "success")
		else
			QBCore.Functions.Notify("There is a problem with the lock system, report it to the authorities")
		end
	end

	if not IsPedInAnyVehicle(PlayerPedId()) then
		SetVehicleInteriorlight(veh, true)
		SetVehicleIndicatorLights(veh, 0, true)
		SetVehicleIndicatorLights(veh, 1, true)
		Citizen.Wait(450)
		SetVehicleIndicatorLights(veh, 0, false)
		SetVehicleIndicatorLights(veh, 1, false)
		Citizen.Wait(450)
		SetVehicleInteriorlight(veh, true)
		SetVehicleIndicatorLights(veh, 0, true)
		SetVehicleIndicatorLights(veh, 1, true)
		Citizen.Wait(450)
		SetVehicleInteriorlight(veh, false)
		SetVehicleIndicatorLights(veh, 0, false)
		SetVehicleIndicatorLights(veh, 1, false)
	end

end

RegisterNetEvent('tgiann-arackilit:lock-car')
AddEventHandler('tgiann-arackilit:lock-car', function(durum, plaka)
	if karakterYuklendi then
		local gameVehicles = QBCore.Functions.GetVehicles()
		for i = 1, #gameVehicles do
			local arac = gameVehicles[i]
			if DoesEntityExist(arac) then
				if QBCore.Shared.Trim(GetVehicleNumberPlateText(arac)) == plaka then
					SetVehicleDoorsLocked(arac, durum)
					break
				end
			end
		end	
	end
end)

RegisterNetEvent('tgiann-arackilit:plakaekle')
AddEventHandler('tgiann-arackilit:plakaekle', function(yeniplaka)
	local plaka = QBCore.Shared.Trim(yeniplaka)
	if Plakalar[plaka] == nil then
		Plakalar[plaka] = true
	end
end)