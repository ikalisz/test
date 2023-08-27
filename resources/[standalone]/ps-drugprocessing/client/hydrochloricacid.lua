local spawnedHydrochloricAcidBarrels = 0
local HydrochloricAcidBarrels = {}
local inhydrochloricField = false
local QBCore = exports['qb-core']:GetCoreObject()


local function ValidateHydrochloricAcidCoord(plantCoord)
	local validate = true
	if spawnedHydrochloricAcidBarrels > 0 then
		for k, v in pairs(HydrochloricAcidBarrels) do
			if #(plantCoord-GetEntityCoords(v)) < 5 then
				validate = false
			end
		end
		if not inhydrochloricField then
			validate = false
		end
	end
	return validate
end

local function GetCoordZHydrochloricAcid(x, y)
	local groundCheckHeights = { 20.0, 21.0, 22.0, 23.0, 24.0, 175.0, 190.0, 200.0, 205.0, 215.0, 225.0 }

	for i, height in ipairs(groundCheckHeights) do
		local found2Ground, z = GetGroundZFor_3dCoord(x, y, height)

		if found2Ground then
			return z
		end
	end

	return 24.5
end

local function GenerateHydrochloricAcidCoords()
	while true do
		Wait(1)

		local weed2CoordX, weed2CoordY

		math.randomseed(GetGameTimer())
		local modX2 = math.random(-15, 15)

		Wait(100)

		math.randomseed(GetGameTimer())
		local modY2 = math.random(-15, 15)

		weed2CoordX = Config.CircleZones.HydrochloricAcidFarm.coords.x + modX2
		weed2CoordY = Config.CircleZones.HydrochloricAcidFarm.coords.y + modY2

		local coordZ2 = GetCoordZHydrochloricAcid(weed2CoordX, weed2CoordY)
		local coord2 = vector3(weed2CoordX, weed2CoordY, coordZ2)

		if ValidateHydrochloricAcidCoord(coord2) then
			return coord2
		end
	end
end

local function SpawnHydrochloricAcidBarrels()
	while spawnedHydrochloricAcidBarrels < 5 do
		Wait(0)
		local weedCoords = GenerateHydrochloricAcidCoords()
		RequestModel(`mw_hydro_barrel`)
		while not HasModelLoaded(`mw_hydro_barrel`) do
			Wait(100)
		end
		local obj = CreateObject(`mw_hydro_barrel`, weedCoords.x, weedCoords.y, weedCoords.z, true, true, false)
		PlaceObjectOnGroundProperly(obj)
		FreezeEntityPosition(obj, true)
		table.insert(HydrochloricAcidBarrels, obj)
		spawnedHydrochloricAcidBarrels = spawnedHydrochloricAcidBarrels + 1
	end
end

RegisterNetEvent("ps-drugprocessing:client:hydrochloricacid", function()
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed)
	local nearbyObject, nearbyID

	for i=1, #HydrochloricAcidBarrels, 1 do
		if #(coords-GetEntityCoords(HydrochloricAcidBarrels[i])) < 2 then
			nearbyObject, nearbyID = HydrochloricAcidBarrels[i], i
		end
	end

	if nearbyObject and IsPedOnFoot(playerPed) then
		isPickingUp = true
		TaskStartScenarioInPlace(playerPed, 'world_human_gardener_plant', 0, false)
		QBCore.Functions.Progressbar("search_register", Lang:t("progressbar.collecting"), 10000, false, true, {
			disableMovement = true,
			disableCarMovement = true,
			disableMouse = false,
			disableCombat = true,
		}, {}, {}, {}, function()
			ClearPedTasks(playerPed)
			SetEntityAsMissionEntity(nearbyObject, false, true)
			DeleteObject(nearbyObject)

			table.remove(HydrochloricAcidBarrels, nearbyID)
			spawnedHydrochloricAcidBarrels -= 1

			TriggerServerEvent('ps-drugprocessing:pickedUpHydrochloricAcid')
			isPickingUp = false
			ClearPedTasksImmediately(PlayerPedId())
		end, function()
			ClearPedTasks(playerPed)
			ClearPedTasksImmediately(PlayerPedId())
			isPickingUp = false
		end)
	end
end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		for k, v in pairs(HydrochloricAcidBarrels) do
			SetEntityAsMissionEntity(v, false, true)
			DeleteObject(v)
		end
	end
end)

CreateThread(function()
	local hydrochloricZone = CircleZone:Create(Config.CircleZones.HydrochloricAcidFarm.coords, 50.0, {
		name = "ps-hydrochloriczone",
		debugPoly = false
	})
	hydrochloricZone:onPlayerInOut(function(isPointInside, point, zone)
        if isPointInside then
            inhydrochloricField = true
            SpawnHydrochloricAcidBarrels()
        else
            inhydrochloricField = false
        end
    end)
end)