-- QBCore Command Events
RegisterNetEvent('QBCore:Command:TeleportToPlayer')
AddEventHandler('QBCore:Command:TeleportToPlayer', function(coords)
	local entity = PlayerPedId()
	if IsPedInAnyVehicle(entity, false) then
		entity = GetVehiclePedIsUsing(entity)
	end
	SetEntityCoords(entity, coords)
end)

RegisterNetEvent('QBCore:Command:TeleportToCoords')
AddEventHandler('QBCore:Command:TeleportToCoords', function(x, y, z)
	local entity = PlayerPedId()
	if IsPedInAnyVehicle(entity, false) then
		entity = GetVehiclePedIsUsing(entity)
	end
	SetEntityCoords(entity, x, y, z)
end)

RegisterNetEvent('QBCore:Command:SpawnVehicle')
AddEventHandler('QBCore:Command:SpawnVehicle', function(model, sahip)
	local coords = GetEntityCoords(PlayerPedId())
	local heading = GetEntityHeading(PlayerPedId())
	if not IsModelValid(model) then 
		QBCore.Functions.Notify(model.. "Named Vehicle Not Found", "error")
		return 
	end
	QBCore.Functions.SpawnVehicle(model, function(vehicle)
		if sahip ~= nil then 
			TriggerServerEvent("giveSpawnVehicle", QBCore.Functions.GetVehicleProperties(vehicle), vehicle)
		end
		TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
		TriggerEvent("x-hotwire:give-keys", vehicle)
	end, {x= coords.x, y= coords.y, z= coords.z, h= heading}, true)
end)



RegisterNetEvent('QBCore:Command:DeleteVehicle')
AddEventHandler('QBCore:Command:DeleteVehicle', function(radius)
	local playerPed = PlayerPedId()

	if radius and tonumber(radius) then
		radius = tonumber(radius) + 0.01
		local vehicles = QBCore.Functions.GetVehiclesInArea(GetEntityCoords(playerPed), radius)

		for k,entity in ipairs(vehicles) do
			local attempt = 0

			while not NetworkHasControlOfEntity(entity) and attempt < 100 and DoesEntityExist(entity) do
				Citizen.Wait(100)
				NetworkRequestControlOfEntity(entity)
				attempt = attempt + 1
			end

			if DoesEntityExist(entity) and NetworkHasControlOfEntity(entity) then
				QBCore.Functions.DeleteVehicle(entity)
			end
		end
	else
		local vehicle, attempt = QBCore.Functions.GetVehicleInDirection(), 0

		if IsPedInAnyVehicle(playerPed, true) then
			vehicle = GetVehiclePedIsIn(playerPed, false)
		end

		while not NetworkHasControlOfEntity(vehicle) and attempt < 100 and DoesEntityExist(vehicle) do
			Citizen.Wait(100)
			NetworkRequestControlOfEntity(vehicle)
			attempt = attempt + 1
		end

		if DoesEntityExist(vehicle) and NetworkHasControlOfEntity(vehicle) then
			QBCore.Functions.DeleteVehicle(vehicle)
		end
	end

end)

RegisterNetEvent('QBCore:Command:Revive')
AddEventHandler('QBCore:Command:Revive', function()
	local coords = QBCore.Functions.GetCoords(PlayerPedId())
	NetworkResurrectLocalPlayer(coords.x, coords.y, coords.z+0.2, coords.a, true, false)
	SetPlayerInvincible(PlayerPedId(), false)
	ClearPedBloodDamage(PlayerPedId())
end)

