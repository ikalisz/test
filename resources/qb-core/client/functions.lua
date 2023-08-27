QBCore.Functions = {}
QBCore.TimeoutCallbacks = {}

QBCore.CurrentRequestId          = 0
QBCore.ServerCallbacks           = {}
QBCore.TimeoutCallbacks          = {}

QBCore.UI                        = {}
QBCore.UI.HUD                    = {}
QBCore.UI.HUD.RegisteredElements = {}
QBCore.UI.Menu                   = {}
QBCore.UI.Menu.RegisteredTypes   = {}
QBCore.UI.Menu.Opened            = {}

QBCore.RequestId = 0

QBCore.SetTimeout = function(msec, cb)
	table.insert(QBCore.TimeoutCallbacks, {
		time = GetGameTimer() + msec,
		cb   = cb
	})
	return #QBCore.TimeoutCallbacks
end

QBCore.ClearTimeout = function(i)
	QBCore.TimeoutCallbacks[i] = nil
end

QBCore.Functions.GetPlayerData = function(cb)
    if cb ~= nil then
        cb(QBCore.PlayerData)
    else
        return QBCore.PlayerData
    end
end

QBCore.Functions.DrawText = function(x, y, width, height, scale, r, g, b, a, text)
	SetTextFont(4)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(2, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end

QBCore.Functions.DrawText3D = function(x, y, z, text)
	SetTextScale(0.30, 0.30)
    SetTextFont(0)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 250
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

QBCore.Functions.GetCoords = function(entity)
    local coords = GetEntityCoords(entity, false)
    local heading = GetEntityHeading(entity)
    return {
        x = coords.x,
        y = coords.y,
        z = coords.z,
        a = heading
    }
end

QBCore.Functions.SpawnVehicle = function(model, cb, coords, isnetworked)
	local model = (type(model)=="number" and model or GetHashKey(model))
	Citizen.CreateThread(function()
		if not IsModelValid(model) then return end
		RequestModel(model)
		while not HasModelLoaded(model) do Citizen.Wait(1) end

		if coords == nil then
            local playerPed = PlayerPedId()
			local playerCoords = GetEntityCoords(playerPed) -- get the position of the local player ped
			coords = {x=playerCoords.x, y=playerCoords.y, z=playerCoords.z, h=GetEntityHeading(playerPed)}
		end
		
		local vehicle = CreateVehicle(model, coords.x, coords.y, coords.z, coords.h, isnetworked, false)
		local timeout = 0
		local arac = GetClosestVehicle(PlayerPedId())
		if isnetworked then
			local networkId = NetworkGetNetworkIdFromEntity(vehicle)
			SetNetworkIdCanMigrate(networkId, true)
			SetVehicleHasBeenOwnedByPlayer(vehicle, true)
		end

		SetEntityAsMissionEntity(vehicle, true, false)
		SetVehicleNeedsToBeHotwired(vehicle, false)
		SetVehRadioStation(vehicle, 'OFF')
		SetModelAsNoLongerNeeded(model)
		RequestCollisionAtCoord(coords.x, coords.y, coords.z)
		exports["np-fuel"]:SetFuel(arac, 100.0)

		-- we can get stuck here if any of the axies are "invalid"
		while not HasCollisionLoadedAroundEntity(vehicle) and timeout < 2000 do
			Citizen.Wait(0)
			timeout = timeout + 1
		end

		if cb then
			cb(vehicle)
		end
	end)
end

QBCore.Functions.SpawnVehicle2 = function(model, cb, coords, isnetworked, teleportInto)
    local ped = PlayerPedId()
    model = type(model) == 'string' and GetHashKey(model) or model
    if not IsModelInCdimage(model) then return end
    if coords then
        coords = type(coords) == 'table' and vec3(coords.x, coords.y, coords.z) or coords
    else
        coords = GetEntityCoords(ped)
    end
    isnetworked = isnetworked == nil or isnetworked
    QBCore.Functions.LoadModel(model)
    local veh = CreateVehicle(model, coords.x, coords.y, coords.z, coords.w, isnetworked, false)
    local netid = NetworkGetNetworkIdFromEntity(veh)
    SetVehicleHasBeenOwnedByPlayer(veh, true)
    SetNetworkIdCanMigrate(netid, true)
    SetVehicleNeedsToBeHotwired(veh, false)
    SetVehRadioStation(veh, 'OFF')
    SetVehicleFuelLevel(veh, 100.0)
    SetModelAsNoLongerNeeded(model)
    if teleportInto then TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1) end
    if cb then cb(veh) end
end

QBCore.Functions.IsSpawnPointClear = function(coords, radius)
	local vehicles = QBCore.Functions.GetVehiclesInArea(coords, radius)

	return #vehicles == 0
end

QBCore.Functions.GetVehiclesInArea = function(coords, area)
	local vehicles       = QBCore.Functions.GetVehicles()
	local vehiclesInArea = {}

	for i=1, #vehicles, 1 do
		local vehicleCoords = GetEntityCoords(vehicles[i])
		local distance      = GetDistanceBetweenCoords(vehicleCoords, coords.x, coords.y, coords.z, true)

		if distance <= area then
			table.insert(vehiclesInArea, vehicles[i])
		end
	end

	return vehiclesInArea
end

QBCore.Functions.DeleteVehicle = function(vehicle)
	SetVehicleHasBeenOwnedByPlayer(vehicle, true)
	NetworkRequestControlOfEntity(vehicle)
	Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(vehicle))
	DeleteEntity(vehicle)
	DeleteVehicle(vehicle)
	SetEntityAsNoLongerNeeded(vehicle)
end

QBCore.Functions.DeleteObject = function(object)
	NetworkRequestControlOfEntity(object)
	SetEntityAsMissionEntity(object, false, true)
	DeleteEntity(object)
	DeleteObject(object)
	SetEntityAsNoLongerNeeded(object)
