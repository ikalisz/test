-- local npcActive = true
-- local zombi = false
-- local kosetut = false



-- RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
-- AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
-- 	QBCore.Functions.TriggerCallback('check-npc-on', function(bool)
-- 		npcActive = bool
-- 	end)
-- end)



-- RegisterNetEvent('set-npc')
-- AddEventHandler('set-npc', function(bool)
-- 	npcActive = bool
-- end)



-- RegisterNetEvent('elixir-base:set-zombie')
-- AddEventHandler('elixir-base:set-zombie', function(bool)
-- 	zombi = bool
-- end)



-- local ClearAreaNpc = {
-- 	{x = 914.45, y = -1815.11, z = 24.97, r = 150.0}, -- Boks alanı
-- 	{x = 523.73, y = -3160.28, z = 8.51, r = 200.0}, -- Özel Güvenlik
-- }



-- Citizen.CreateThread(function()
-- 	while true do
-- 		Citizen.Wait(1000)
-- 		if playerPedCoords then
-- 			ClearAreaOfCops(playerPedCoords, 400.0, 0)
-- 			for i=1, #ClearAreaNpc do
-- 				if #(playerPedCoords - vector3(ClearAreaNpc[i].x, ClearAreaNpc[i].y, ClearAreaNpc[i].z)) < ClearAreaNpc[i].r then
-- 					ClearAreaOfPeds(ClearAreaNpc[i].x, ClearAreaNpc[i].y, ClearAreaNpc[i].z, ClearAreaNpc[i].r, 1)
-- 				end
-- 			end
-- 		end
-- 	end
-- end)


-- CreateThread(function()
-- 	while true do
-- 		if zombi or not npcActive then 
-- 			SetParkedVehicleDensityMultiplierThisFrame(0.0)
-- 			SetVehicleDensityMultiplierThisFrame(0.0)
-- 			SetRandomVehicleDensityMultiplierThisFrame(0.0)
-- 			SetPedDensityMultiplierThisFrame(0.0)
-- 			SetScenarioPedDensityMultiplierThisFrame(0.0, 0.0)
-- 	  	else
-- 			SetParkedVehicleDensityMultiplierThisFrame(0.1)
-- 			SetVehicleDensityMultiplierThisFrame(0.1)
-- 			SetRandomVehicleDensityMultiplierThisFrame(0.1)
-- 			SetPedDensityMultiplierThisFrame(0.1)
-- 			SetScenarioPedDensityMultiplierThisFrame(0.1, 0.1)
-- 			local x = -1110.82
-- 			local y = -809.05
-- 			local z = 17.47
-- 			ClearAreaOfVehicles(x, y, z, 1000, false, false, false, false, false)
-- 			RemoveVehiclesFromGeneratorsInArea(x - 20, y - 20, z - 20, x + 20, y + 20, z + 20);
-- 			-- tequila -556.81, 285.076, 82.1801
-- 			local x = -556.81
-- 			local y = 285.076
-- 			local z = 82.1801
-- 			ClearAreaOfVehicles(x, y, z, 1000, false, false, false, false, false)
-- 			RemoveVehiclesFromGeneratorsInArea(x - 10, y - 10, z - 10, x + 10, y + 10, z + 10);
	
-- 		-- pd
-- 		local x = 441.89
-- 		local y = -991.9
-- 		local z = 29.73
-- 		ClearAreaOfVehicles(x, y, z, 1000, false, false, false, false, false)
-- 		RemoveVehiclesFromGeneratorsInArea(x - 50, y - 50, z - 50, x + 50, y + 50, z + 50)
	
-- 		-- cardealer
-- 		local x = -41.53
-- 		local y = -1097.93
-- 		local z = 26.42
-- 		ClearAreaOfVehicles(x, y, z, 1000, false, false, false, false, false)
-- 		RemoveVehiclesFromGeneratorsInArea(x - 10, y - 10, z - 10, x + 10, y + 10, z + 10)
-- 		--pillbox
-- 		local x = 329.396
-- 		local y = -580.63
-- 		local z = 43.2841
-- 		ClearAreaOfVehicles(x, y, z, 1000, false, false, false, false, false)
-- 		RemoveVehiclesFromGeneratorsInArea(x - 20, y - 20, z - 20, x + 20, y + 20, z + 20)
-- 		--bağlanmışlar
-- 		local x = 127.483
-- 		local y = -1072.9
-- 		local z = 29.1923
-- 		ClearAreaOfVehicles(x, y, z, 1000, false, false, false, false, false)
-- 		RemoveVehiclesFromGeneratorsInArea(x - 20, y - 20, z - 20, x + 20, y + 20, z + 20)
-- 	  	end
-- 	  	Wait(0)
--   	end
-- end)



