QBCore = nil
local spawn = false

CreateThread(function() 
    while QBCore == nil do
        TriggerEvent("QBCore:GetObject", function(obj) QBCore = obj end)    
        Wait(200)
    end
end)


-- Stops vehicles from spawning that cause issues in OneSync
Citizen.CreateThread(function()
	while true do
		Wait(3)
		SetVehicleDensityMultiplierThisFrame((TrafficAmount/100)+.0)
		SetPedDensityMultiplierThisFrame((PedestrianAmount/100)+.0)
		SetRandomVehicleDensityMultiplierThisFrame((TrafficAmount/100)+.0)
		SetParkedVehicleDensityMultiplierThisFrame((ParkedAmount/100)+.0)
		-- SetScenarioPedDensityMultiplierThisFrame((PedestrianAmount/100)+.0, (PedestrianAmount/100)+.0)
		SetScenarioPedDensityMultiplierThisFrame(50.0, 50.0) -- polis gibi npclerin çokluğu
		SetRandomBoats(EnableBoats)
		SetRandomTrains(EnableTrains)
        SetVehicleModelIsSuppressed(GetHashKey("rubble"), true)
        SetVehicleModelIsSuppressed(GetHashKey("dump"), true)
        SetVehicleModelIsSuppressed(GetHashKey("taco"), true)
        SetVehicleModelIsSuppressed(GetHashKey("biff"), true)
        SetVehicleModelIsSuppressed(GetHashKey("blimp"), true)
		local x = -1110.82
			local y = -809.05
			local z = 17.47
			ClearAreaOfVehicles(x, y, z, 1000, false, false, false, false, false)
			RemoveVehiclesFromGeneratorsInArea(x - 20, y - 20, z - 20, x + 20, y + 20, z + 20)
			-- tequila -556.81, 285.076, 82.1801
			local x = -556.81
			local y = 285.076
			local z = 82.1801
			ClearAreaOfVehicles(x, y, z, 1000, false, false, false, false, false)
			RemoveVehiclesFromGeneratorsInArea(x - 10, y - 10, z - 10, x + 10, y + 10, z + 10)
	
		-- pd
		local x = 441.89
		local y = -991.9
		local z = 29.73
		ClearAreaOfVehicles(x, y, z, 1000, false, false, false, false, false)
		RemoveVehiclesFromGeneratorsInArea(x - 50, y - 50, z - 50, x + 50, y + 50, z + 50)
	
		-- cardealer
		local x = -41.53
		local y = -1097.93
		local z = 26.42
		ClearAreaOfVehicles(x, y, z, 1000, false, false, false, false, false)
		RemoveVehiclesFromGeneratorsInArea(x - 10, y - 10, z - 10, x + 10, y + 10, z + 10)
		--pillbox
		local x = 329.396
		local y = -580.63
		local z = 43.2841
		ClearAreaOfVehicles(x, y, z, 1000, false, false, false, false, false)
		RemoveVehiclesFromGeneratorsInArea(x - 20, y - 20, z - 20, x + 20, y + 20, z + 20)
		--bağlanmışlar
		local x = 127.483
		local y = -1072.9
		local z = 29.1923
		ClearAreaOfVehicles(x, y, z, 1000, false, false, false, false, false)
		RemoveVehiclesFromGeneratorsInArea(x - 20, y - 20, z - 20, x + 20, y + 20, z + 20)

    end
end)

local otopark = {
    vector3(-356.84, -756.99, 33.3),
}

local carSpawnCoord = vector3(-356.98, -756.88, 33.97)

Citizen.CreateThread(function()
	while true do
		Wait(time)
		local time = 2500
		for i = 1, #otopark do
			local otopark = otopark[i]
			local ply = PlayerPedId()
			local plyCoords = GetEntityCoords(ply, 0)
			local distance = #(otopark - plyCoords)
			if spawn == false then
				if distance < 100 then
					time = 1
					if QBCore.Functions.IsSpawnPointClear(otopark, 2) then
						local random = math.random(1, 10)
						if random == 1 or random == 3 or random == 9 then
							TriggerEvent('arac:spawn')
							spawn = true
							Citizen.Wait((1000 * 60) * 5)
							spawn = false
						else
							spawn = true
							Citizen.Wait(1000 * 30)
							spawn = false
						end
					end
			else
				spawn = true
				Citizen.Wait(5000)
				spawn = false
				end
			end
		end
	end
end)