end

QBCore.Functions.Notify = function(text, textype, length) -- [text] = message, [type] = primary | error | success, [length] = time till fadeout.
	if text == nil or text == "" then 
		text = "Notify Post Not Found"
	end

	if textype == nil or textype == "" then 
		textype = "primary"
	end

	if length == nil or length == "" then 
		length = 5000
	end
	if type(length) ~= "number" then 
		length = tonumber(length)
	end
	exports['elix1rBase']:SendAlert(text, textype, length) 
end

QBCore.Functions.TriggerCallback = function(name, cb, ...)
	QBCore.ServerCallbacks[QBCore.CurrentRequestId] = cb
	TriggerServerEvent("QBCore:Server:TriggerCallback", name, QBCore.CurrentRequestId, ...)
	
	if QBCore.CurrentRequestId < 65535 then
		QBCore.CurrentRequestId = QBCore.CurrentRequestId + 1
	else
		QBCore.CurrentRequestId = 0
	end
end

QBCore.Functions.EnumerateEntities = function(initFunc, moveFunc, disposeFunc)
	return coroutine.wrap(function()
		local iter, id = initFunc()
		if not id or id == 0 then
			disposeFunc(iter)
			return
		end

		local enum = {handle = iter, destructor = disposeFunc}
		setmetatable(enum, entityEnumerator)

		local next = true
		repeat
		coroutine.yield(id)
		next, id = moveFunc(iter)
		until not next

		enum.destructor, enum.handle = nil, nil
		disposeFunc(iter)
    end)
end

QBCore.Functions.GetVehicles = function()
    local vehicles = {}
	for vehicle in QBCore.Functions.EnumerateEntities(FindFirstVehicle, FindNextVehicle, EndFindVehicle) do
		table.insert(vehicles, vehicle)
	end
	return vehicles
end

QBCore.Functions.GetPeds = function(ignoreList)
    local ignoreList = ignoreList or {}
	local peds       = {}
	for ped in QBCore.Functions.EnumerateEntities(FindFirstPed, FindNextPed, EndFindPed) do
		local found = false

        for j=1, #ignoreList, 1 do
			if ignoreList[j] == ped then
				found = true
			end
		end

		if not found then
			table.insert(peds, ped)
		end
	end

	return peds
end

QBCore.Functions.SpawnObject = function(model, coords, cb)
	local model = (type(model) == 'number' and model or GetHashKey(model))

	Citizen.CreateThread(function()
		QBCore.Functions.RequestModel(model)

		local obj = CreateObject(model, coords.x, coords.y, coords.z, true, false, true)

		if cb then
			cb(obj)
		end
	end)
end

QBCore.Functions.GetPlayersInArea = function(coords, area)
	local players, playersInArea = QBCore.Functions.GetPlayers(), {}
	coords = vector3(coords.x, coords.y, coords.z)

	for i=1, #players, 1 do
		local target = GetPlayerPed(players[i])
		local targetCoords = GetEntityCoords(target)

		if #(coords - targetCoords) <= area then
			table.insert(playersInArea, players[i])
		end
	end

	return playersInArea
end

QBCore.Functions.RequestModel = function(modelHash, cb)
	modelHash = (type(modelHash) == 'number' and modelHash or GetHashKey(modelHash))

	if not HasModelLoaded(modelHash) and IsModelInCdimage(modelHash) then
		RequestModel(modelHash)

		while not HasModelLoaded(modelHash) do
			Citizen.Wait(1)
		end
	end

	if cb ~= nil then
		cb()
	end
end

QBCore.Functions.GetPlayers = function()
    local players = {}
    for _, player in ipairs(GetActivePlayers()) do
        local ped = GetPlayerPed(player)
        if DoesEntityExist(ped) then
            table.insert(players, player)
        end
    end
    return players
end

QBCore.Functions.GetClosestVehicle = function(coords)
	--[[local coordFrom = coords
	local playerPed = PlayerPedId()

	if coordFrom == nil then
		coordFrom = GetEntityCoords(playerPed)
	end
	local coordTo = GetOffsetFromEntityInWorldCoords(playerPed, 0.0, 255.0, 0.0)

	local offset = 0
	local rayHandle
	local vehicle

	for i = 0, 100 do
		rayHandle = CastRayPointToPoint(coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z + offset, 10, PlayerPedId(), 0)	
		a, b, c, d, vehicle = GetRaycastResult(rayHandle)
		
		offset = offset - 1

		if vehicle ~= 0 then break end
	end
	
	local distance = Vdist2(coordFrom, GetEntityCoords(vehicle))
	
	if distance > 25 then vehicle = nil end

	return vehicle ~= nil and vehicle or 0]]--
	
	local vehicles        = QBCore.Functions.GetVehicles()
	local closestDistance = -1
	local closestVehicle  = -1
	local coords          = coords

	if coords == nil then
		local playerPed = PlayerPedId()
		coords = GetEntityCoords(playerPed)
	end
	for i=1, #vehicles, 1 do
		local vehicleCoords = GetEntityCoords(vehicles[i])
		local distance      = GetDistanceBetweenCoords(vehicleCoords, coords.x, coords.y, coords.z, true)

		if closestDistance == -1 or closestDistance > distance then
			closestVehicle  = vehicles[i]
			closestDistance = distance
		end
	end
	return closestVehicle, closestDistance
end

QBCore.Functions.GetClosestPed = function(coords, ignoreList)
	local ignoreList      = ignoreList or {}
	local peds            = QBCore.Functions.GetPeds(ignoreList)
	local closestDistance = -1
    local closestPed      = -1
    
    if coords == nil then
        coords = GetEntityCoords(PlayerPedId())
    end

	for i=1, #peds, 1 do
		local pedCoords = GetEntityCoords(peds[i])
		local distance  = GetDistanceBetweenCoords(pedCoords, coords.x, coords.y, coords.z, true)

		if closestDistance == -1 or closestDistance > distance then
			closestPed      = peds[i]
			closestDistance = distance
		end
	end

	return closestPed, closestDistance