RegisterNetEvent('QBCore:Command:GoToMarker')
AddEventHandler('QBCore:Command:GoToMarker', function()
	Citizen.CreateThread(function()
		local entity = PlayerPedId()
		if IsPedInAnyVehicle(entity, false) then
			entity = GetVehiclePedIsUsing(entity)
		end
		local success = false
		local blipFound = false
		local blipIterator = GetBlipInfoIdIterator()
		local blip = GetFirstBlipInfoId(8)

		while DoesBlipExist(blip) do
			if GetBlipInfoIdType(blip) == 4 then
				cx, cy, cz = table.unpack(Citizen.InvokeNative(0xFA7C7F0AADF25D09, blip, Citizen.ReturnResultAnyway(), Citizen.ResultAsVector())) --GetBlipInfoIdCoord(blip)
				blipFound = true
				break
			end
			blip = GetNextBlipInfoId(blipIterator)
		end

		if blipFound then
			DoScreenFadeOut(250)
			while IsScreenFadedOut() do
				Citizen.Wait(250)
			end
			local groundFound = false
			local yaw = GetEntityHeading(entity)
			
			for i = 0, 1000, 1 do
				SetEntityCoordsNoOffset(entity, cx, cy, ToFloat(i), false, false, false)
				SetEntityRotation(entity, 0, 0, 0, 0 ,0)
				SetEntityHeading(entity, yaw)
				SetGameplayCamRelativeHeading(0)
				Citizen.Wait(0)
				--groundFound = true
				if GetGroundZFor_3dCoord(cx, cy, ToFloat(i), cz, false) then --GetGroundZFor3dCoord(cx, cy, i, 0, 0) GetGroundZFor_3dCoord(cx, cy, i)
					cz = ToFloat(i)
					groundFound = true
					break
				end
			end
			if not groundFound then
				cz = -300.0
			end
			success = true
		else
			TriggerEvent('esx:showNotification', "~w~Zet een locatie neer waar ~y~ik ~w~heen moet toveren!")
		end

		if success then
			SetEntityCoordsNoOffset(entity, cx, cy, cz, false, false, true)
			SetGameplayCamRelativeHeading(0)
			if IsPedSittingInAnyVehicle(PlayerPedId()) then
				if GetPedInVehicleSeat(GetVehiclePedIsUsing(PlayerPedId()), -1) == PlayerPedId() then
					SetVehicleOnGroundProperly(GetVehiclePedIsUsing(PlayerPedId()))
				end
			end
			--HideLoadingPromt()
			DoScreenFadeIn(250)
		end
	end)
end)


-- Other stuff
RegisterNetEvent('QBCore:Player:SetPlayerData')
AddEventHandler('QBCore:Player:SetPlayerData', function(val)
	QBCore.PlayerData = val
end)

RegisterNetEvent('QBCore:Player:UpdatePlayerData')
AddEventHandler('QBCore:Player:UpdatePlayerData', function()
	local data = {}
	data.position = QBCore.Functions.GetCoords(PlayerPedId())
	TriggerServerEvent('QBCore:UpdatePlayer', data)
end)

RegisterNetEvent('QBCore:Player:UpdatePlayerPosition')
AddEventHandler('QBCore:Player:UpdatePlayerPosition', function()
	local position = QBCore.Functions.GetCoords(PlayerPedId())
	TriggerServerEvent('QBCore:UpdatePlayerPosition', position)
end)

RegisterNetEvent('QBCore:Client:LocalOutOfCharacter')
AddEventHandler('QBCore:Client:LocalOutOfCharacter', function(playerId, playerName, message)
	local sourcePos = GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(playerId)), false)
    local pos = GetEntityCoords(GetPlayerPed(-1), false)
    if (GetDistanceBetweenCoords(pos.x, pos.y, pos.z, sourcePos.x, sourcePos.y, sourcePos.z, true) < 20.0) then
		TriggerEvent("chatMessage", "OOC | " .. playerName .. " ["..playerId.."]", "ooc", message)
    end
end)

RegisterNetEvent('QBCore:Notify')
AddEventHandler('QBCore:Notify', function(text, type, length)
	QBCore.Functions.Notify(text, type, length)
end)

RegisterNetEvent('QBCore:Client:TriggerCallback')
AddEventHandler('QBCore:Client:TriggerCallback', function(requestId, ...)
	if QBCore.ServerCallbacks[requestId] ~= nil then
		QBCore.ServerCallbacks[requestId](...)
		QBCore.ServerCallbacks[requestId] = nil
	end
end)

RegisterNetEvent("QBCore:Client:UseItem")
AddEventHandler('QBCore:Client:UseItem', function(item)
	TriggerServerEvent("QBCore:Server:UseItem", item)
end)