-- local MarkedPeds = {}

-- function IsModelValidPed(ped)
-- 	local eType = GetPedType(ped)
-- 	return eType ~= 0 and eType ~= 1 and eType ~= 3 and eType ~= 28 and not IsPedAPlayer(ped)
-- end

-- function IsPedValid(ped)
-- 	local scriptPed = false
-- 	for x, pedData in pairs(peds) do
-- 		if pedData.ped == ped and pedData.spawn then
-- 			scriptPed = true
-- 		end
-- 	end
--   	return not scriptPed and IsModelValidPed(ped) and not IsEntityAMissionEntity(ped) and NetworkGetEntityIsNetworked(ped) and not IsPedDeadOrDying(ped, 1)  and IsPedStill(ped) and IsEntityStatic(ped) and not IsPedInAnyVehicle(ped) and not IsPedUsingAnyScenario(ped)
-- end

-- Citizen.CreateThread(function()
--     while true do
-- 		local success
-- 		local handle, ped = FindFirstPed()
-- 		repeat
-- 			if IsPedValid(ped) and not MarkedPeds[ped] then
-- 				MarkedPeds[ped] = 1
-- 			end
-- 			success, ped = FindNextPed(handle)
-- 		until not success
-- 		EndFindPed(handle)
-- 		Citizen.Wait(2000)
--     end
-- end)

-- function DeleteRoguePed(pPed)
-- 	local owner = NetworkGetEntityOwner(pPed)
-- 	if owner == -1 or owner == PlayerId() then
-- 		DeleteEntity(pPed)
-- 	else
-- 		return NetworkGetNetworkIdFromEntity(pPed)
-- 	end
-- end

-- Citizen.CreateThread(function()
--     while true do
-- 		local toDelete = {}
-- 		local playerCoords = GetEntityCoords(PlayerPedId())

-- 		for ped, count in pairs(MarkedPeds) do
-- 			if ped and DoesEntityExist(ped) and IsPedValid(ped) then
-- 				local entitycoords = GetEntityCoords(ped)
-- 				if count >= 4 and #(entitycoords - playerCoords) <= 100.0 then
-- 					local deleteInfo = DeleteRoguePed(ped)
-- 					if deleteInfo then
-- 						toDelete[#toDelete+1] = deleteInfo
-- 					end
-- 				end
-- 				MarkedPeds[ped] = count + 1
-- 			else
-- 				MarkedPeds[ped] = nil
-- 			end
-- 		end

-- 		if #toDelete > 0 then
-- 			TriggerServerEvent('rogue', toDelete)
-- 		end

-- 		Citizen.Wait(3000)
--     end
-- end)

-- RegisterNetEvent('rogue:delete')
-- AddEventHandler('rogue:delete', function(toDeleteData)
-- 	for i=1, #toDeleteData do
-- 		local entity = NetworkGetEntityFromNetworkId(toDeleteData[i])
-- 		if DoesEntityExist(entity) then
-- 			DeleteEntity(entity)
-- 		end
-- 	end
-- end)