end


QBCore.Functions.GetClosestPlayer = function(coords)
	if coords == nil then
        coords = GetEntityCoords(PlayerPedId())
	end
	
	local closestPlayers = QBCore.Functions.GetPlayersFromCoords(coords)
    local closestDistance = -1
    local closestPlayer = -1

    for i=1, #closestPlayers, 1 do
        if closestPlayers[i] ~= PlayerId() and closestPlayers[i] ~= -1 then
            local pos = GetEntityCoords(GetPlayerPed(closestPlayers[i]))
            local distance = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, coords.x, coords.y, coords.z, true)

            if closestDistance == -1 or closestDistance > distance then
                closestPlayer = closestPlayers[i]
                closestDistance = distance
            end
        end
	end

	return closestPlayer, closestDistance
end

QBCore.Functions.GetPlayersFromCoords = function(coords, distance)
    local players = QBCore.Functions.GetPlayers()
    local closePlayers = {}

    if coords == nil then
		coords = GetEntityCoords(PlayerPedId())
    end
    if distance == nil then
        distance = 5.0
    end
    for _, player in pairs(players) do
		local target = GetPlayerPed(player)
		local targetCoords = GetEntityCoords(target)
		local targetdistance = GetDistanceBetweenCoords(targetCoords, coords.x, coords.y, coords.z, true)
		if targetdistance <= distance then
			table.insert(closePlayers, player)
		end
    end
    
    return closePlayers
end

QBCore.Functions.HasItem = function(source, cb, item)
	local retval = false
	QBCore.Functions.TriggerCallback('QBCore:HasItem', function(result)
		if result then
			retval = true
		end
		return retval
	end, item)
	return retval
end

-- local bussy = false
-- QBCore.Functions.Progressbar = function(name, label, duration, useWhileDead, canCancel, disableControls, animation, prop, propTwo, onFinish, onCancel)
-- 	if not bussy then
-- 		bussy = true
-- 		exports['progressbar']:Progress({
-- 			name = name:lower(),
-- 			duration = duration,
-- 			label = label,
-- 			useWhileDead = useWhileDead,
-- 			canCancel = canCancel,
-- 			controlDisables = disableControls,
-- 			animation = animation,
-- 			prop = prop,
-- 			propTwo = propTwo,
-- 		}, function(cancelled)
-- 			if not cancelled then
-- 				if onFinish ~= nil then
-- 					bussy = false
-- 					onFinish()
-- 				end
-- 			else
-- 				if onCancel ~= nil then
-- 					bussy = false
-- 					onCancel()
-- 				end
-- 			end
-- 		end)
-- 	else
-- 		QBCore.Functions.Notify("Zaten Birşey Yapıyorsun", "error")
-- 		onCancel()
-- 	end
-- end
local bussy = false
function QBCore.Functions.Progressbar(name, label, duration, useWhileDead, canCancel, disableControls, animation, prop, propTwo, onFinish, onCancel)
    if GetResourceState('elix1rBase') ~= 'started' then error('progressbar needs to be started in order for QBCore.Functions.Progressbar to work') end
    exports['elix1rBase']:Progress({
        name = name:lower(),
        duration = duration,
        label = label,
        useWhileDead = useWhileDead,
        canCancel = canCancel,
        controlDisables = disableControls,
        animation = animation,
        prop = prop,
        propTwo = propTwo,
    }, function(cancelled)
        if not cancelled then
            if onFinish then
				bussy = false
                onFinish()
            end
        else
            if onCancel then
				bussy = false
                onCancel()
            end
        end
    end)
end

function QBCore.Functions.GetPlate(vehicle)
    if vehicle == 0 then return end
    return QBCore.Shared.Trim(GetVehicleNumberPlateText(vehicle))
end