RegisterNetEvent('arac:spawn')
AddEventHandler('arac:spawn', function()
	local arac = zentorno
	local random = math.random(1, 4)
	if random == 1 then
		QBCore.Functions.SpawnVehicle('zentorno', function(veh)
			SetVehRadioStation(veh, 'OFF')
			SetVehicleModKit(veh, 0)
			SetVehicleColours(veh, 112, 55) --Renk
			SetVehicleMod(veh, 0, 6) --Spoiler
			SetVehicleExtraColours(veh, 35, 55) --Sedef, Jant rengi
			SetVehicleMod(veh, 23, false) --Jant
			SetVehicleMod(veh, 11, 1) --Motor
			SetVehicleMod(veh, 12, false) --Fren
			SetVehicleMod(veh, 16, false) --Zırh
			SetVehicleMod(veh, 13, false) --Süspansiyon
			SetVehicleMod(veh, 18, true) --Turbo
			SetVehicleMod(veh, 13, false) --Transmission
			SetVehicleMod(veh, 22, true) --Xenon ışık
			SetVehicleDoorsLocked(veh, 7)
		end, {x=carSpawnCoord.x, y=carSpawnCoord.y, z=carSpawnCoord.z, h=270.0 }, true)
	elseif random == 2 then
		QBCore.Functions.SpawnVehicle('massacro', function(veh)
			SetVehRadioStation(veh, 'OFF')
			SetVehicleModKit(veh, 0)
			SetVehicleColours(veh, 141, 55) --Renk
			SetVehicleMod(veh, 0, 3) --Spoiler
			SetVehicleExtraColours(veh, 35, 35) --Sedef, Jant rengi
			SetVehicleMod(veh, 23, 7, 11) --Jant
			SetVehicleMod(veh, 11, 1) --Motor
			SetVehicleMod(veh, 12, false) --Fren
			SetVehicleMod(veh, 16, false) --Zırh
			SetVehicleMod(veh, 13, false) --Süspansiyon
			SetVehicleMod(veh, 18, true) --Turbo
			SetVehicleMod(veh, 13, false) --Transmission
			SetVehicleMod(veh, 22, true) --Xenon ışık
			SetVehicleDoorsLocked(veh, 7)
		end, {x=carSpawnCoord.x, y=carSpawnCoord.y, z=carSpawnCoord.z, h=270.0 }, true)
	elseif random == 3 then
		QBCore.Functions.SpawnVehicle('jester', function(veh)
			SetVehRadioStation(veh, 'OFF')
			SetVehicleModKit(veh, 0)
			SetVehicleColours(veh, 120, 0) --Renk
			SetVehicleMod(veh, 0, 3) --Spoiler
			SetVehicleExtraColours(veh, 0, 0) --Sedef, Jant rengi
			SetVehicleMod(veh, 23, false) --Jant
			SetVehicleMod(veh, 11, 1) --Motor
			SetVehicleMod(veh, 12, false) --Fren
			SetVehicleMod(veh, 16, false) --Zırh
			SetVehicleMod(veh, 13, false) --Süspansiyon
			SetVehicleMod(veh, 18, true) --Turbo
			SetVehicleMod(veh, 13, false) --Transmission
			SetVehicleMod(veh, 22, true) --Xenon ışık
			SetVehicleDoorsLocked(veh, 7)
		end, {x=carSpawnCoord.x, y=carSpawnCoord.y, z=carSpawnCoord.z, h=270.0 }, true)
	elseif random == 4 then
		QBCore.Functions.SpawnVehicle('turismor', function(veh)
			SetVehRadioStation(veh, 'OFF')
			SetVehicleModKit(veh, 0)
			SetVehicleColours(veh, 28, 0) --Renk
			SetVehicleMod(veh, 0, 1) --Spoiler
			--SetVehicleExtraColours(veh, 35, 0) --Sedef, Jant rengi
			--SetVehicleMod(veh, 23, 7, 11) --Jant
			SetVehicleMod(veh, 11, 1) --Motor
			SetVehicleMod(veh, 12, false) --Fren
			SetVehicleMod(veh, 16, false) --Zırh
			SetVehicleMod(veh, 13, false) --Süspansiyon
			SetVehicleMod(veh, 18, true) --Turbo
			SetVehicleMod(veh, 13, false) --Transmission
			SetVehicleMod(veh, 22, true) --Xenon ışık
			SetVehicleDoorsLocked(veh, 7)
		end, {x=carSpawnCoord.x, y=carSpawnCoord.y, z=carSpawnCoord.z, h=270.0 }, true)
	end
end)