QBCore.Functions.GetVehicleProperties = function(vehicle)
	if DoesEntityExist(vehicle) then
		local vehicleMods = { 
			model = GetEntityModel(vehicle),
			neon = {},
			colors = {},
			extracolors = {},
			dashColour = -1,
			interColour = -1,
			lights = {},
			customWheel = GetVehicleModVariation(vehicle, 23),
			tint = GetVehicleWindowTint(vehicle),
			wheeltype = GetVehicleWheelType(vehicle),
			plate = QBCore.Shared.Trim(GetVehicleNumberPlateText(vehicle)),
			plateIndex = GetVehicleNumberPlateTextIndex(vehicle),
			carName = GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)),
			bodyHealth = QBCore.Shared.Round(GetEntityHealth(vehicle), 1),
			engineHealth = QBCore.Shared.Round(GetVehicleEngineHealth(vehicle), 1),
			dirtLevel = GetVehicleDirtLevel(vehicle),
			fuelLevel = QBCore.Shared.Round(GetVehicleFuelLevel(vehicle), 1),
			mods = {},
			smokecolor = {},
			xenonColor = -1,
			oldLiveries = 24,
			extras = {},
			windows = {},
			doors = {},
		}

        for id = 0, GetNumVehicleWindowTints(vehicle) do
            local windowId = IsVehicleWindowIntact(vehicle, id)
            if not windowId then
                vehicleMods.windows[#vehicleMods.windows + 1] = true
			elseif windowId == 1 then
                vehicleMods.windows[#vehicleMods.windows + 1] = false
            end
        end

		for id = 0, GetNumberOfVehicleDoors(vehicle) do
            local doorId = IsVehicleDoorDamaged(vehicle, id)
            if not doorId then
                vehicleMods.doors[#vehicleMods.doors + 1] = false
			elseif doorId == 1 then
                vehicleMods.doors[#vehicleMods.doors + 1] = true
            end
		end

		vehicleMods.xenonColor = GetVehicleHeadlightsColour(vehicle)
		vehicleMods.lights[1], vehicleMods.lights[2], vehicleMods.lights[3] = GetVehicleNeonLightsColour(vehicle)
		vehicleMods.colors[1], vehicleMods.colors[2] = GetVehicleColours(vehicle)
		vehicleMods.extracolors[1], vehicleMods.extracolors[2] = GetVehicleExtraColours(vehicle)
		vehicleMods.smokecolor[1], vehicleMods.smokecolor[2], vehicleMods.smokecolor[3] = GetVehicleTyreSmokeColor(vehicle)
		vehicleMods.dashColour = GetVehicleInteriorColour(vehicle)
		vehicleMods.interColour = GetVehicleDashboardColour(vehicle)
		vehicleMods.oldLiveries = GetVehicleLivery(vehicle)

		for i = 0, 3 do
			vehicleMods.neon[i] = IsVehicleNeonLightEnabled(vehicle, i)
		end

		for i = 0,16 do
			vehicleMods.mods[i] = GetVehicleMod(vehicle,i)
		end

		for i = 17, 22 do
			vehicleMods.mods[i] = IsToggleModOn(vehicle, i)
		end

		for i = 23, 48 do
			vehicleMods.mods[i] = GetVehicleMod(vehicle,i)
		end

		for i = 1, 12 do
			local ison = IsVehicleExtraTurnedOn(vehicle, i)
			if 1 == tonumber(ison) then
				vehicleMods.extras[i] = 1
			else
				vehicleMods.extras[i] = 0
			end
		end	
		return vehicleMods
	else
		return
	end
end

function QBCore.Functions.AttachProp(ped, model, boneId, x, y, z, xR, yR, zR, vertex)
    local modelHash = type(model) == 'string' and GetHashKey(model) or model
    local bone = GetPedBoneIndex(ped, boneId)
    QBCore.Functions.LoadModel(modelHash)
    local prop = CreateObject(modelHash, 1.0, 1.0, 1.0, 1, 1, 0)
    AttachEntityToEntity(prop, ped, bone, x, y, z, xR, yR, zR, 1, 1, 0, 1, not vertex and 2 or 0, 1)
    SetModelAsNoLongerNeeded(modelHash)
    return prop
end

function QBCore.Functions.LoadModel(model)
    if HasModelLoaded(model) then return end
	RequestModel(model)
	while not HasModelLoaded(model) do
		Wait(0)
	end
end

function QBCore.Functions.GetClosestBone(entity, list)
    local playerCoords, bone, coords, distance = GetEntityCoords(PlayerPedId())
    for _, element in pairs(list) do
        local boneCoords = GetWorldPositionOfEntityBone(entity, element.id or element)
        local boneDistance = #(playerCoords - boneCoords)
        if not coords then
            bone, coords, distance = element, boneCoords, boneDistance
        elseif distance > boneDistance then
            bone, coords, distance = element, boneCoords, boneDistance
        end
    end
    if not bone then
        bone = {id = GetEntityBoneIndexByName(entity, "bodyshell"), type = "remains", name = "bodyshell"}
        coords = GetWorldPositionOfEntityBone(entity, bone.id)
        distance = #(coords - playerCoords)
    end
    return bone, coords, distance
end

function QBCore.Functions.GetBoneDistance(entity, boneType, boneIndex)
    local bone
    if boneType == 1 then
        bone = GetPedBoneIndex(entity, boneIndex)
    else
        bone = GetEntityBoneIndexByName(entity, boneIndex)
    end
    local boneCoords = GetWorldPositionOfEntityBone(entity, bone)
    local playerCoords = GetEntityCoords(PlayerPedId())
    return #(boneCoords - playerCoords)
end

QBCore.Functions.SetVehicleProperties = function(vehicle, props)
	if DoesEntityExist(vehicle) then
		SetVehicleModKit(vehicle, 0)
		if props.color1 then
			if props.plate ~= nil then
				SetVehicleNumberPlateText(vehicle, props.plate)
			end

			if props.plateIndex ~= nil then
				SetVehicleNumberPlateTextIndex(vehicle, props.plateIndex)
			end

			if props.bodyHealth ~= nil then
				SetEntityHealth(vehicle, props.bodyHealth)
			end

			if props.engineHealth then 
				SetVehicleEngineHealth(vehicle, props.engineHealth + 0.0) 
			end

			if props.xenonColor then 
				SetVehicleXenonLightsColour(vehicle, props.xenonColor) 
			end

			if props.fuelLevel then
				SetVehicleFuelLevel(vehicle, props.fuelLevel + 0.0) 
			end

			if props.dirtLevel ~= nil then
				SetVehicleDirtLevel(vehicle, props.dirtLevel)
			end

			if props.color1 ~= nil then
				local color1, color2 = GetVehicleColours(vehicle)
				SetVehicleColours(vehicle, props.color1, color2)
			end

			if props.color2 ~= nil then
				local color1, color2 = GetVehicleColours(vehicle)
				SetVehicleColours(vehicle, color1, props.color2)
			end

			if props.pearlescentColor ~= nil then
				local pearlescentColor, wheelColor = GetVehicleExtraColours(vehicle)
				SetVehicleExtraColours(vehicle, props.pearlescentColor, wheelColor)
			end

			if props.wheelColor ~= nil then
				local pearlescentColor, wheelColor = GetVehicleExtraColours(vehicle)
				SetVehicleExtraColours(vehicle, pearlescentColor, props.wheelColor)
			end

			if props.wheels ~= nil then
				SetVehicleWheelType(vehicle, props.wheels)
			end

			if props.windowTint ~= nil then
				SetVehicleWindowTint(vehicle, props.windowTint)
			end

			if props.neonEnabled ~= nil then
				SetVehicleNeonLightEnabled(vehicle, 0, props.neonEnabled[1])
				SetVehicleNeonLightEnabled(vehicle, 1, props.neonEnabled[2])
				SetVehicleNeonLightEnabled(vehicle, 2, props.neonEnabled[3])
				SetVehicleNeonLightEnabled(vehicle, 3, props.neonEnabled[4])
			end

			if props.neonColor ~= nil then
				SetVehicleNeonLightsColour(vehicle, props.neonColor[1], props.neonColor[2], props.neonColor[3])
			end

			if props.modSmokeEnabled ~= nil then
				ToggleVehicleMod(vehicle, 20, true)
			end

			if props.tyreSmokeColor ~= nil then
				SetVehicleTyreSmokeColor(vehicle, props.tyreSmokeColor[1], props.tyreSmokeColor[2], props.tyreSmokeColor[3])
			end

			if props.modSpoilers ~= nil then
				SetVehicleMod(vehicle, 0, props.modSpoilers, false)
			end

			if props.modFrontBumper ~= nil then
				SetVehicleMod(vehicle, 1, props.modFrontBumper, false)
			end

			if props.modRearBumper ~= nil then
				SetVehicleMod(vehicle, 2, props.modRearBumper, false)
			end

			if props.modSideSkirt ~= nil then
				SetVehicleMod(vehicle, 3, props.modSideSkirt, false)
			end

			if props.modExhaust ~= nil then
				SetVehicleMod(vehicle, 4, props.modExhaust, false)
			end

			if props.modFrame ~= nil then
				SetVehicleMod(vehicle, 5, props.modFrame, false)
			end

			if props.modGrille ~= nil then
				SetVehicleMod(vehicle, 6, props.modGrille, false)
			end

			if props.modHood ~= nil then
				SetVehicleMod(vehicle, 7, props.modHood, false)
			end

			if props.modFender ~= nil then
				SetVehicleMod(vehicle, 8, props.modFender, false)
			end

			if props.modRightFender ~= nil then
				SetVehicleMod(vehicle, 9, props.modRightFender, false)
			end

			if props.modRoof ~= nil then
				SetVehicleMod(vehicle, 10, props.modRoof, false)
			end

			if props.modEngine ~= nil then
				SetVehicleMod(vehicle, 11, props.modEngine, false)
			end

			if props.modBrakes ~= nil then
				SetVehicleMod(vehicle, 12, props.modBrakes, false)
			end

			if props.modTransmission ~= nil then
				SetVehicleMod(vehicle, 13, props.modTransmission, false)
			end

			if props.modHorns ~= nil then
				SetVehicleMod(vehicle, 14, props.modHorns, false)
			end

			if props.modSuspension ~= nil then
				SetVehicleMod(vehicle, 15, props.modSuspension, false)
			end

			if props.modArmor ~= nil then
				SetVehicleMod(vehicle, 16, props.modArmor, false)
			end

			if props.modTurbo ~= nil then
				ToggleVehicleMod(vehicle,  18, props.modTurbo)
			end

			if props.modXenon ~= nil then
				ToggleVehicleMod(vehicle,  22, props.modXenon)
			end

			if props.modFrontWheels ~= nil then
				SetVehicleMod(vehicle, 23, props.modFrontWheels, false)
			end

			if props.modBackWheels ~= nil then
				SetVehicleMod(vehicle, 24, props.modBackWheels, false)
			end

			if props.modPlateHolder ~= nil then
				SetVehicleMod(vehicle, 25, props.modPlateHolder, false)
			end

			if props.modVanityPlate ~= nil then
				SetVehicleMod(vehicle, 26, props.modVanityPlate, false)
			end

			if props.modTrimA ~= nil then
				SetVehicleMod(vehicle, 27, props.modTrimA, false)
			end

			if props.modOrnaments ~= nil then
				SetVehicleMod(vehicle, 28, props.modOrnaments, false)
			end

			if props.modDashboard ~= nil then
				SetVehicleMod(vehicle, 29, props.modDashboard, false)
			end

			if props.modDial ~= nil then
				SetVehicleMod(vehicle, 30, props.modDial, false)
			end

			if props.modDoorSpeaker ~= nil then
				SetVehicleMod(vehicle, 31, props.modDoorSpeaker, false)
			end

			if props.modSeats ~= nil then
				SetVehicleMod(vehicle, 32, props.modSeats, false)
			end

			if props.modSteeringWheel ~= nil then
				SetVehicleMod(vehicle, 33, props.modSteeringWheel, false)
			end

			if props.modShifterLeavers ~= nil then
				SetVehicleMod(vehicle, 34, props.modShifterLeavers, false)
			end

			if props.modAPlate ~= nil then
				SetVehicleMod(vehicle, 35, props.modAPlate, false)
			end

			if props.modSpeakers ~= nil then
				SetVehicleMod(vehicle, 36, props.modSpeakers, false)
			end

			if props.modTrunk ~= nil then
				SetVehicleMod(vehicle, 37, props.modTrunk, false)
			end

			if props.modHydrolic ~= nil then
				SetVehicleMod(vehicle, 38, props.modHydrolic, false)
			end

			if props.modEngineBlock ~= nil then
				SetVehicleMod(vehicle, 39, props.modEngineBlock, false)
			end

			if props.modAirFilter ~= nil then
				SetVehicleMod(vehicle, 40, props.modAirFilter, false)
			end

			if props.modStruts ~= nil then
				SetVehicleMod(vehicle, 41, props.modStruts, false)
			end

			if props.modArchCover ~= nil then
				SetVehicleMod(vehicle, 42, props.modArchCover, false)
			end

			if props.modAerials ~= nil then
				SetVehicleMod(vehicle, 43, props.modAerials, false)
			end

			if props.modTrimB ~= nil then
				SetVehicleMod(vehicle, 44, props.modTrimB, false)
			end

			if props.modTank ~= nil then
				SetVehicleMod(vehicle, 45, props.modTank, false)
			end

			if props.modWindows ~= nil then
				SetVehicleMod(vehicle, 46, props.modWindows, false)
			end

			if props.livery ~= nil then
				SetVehicleLivery(vehicle, props.livery)
			end
		
			if props.liverymods ~= nil then
				SetVehicleMod(vehicle, 48, props.liverymods, false)
			end

			if props.modCustomTyres ~= nil and props.modCustomTyres then 
				SetVehicleMod(vehicle, 23, props.modCustomTyres, true)
			end

			if props.extras then
				for id,enabled in pairs(props.extras) do
					if enabled then
						SetVehicleExtra(vehicle, tonumber(id), 0)
					else
						SetVehicleExtra(vehicle, tonumber(id), 1)
					end
				end
			end

			-- Ekstra Eklendi Baş
			if props.ekstraProp then

				if props.ekstraProp.tyres then
					for tyreId=1, #props.ekstraProp.tyres do
						if props.ekstraProp.tyres[tyreId] == true then
							SetVehicleTyreBurst(vehicle, tyreId - 1, true, 1000)
						end
					end
				end

				if props.ekstraProp.windows then
					for windowId=1, #props.ekstraProp.windows do
						if props.ekstraProp.windows[windowId] == true then
							SmashVehicleWindow(vehicle, windowId - 1)
						end
					end
				end
			
				if props.ekstraProp.doors then
					for doorId=1, #props.ekstraProp.doors do
						if props.ekstraProp.doors[doorId] == true then
							SetVehicleDoorBroken(vehicle, doorId - 1, true)
						end
					end
				end

				if props.ekstraProp.carExtras then 
					for ExtraID = 0, 20 do
						if DoesExtraExist(vehPedIsIn, ExtraID) then
							SetVehicleExtra(vehicle, ExtraID, 1)
						end
					end

					for extra=1, #props.ekstraProp.carExtras do
						SetVehicleExtra(vehicle, props.ekstraProp.carExtras[extra], 0)
					end
				end

			end
		-- Ekstra Eklendi Son
		else
			if props.wheeltype then SetVehicleWheelType(vehicle, props.wheeltype) end
			if props.plate then SetVehicleNumberPlateText(vehicle, props.plate) end
			if props.plateIndex then SetVehicleNumberPlateTextIndex(vehicle, props.plateIndex) end
			if props.bodyHealth then SetEntityHealth(vehicle, props.bodyHealth) end
			if props.engineHealth then SetVehicleEngineHealth(vehicle, props.engineHealth + 0.0) end

			if props.mods then
				for i = 0, 16 do
					if props.mods[tostring(i)] then
						SetVehicleMod(vehicle, i, props.mods[tostring(i)])
					end
				end

				for i = 17, 22 do
					if props.mods[tostring(i)] then
						ToggleVehicleMod(vehicle, i, props.mods[tostring(i)])
					end
				end

				for i = 23, 48 do
					if props.mods[tostring(i)] then
						SetVehicleMod(vehicle, i, props.mods[tostring(i)])
					end
				end

				for i = 0, 3 do
					if props.mods[tostring(i)] then
						SetVehicleNeonLightEnabled(vehicle, i, props.neon[tostring(i)])
					end
				end
			end

			if props.extras then
				for i = 1, 12 do
					local onoff = tonumber(props.extras[i])
					if onoff == 1 then
						SetVehicleExtra(vehicle, i, 0)
					else
						SetVehicleExtra(vehicle, i, 1)
					end
				end
			end

			if props.oldLiveries ~= nil and props.oldLiveries ~= 24 then
				SetVehicleLivery(vehicle, props.oldLiveries)
			end

			-- Xenon Colors
			if props.xenonColor then SetVehicleXenonLightsColour(vehicle, (props.xenonColor or -1)) end
			if props.colors then SetVehicleColours(vehicle, props.colors[1], props.colors[2]) end
			if props.extracolors then SetVehicleExtraColours(vehicle, props.extracolors[1], props.extracolors[2]) end
			if props.lights then SetVehicleNeonLightsColour(vehicle, props.lights[1], props.lights[2], props.lights[3]) end
			if props.smokecolor then SetVehicleTyreSmokeColor(vehicle, props.smokecolor[1], props.smokecolor[2], props.smokecolor[3]) end
			if props.tint then SetVehicleWindowTint(vehicle, props.tint) end
			if props.dashColour then SetVehicleInteriorColour(vehicle, props.dashColour) end
			if props.interColour then SetVehicleDashboardColour(vehicle, props.interColour) end
			if props.fuelLevel then SetVehicleFuelLevel(vehicle, props.fuelLevel + 0.0) end
			if props.dirtLevel then SetVehicleDirtLevel(vehicle, props.dirtLevel) end

			if props.mods then
				for i = 23, 24 do
					if props.mods[tostring(i)] and props.customWheel then
						SetVehicleMod(vehicle, i, props.mods[tostring(i)], props.customWheel)
					end
				end
			end

			if props.windows then
				for windowId=1, #props.windows do
					if props.windows[windowId] == true then
						SmashVehicleWindow(vehicle, windowId - 1)
					end
				end
			end
	
			if props.doors then
				for doorId=1, #props.doors do
					if props.doors[doorId] == true then
						SetVehicleDoorBroken(vehicle, doorId - 1, true)
					end
				end
			end

		end

	end
end

QBCore.Functions.GetVehicleInDirection = function()
	local playerPed    = PlayerPedId()
	local playerCoords = GetEntityCoords(playerPed)
	local inDirection  = GetOffsetFromEntityInWorldCoords(playerPed, 0.0, 5.0, 0.0)
	local rayHandle    = StartShapeTestRay(playerCoords, inDirection, 10, playerPed, 0)
	local numRayHandle, hit, endCoords, surfaceNormal, entityHit = GetShapeTestResult(rayHandle)

	if hit == 1 and GetEntityType(entityHit) == 2 then
		return entityHit
	end

	return nil
end

function QBCore.Functions.GetClosestObjectNew(coords)
    local ped = PlayerPedId()
    local objects = GetGamePool('CObject')
    local closestDistance = -1
    local closestObject = -1
    if coords then
        coords = type(coords) == 'table' and vec3(coords.x, coords.y, coords.z) or coords
    else
        coords = GetEntityCoords(ped)
    end
    for i = 1, #objects, 1 do
        local objectCoords = GetEntityCoords(objects[i])
        local distance = #(objectCoords - coords)
        if closestDistance == -1 or closestDistance > distance then
            closestObject = objects[i]
            closestDistance = distance
        end
    end
    return closestObject, closestDistance
end

QBCore.Functions.GetClosestObject = function(filter, coords)
	local objects = QBCore.Functions.GetObjects()
	local closestDistance, closestObject = -1, -1
	local filter, coords = filter, coords

	if type(filter) == 'string' then
		if filter ~= '' then
			filter = {filter}
		end
	end

	if coords then
		coords = vector3(coords.x, coords.y, coords.z)
	else
		local playerPed = PlayerPedId()
		coords = GetEntityCoords(playerPed)
	end

	for i=1, #objects, 1 do
		local foundObject = false

		if filter == nil or (type(filter) == 'table' and #filter == 0) then
			foundObject = true
		else
			local objectModel = GetEntityModel(objects[i])

			for j=1, #filter, 1 do
				if objectModel == GetHashKey(filter[j]) then
					foundObject = true
					break
				end
			end
		end

		if foundObject then
			local objectCoords = GetEntityCoords(objects[i])
			local distance = #(objectCoords - coords)

			if closestDistance == -1 or closestDistance > distance then
				closestObject = objects[i]
				closestDistance = distance
			end
		end
	end

	return closestObject, closestDistance
end

QBCore.Functions.GetObjects = function()
	local objects = {}

	for object in EnumerateObjects() do
		table.insert(objects, object)
	end

	return objects
end

-- Uİ
QBCore.UI.HUD.SetDisplay = function(opacity)
	SendNUIMessage({
		action  = 'setHUDDisplay',
		opacity = opacity
	})
end

QBCore.UI.HUD.RegisterElement = function(name, index, priority, html, data)
	local found = false

	for i=1, #QBCore.UI.HUD.RegisteredElements, 1 do
		if QBCore.UI.HUD.RegisteredElements[i] == name then
			found = true
			break
		end
	end

	if found then
		return
	end

	table.insert(QBCore.UI.HUD.RegisteredElements, name)
	SendNUIMessage({
		action    = 'insertHUDElement',
		name      = name,
		index     = index,
		priority  = priority,
		html      = html,
		data      = data
	})

	QBCore.UI.HUD.UpdateElement(name, data)
end

QBCore.UI.HUD.RemoveElement = function(name)
	for i=1, #QBCore.UI.HUD.RegisteredElements, 1 do
		if QBCore.UI.HUD.RegisteredElements[i] == name then
			table.remove(QBCore.UI.HUD.RegisteredElements, i)
			break
		end
	end

	SendNUIMessage({
		action    = 'deleteHUDElement',
		name      = name
	})
end

QBCore.UI.HUD.UpdateElement = function(name, data)
	SendNUIMessage({
		action = 'updateHUDElement',
		name   = name,
		data   = data
	})
end

QBCore.UI.Menu.RegisterType = function(type, open, close)
	QBCore.UI.Menu.RegisteredTypes[type] = {
		open   = open,
		close  = close
	}
end

QBCore.UI.Menu.Open = function(type, namespace, name, data, submit, cancel, change, close)
	local menu = {}

	menu.type      = type
	menu.namespace = namespace
	menu.name      = name
	menu.data      = data
	menu.submit    = submit
	menu.cancel    = cancel
	menu.change    = change

	menu.close = function()

		QBCore.UI.Menu.RegisteredTypes[type].close(namespace, name)

		for i=1, #QBCore.UI.Menu.Opened, 1 do
			if QBCore.UI.Menu.Opened[i] then
				if QBCore.UI.Menu.Opened[i].type == type and QBCore.UI.Menu.Opened[i].namespace == namespace and QBCore.UI.Menu.Opened[i].name == name then
					QBCore.UI.Menu.Opened[i] = nil
				end
			end
		end

		if close then
			close()
		end

	end

	menu.update = function(query, newData)

		for i=1, #menu.data.elements, 1 do
			local match = true

			for k,v in pairs(query) do
				if menu.data.elements[i][k] ~= v then
					match = false
				end
			end

			if match then
				for k,v in pairs(newData) do
					menu.data.elements[i][k] = v
				end
			end
		end

	end

	menu.refresh = function()
		QBCore.UI.Menu.RegisteredTypes[type].open(namespace, name, menu.data)
	end

	menu.setElement = function(i, key, val)
		menu.data.elements[i][key] = val
	end
	
	menu.setElements = function(newElements)
		menu.data.elements = newElements
	end

	menu.setTitle = function(val)
		menu.data.title = val
	end

	menu.removeElement = function(query)
		for i=1, #menu.data.elements, 1 do
			for k,v in pairs(query) do
				if menu.data.elements[i] then
					if menu.data.elements[i][k] == v then
						table.remove(menu.data.elements, i)
						break
					end
				end

			end
		end
	end

	table.insert(QBCore.UI.Menu.Opened, menu)
	QBCore.UI.Menu.RegisteredTypes[type].open(namespace, name, data)

	return menu
end

QBCore.UI.Menu.Close = function(type, namespace, name)
	for i=1, #QBCore.UI.Menu.Opened, 1 do
		if QBCore.UI.Menu.Opened[i] then
			if QBCore.UI.Menu.Opened[i].type == type and QBCore.UI.Menu.Opened[i].namespace == namespace and QBCore.UI.Menu.Opened[i].name == name then
				QBCore.UI.Menu.Opened[i].close()
				QBCore.UI.Menu.Opened[i] = nil
			end
		end
	end
end

QBCore.UI.Menu.CloseAll = function()
	for i=1, #QBCore.UI.Menu.Opened, 1 do
		if QBCore.UI.Menu.Opened[i] then
			QBCore.UI.Menu.Opened[i].close()
			QBCore.UI.Menu.Opened[i] = nil
		end
	end
end

QBCore.UI.Menu.GetOpened = function(type, namespace, name)
	for i=1, #QBCore.UI.Menu.Opened, 1 do
		if QBCore.UI.Menu.Opened[i] then
			if QBCore.UI.Menu.Opened[i].type == type and QBCore.UI.Menu.Opened[i].namespace == namespace and QBCore.UI.Menu.Opened[i].name == name then
				return QBCore.UI.Menu.Opened[i]
			end
		end
	end
end

QBCore.UI.Menu.GetOpenedMenus = function()
	return QBCore.UI.Menu.Opened
end

QBCore.UI.Menu.IsOpen = function(type, namespace, name)
	return QBCore.UI.Menu.GetOpened(type, namespace, name) ~= nil
end

QBCore.UI.HUD.SetDisplay = function(opacity)
	SendNUIMessage({
		action  = 'setHUDDisplay',
		opacity = opacity
	})
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local currTime = GetGameTimer()

		for i=1, #QBCore.TimeoutCallbacks, 1 do
			if QBCore.TimeoutCallbacks[i] then
				if currTime >= QBCore.TimeoutCallbacks[i].time then
					QBCore.TimeoutCallbacks[i].cb()
					QBCore.TimeoutCallbacks[i] = nil
				end
			end
		end
	end
end)

CreateThread(function()
	for _, v in pairs(QBCore.Shared.Vehicles) do
		local text
			text = v["name"]
		if v['hash'] ~= 0 and v['hash'] ~= nil then
			AddTextEntryByHash(v["hash"],text)
		end
	end
end)

function QBCore.Functions.LoadParticleDictionary(dictionary)
    if HasNamedPtfxAssetLoaded(dictionary) then return end
    RequestNamedPtfxAsset(dictionary)
    while not HasNamedPtfxAssetLoaded(dictionary) do
        Wait(0)
    end
end

function QBCore.Functions.StartParticleAtCoord(dict, ptName, looped, coords, rot, scale, alpha, color, duration)
    if coords then
        coords = type(coords) == 'table' and vec3(coords.x, coords.y, coords.z) or coords
    else
        coords = GetEntityCoords(PlayerPedId())
    end
    QBCore.Functions.LoadParticleDictionary(dict)
    UseParticleFxAssetNextCall(dict)
    SetPtfxAssetNextCall(dict)
    local particleHandle
    if looped then
        particleHandle = StartParticleFxLoopedAtCoord(ptName, coords.x, coords.y, coords.z, rot.x, rot.y, rot.z, scale or 1.0)
        if color then
            SetParticleFxLoopedColour(particleHandle, color.r, color.g, color.b, false)
        end
        SetParticleFxLoopedAlpha(particleHandle, alpha or 10.0)
        if duration then
            Wait(duration)
            StopParticleFxLooped(particleHandle, 0)
        end
    else
        SetParticleFxNonLoopedAlpha(alpha or 10.0)
        if color then
            SetParticleFxNonLoopedColour(color.r, color.g, color.b)
        end
        StartParticleFxNonLoopedAtCoord(ptName, coords.x, coords.y, coords.z, rot.x, rot.y, rot.z, scale or 1.0)
    end
    return particleHandle
end

function QBCore.Functions.StartParticleOnEntity(dict, ptName, looped, entity, bone, offset, rot, scale, alpha, color, evolution, duration)
    QBCore.Functions.LoadParticleDictionary(dict)
    UseParticleFxAssetNextCall(dict)
    local particleHandle, boneID
    if bone and GetEntityType(entity) == 1 then
        boneID = GetPedBoneIndex(entity, bone)
    elseif bone then
        boneID = GetEntityBoneIndexByName(entity, bone)
    end
    if looped then
        if bone then
            particleHandle = StartParticleFxLoopedOnEntityBone(ptName, entity, offset.x, offset.y, offset.z, rot.x, rot.y, rot.z, boneID, scale)
        else
            particleHandle = StartParticleFxLoopedOnEntity(ptName, entity, offset.x, offset.y, offset.z, rot.x, rot.y, rot.z, scale)
        end
        if evolution then
            SetParticleFxLoopedEvolution(particleHandle, evolution.name, evolution.amount, false)
        end
        if color then
            SetParticleFxLoopedColour(particleHandle, color.r, color.g, color.b, false)
        end
        SetParticleFxLoopedAlpha(particleHandle, alpha)
        if duration then
            Wait(duration)
            StopParticleFxLooped(particleHandle, 0)
        end
    else
        SetParticleFxNonLoopedAlpha(alpha or 10.0)
        if color then
            SetParticleFxNonLoopedColour(color.r, color.g, color.b)
        end
        if bone then
            StartParticleFxNonLoopedOnPedBone(ptName, entity, offset.x, offset.y, offset.z, rot.x, rot.y, rot.z, boneID, scale)
        else
            StartParticleFxNonLoopedOnEntity(ptName, entity, offset.x, offset.y, offset.z, rot.x, rot.y, rot.z, scale)
        end
    end
    return particleHandle
end