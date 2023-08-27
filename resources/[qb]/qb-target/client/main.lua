local CurrentResourceName = GetCurrentResourceName()
local QBCore, PlayerData
local girdimamk = false
local Config, Types, Bones, Players, Self, Entities, Models, Zones, Functions = Config, Types, Bones, {}, {}, {}, {}, {}, {}
local playerPed, curFlag, targetActive, hasFocus, success, PedsReady, AllowTarget, sendData = PlayerPedId(), 30, false, false, false, false, true, nil
local kaputacik = false
local bagajacik = false
local kapi1 = false
local kapi2 = false
local kapi3 = false
local kapi4 = false
local genel = true
local mechanicLocation = {
	{ x = -341.96, y = -131.52, z = 38.7 },
	{ x = -197.43, y = -1317.73, z = 31.09 },
    { x = 950.71, y = -968.42, z = 39.40 },
    { x = 1179.0, y = 2647.0, z = 37.0 },
    { x = 810.41, y = -2322.26, z = 30.46 },
    { x = 546.47, y = -182.38, z = 54.49 },
    { x = -1415.78, y = -446.37, z = 35.91 },
    { x = -35.34, y = -1052.93, z = 28.4 },
}

-- AddEventHandler('onResourceStop', function(resource)
-- 	if resource == GetCurrentResourceName() then
-- 		QBCore = exports['qb-core']:GetCoreObject()
-- 		PlayerData = QBCore.Functions.GetPlayerData()
-- 		Functions.DeletePeds()
-- 		Wait(500)
-- 		Functions.SpawnPeds()
-- 	end
-- end)


if not Config.Standalone then
	QBCore = exports['qb-core']:GetCoreObject()
	PlayerData = QBCore.Functions.GetPlayerData()

	-- This makes sure that peds only spawn when you are spawned and your PlayerData gets set when you have access to the target
	RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
		PlayerData = QBCore.Functions.GetPlayerData()
		Functions.SpawnPeds()
	end)

	-- This will make sure everything resets and despawns after you logout/disconnect
	RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
		PlayerData = {}
		Functions.DeletePeds()
	end)

	-- This will update the job when a new job has been assigned to a player
	RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo)
		PlayerData = QBCore.Functions.GetPlayerData()
		-- PlayerData.job = job
	end)



	-- This will update the gang when a new gang has been assigned to a player


	-- This will make sure all the PlayerData stays updated
	RegisterNetEvent('QBCore:Client:SetPlayerData', function(val)
		PlayerData = val
	end)

	function Functions.ItemCount(item)
		for k, v in pairs(PlayerData.items) do
			if v.name == item then
				return v.amount
			end
		end
		return 0
	end

	JobCheck = function(job)
		if type(job) == 'table' then
			job = job[PlayerData.job.name]
			if job and PlayerData.job.grade.level >= job then
				return true
			end
		elseif job == 'all' or job == PlayerData.job.name then
			return true
		end
		return false
	end

	function Functions.CheckOptions(data, entity, distance)
		-- print(json.encode(data))
		if (not data.distance or distance <= data.distance)
		-- and data.job and not JobCheck(data.job) then return false 
		and (not data.job or data.job == PlayerData.job.name or (data.job[PlayerData.job.name] and data.job[PlayerData.job.name] <= PlayerData.job.gradelabel))
		-- and (not data.gang or data.gang == PlayerData.gang.name or (data.gang[PlayerData.gang.name] and data.gang[PlayerData.gang.name] <= PlayerData.gang.grade.level))
		and (not data.citizenid or data.citizenid == PlayerData.citizenid or data.citizenid[PlayerData.citizenid])
		and (not data.item or data.item and Functions.ItemCount(data.item) > 0)
		and (not data.canInteract or data.canInteract(entity, distance, data)) then return true
		end
		return false
	end

else
	local firstSpawn = false
	AddEventHandler('playerSpawned', function()
		if not firstSpawn then
			Functions.SpawnPeds()
			firstSpawn = true
		end
	end)

	function Functions.CheckOptions(data, entity, distance)
		if (not data.distance or distance <= data.distance)
		and (not data.canInteract or data.canInteract(entity, distance, data)) then return true
		end
		return false
	end
end


RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
	girdimamk = true
end)


-- Functions
function Functions.AddCircleZone(name, center, radius, options, targetoptions)
	center = type(center) == 'table' and vector3(center.x, center.y, center.z) or center
	Zones[name] = CircleZone:Create(center, radius, options)
	targetoptions.distance = targetoptions.distance or Config.MaxDistance
	Zones[name].targetoptions = targetoptions
end

function Functions.AddBoxZone(name, center, length, width, options, targetoptions)
	center = type(center) == 'table' and vector3(center.x, center.y, center.z) or center
	Zones[name] = BoxZone:Create(center, length, width, options)
	targetoptions.distance = targetoptions.distance or Config.MaxDistance
	Zones[name].targetoptions = targetoptions
end

function AddBoxZone(name, center, length, width, options, targetoptions)
	center = type(center) == 'table' and vector3(center.x, center.y, center.z) or center
	Zones[name] = BoxZone:Create(center, length, width, options)
	targetoptions.distance = targetoptions.distance or Config.MaxDistance
	Zones[name].targetoptions = targetoptions
end

function Functions.AddPolyZone(name, points, options, targetoptions)
	local _points = {}
	if type(points[1]) == 'table' then
		for i = 1, #points do
			_points[i] = vector3(points[i].x, points[i].y)
		end
	end
	Zones[name] = PolyZone:Create(#_points > 0 and _points or points, options)
	targetoptions.distance = targetoptions.distance or Config.MaxDistance
	Zones[name].targetoptions = targetoptions
end

function Functions.AddComboZone(zones, options, targetoptions)
	Zones[name] = ComboZone:Create(zones, options)
	targetoptions.distance = targetoptions.distance or Config.MaxDistance
	Zones[name].targetoptions = targetoptions
end

function Functions.AddTargetBone(bones, parameters)
	local distance, options = parameters.distance or Config.MaxDistance, parameters.options
	if type(bones) == 'table' then
		for _, bone in pairs(bones) do
			if not Bones[bone] then Bones[bone] = {} end
			for k, v in pairs(options) do
				if v.distance == nil or not v.distance or v.distance > distance then v.distance = distance end
				Bones[bone][v.label] = v
			end
		end
	elseif type(bones) == 'string' then
		if not Bones[bones] then Bones[bones] = {} end
		for k, v in pairs(options) do
			if v.distance == nil or not v.distance or v.distance > distance then v.distance = distance end
			Bones[bones][v.label] = v
		end
	end
end

function Functions.AddTargetEntity(entities, parameters)
	local distance, options = parameters.distance or Config.MaxDistance, parameters.options
	if type(entities) == 'table' then
		for _, entity in pairs(entities) do
			entity = NetworkGetEntityIsNetworked(entity) and NetworkGetNetworkIdFromEntity(entity) or false
			if entity then
				if not Entities[entity] then Entities[entity] = {} end
				for k, v in pairs(options) do
					if v.distance == nil or not v.distance or v.distance > distance then v.distance = distance end
					Entities[entity][v.label] = v
				end
			end
		end
	elseif type(entities) == 'number' then
		local entity = NetworkGetEntityIsNetworked(entities) and NetworkGetNetworkIdFromEntity(entities) or false
		if entity then
			if not Entities[entity] then Entities[entity] = {} end
			for k, v in pairs(options) do
				if v.distance == nil or not v.distance or v.distance > distance then v.distance = distance end
				Entities[entity][v.label] = v
			end
		end
	end
end

function Functions.AddEntityZone(name, entity, options, targetoptions)
	Zones[name] = EntityZone:Create(entity, options)
	targetoptions.distance = targetoptions.distance or Config.MaxDistance
	Zones[name].targetoptions = targetoptions
end

function Functions.AddTargetModel(models, parameters)
	local distance, options = parameters.distance or Config.MaxDistance, parameters.options
	if type(models) == 'table' then
		for _, model in pairs(models) do
			if type(model) == 'string' then model = GetHashKey(model) end
			if not Models[model] then Models[model] = {} end
			for k, v in pairs(options) do
				if v.distance == nil or not v.distance or v.distance > distance then v.distance = distance end
				Models[model][v.label] = v
			end
		end
	else
		if type(models) == 'string' then models = GetHashKey(models) end
		if not Models[models] then Models[models] = {} end
		for k, v in pairs(options) do
			if v.distance == nil or not v.distance or v.distance > distance then v.distance = distance end
			Models[models][v.label] = v
		end
	end
end

function Functions.RemoveZone(name)
	if not Zones[name] then return end
	if Zones[name].destroy then
		Zones[name]:destroy()
	end
	Zones[name] = nil
end

function Functions.RemoveTargetBone(bones, labels)
	if type(bones) == 'table' then
		for _, bone in pairs(bones) do
			if type(labels) == 'table' then
				for k, v in pairs(labels) do
					if Bones[bone] then
						Bones[bone][v] = nil
					end
				end
			elseif type(labels) == 'string' then
				if Bones[bone] then
					Bones[bone][labels] = nil
				end
			end
		end
	else
		if type(labels) == 'table' then
			for k, v in pairs(labels) do
				if Bones[bones] then
					Bones[bones][v] = nil
				end
			end
		elseif type(labels) == 'string' then
			if Bones[bones] then
				Bones[bones][labels] = nil
			end
		end
	end
end

function Functions.RemoveTargetModel(models, labels)
	if type(models) == 'table' then
		for _, model in pairs(models) do
			if type(model) == 'string' then model = GetHashKey(model) end
			if type(labels) == 'table' then
				for k, v in pairs(labels) do
					if Models[model] then
						Models[model][v] = nil
					end
				end
			elseif type(labels) == 'string' then
				if Models[model] then
					Models[model][labels] = nil
				end
			end
		end
	else
		if type(models) == 'string' then models = GetHashKey(models) end
		if type(labels) == 'table' then
			for k, v in pairs(labels) do
				if Models[models] then
					Models[models][v] = nil
				end
			end
		elseif type(labels) == 'string' then
			if Models[models] then
				Models[models][labels] = nil
			end
		end
	end
end

function Functions.RemoveTargetEntity(entities, labels)
	if type(entities) == 'table' then
		for _, entity in pairs(entities) do
			entity = NetworkGetEntityIsNetworked(entity) and NetworkGetNetworkIdFromEntity(entity) or false
			if entity then
				if type(labels) == 'table' then
					for k, v in pairs(labels) do
						if Entities[entity] then
							Entities[entity][v] = nil
						end
					end
				elseif type(labels) == 'string' then
					if Entities[entity] then
						Entities[entity][labels] = nil
					end
				end
			end
		end
	elseif type(entities) == 'string' then
		local entity = NetworkGetEntityIsNetworked(entities) and NetworkGetNetworkIdFromEntity(entities) or false
		if entity then
			if type(labels) == 'table' then
				for k, v in pairs(labels) do
					if Entities[entity] then
						Entities[entity][v] = nil
					end
				end
			elseif type(labels) == 'string' then
				if Entities[entity] then
					Entities[entity][labels] = nil
				end
			end
		end
	end
end

function Functions.AddGlobalType(type, parameters)
	local distance, options = parameters.distance or Config.MaxDistance, parameters.options
	for k, v in pairs(options) do
		if v.distance == nil or not v.distance or v.distance > distance then v.distance = distance end
		Types[type][v.label] = v
	end
end

function Functions.AddGlobalPed(parameters) Functions.AddGlobalType(1, parameters) end

function Functions.AddGlobalVehicle(parameters) Functions.AddGlobalType(2, parameters) end

function Functions.AddGlobalObject(parameters) Functions.AddGlobalType(3, parameters) end

function Functions.AddGlobalPlayer(parameters)
	local distance, options = parameters.distance or Config.MaxDistance, parameters.options
	for k, v in pairs(options) do
		if v.distance == nil or not v.distance or v.distance > distance then v.distance = distance end
		Players[v.label] = v
	end
end

function Functions.AddSelfMenu(parameters)
	local distance, options = parameters.distance or Config.MaxDistance, parameters.options
	for k, v in pairs(options) do
		if v.distance == nil or not v.distance or v.distance > distance then v.distance = distance end
		Self[v.label] = v
	end
end

function Functions.RemoveGlobalType(type, labels)
	if type(labels) == 'table' then
		for k, v in pairs(labels) do
			Types[type][v] = nil
		end
	elseif type(labels) == 'string' then
		Types[type][labels] = nil
	end
end

function Functions.RemoveGlobalPed(labels) Functions.RemoveGlobalType(1, labels) end

function Functions.RemoveGlobalVehicle(labels) Functions.RemoveGlobalType(2, labels) end

function Functions.RemoveGlobalObject(labels) Functions.RemoveGlobalType(3, labels) end

function Functions.RemoveGlobalPlayer(labels)
	if type(labels) == 'table' then
		for k, v in pairs(labels) do
			Players[v] = nil
		end
	elseif type(labels) == 'string' then
		Players[labels] = nil
	end
end

function Functions.RaycastCamera(flag)
	local cam = GetGameplayCamCoord()
	local direction = GetGameplayCamRot()
	direction = vec2(math.rad(direction.x), math.rad(direction.z))
	local num = math.abs(math.cos(direction.x))
	direction = vec3((-math.sin(direction.y) * num), (math.cos(direction.y) * num), math.sin(direction.x))
	local destination = vec3(cam.x + direction.x * 30, cam.y + direction.y * 30, cam.z + direction.z * 30)
	local rayHandle = StartShapeTestLosProbe(cam, destination, flag or -1, playerPed or PlayerPedId(), 0)
	while true do
		Wait(0)
		local result, _, endCoords, _, entityHit = GetShapeTestResult(rayHandle)
		if Config.Debug then
			local entCoords = GetEntityCoords(playerPed or PlayerPedId())
			DrawLine(entCoords.x, entCoords.y, entCoords.z, destination.x, destination.y, destination.z, 255, 0, 255, 255)
			DrawLine(destination.x, destination.y, destination.z, endCoords.x, endCoords.y, endCoords.z, 255, 0, 255, 255)
		end
		if result ~= 1 then
			local entityType = 0
			if entityHit ~= 0 then entityType = GetEntityType(entityHit) end
			return flag, endCoords, entityHit, entityType
		end
	end
end


function Functions.IsTargetActive()
	return targetActive
end

function Functions.IsTargetSuccess()
	return success
end

function Functions.GetGlobalTypeData(type, label)
	return Types[type][label]
end

function Functions.GetZoneData(name)
	return Zones[name]
end

function Functions.GetTargetBoneData(bone, label)
	return Bones[bone][label]
end

function Functions.GetTargetEntityData(entity, label)
	return Entities[entity][label]
end

function Functions.GetTargetModelData(model, label)
	return Models[model][label]
end

function Functions.GetGlobalPedData(label)
	return Functions.GetGlobalTypeData(1, label)
end

function Functions.GetGlobalVehicleData(label)
	return Functions.GetGlobalTypeData(2, label)
end

function Functions.GetGlobalObjectData(label)
	return Functions.GetGlobalTypeData(3, label)
end

function Functions.GetGlobalPlayerData(label)
	return Players[label]
end

function Functions.UpdateGlobalTypeData(type, label, data)
	Types[type][label] = data
end

function Functions.UpdateZoneData(name, data)
	Zones[name] = data
end

function Functions.UpdateTargetBoneData(bone, label, data)
	Bones[bone][label] = data
end

function Functions.UpdateTargetEntityData(entity, label, data)
	Entities[entity][label] = data
end

function Functions.UpdateTargetModelData(model, label, data)
	Models[model][label] = data
end

function Functions.UpdateGlobalPedData(label, data)
	Functions.UpdateGlobalTypeData(1, label, data)
end

function Functions.UpdateGlobalVehicleData(label, data)
	Functions.UpdateGlobalTypeData(2, label, data)
end

function Functions.UpdateGlobalObjectData(label, data)
	Functions.UpdateGlobalTypeData(3, label, data)
end

function Functions.UpdateGlobalPlayerData(label, data)
	Players[label] = data
end

function Functions.CloneTable(table)
	local copy = {}
	for k,v in pairs(table) do
		if type(v) == 'table' then
			copy[k] = Functions.CloneTable(v)
		else
			if type(v) == 'function' then v = nil end
			copy[k] = v
		end
	end
	return copy
end

function Functions.switch()
	if curFlag == 30 then curFlag = -1 else curFlag = 30 end
	return curFlag
end

function Functions.EnableTarget()
	exports["tgiann-garajv2"]:checkgarage()
	if not AllowTarget or success and girdimamk then return end
	if not targetActive then
		targetActive = true
		SendNUIMessage({response = "openTarget"})
		CreateThread(function()
			repeat
				SetPauseMenuActive(false)
				if hasFocus then
					DisableControlAction(0, 1, true)
					DisableControlAction(0, 2, true)
				end
				DisablePlayerFiring(PlayerId(), true)
				DisableControlAction(0, 24, true)
				DisableControlAction(0, 25, true)
				DisableControlAction(0, 37, true)
				DisableControlAction(0, 47, true)
				DisableControlAction(0, 58, true)
				DisableControlAction(0, 140, true)
				DisableControlAction(0, 141, true)
				DisableControlAction(0, 142, true)
				DisableControlAction(0, 143, true)
				DisableControlAction(0, 257, true)
				DisableControlAction(0, 263, true)
				DisableControlAction(0, 264, true)
				Wait(0)
			until not targetActive
		end)
		playerPed = PlayerPedId()
		while targetActive do
			local plyCoords = GetEntityCoords(playerPed)
			local hit, coords, entity, entityType = Functions.RaycastCamera(Functions.switch())

			if entityType > 0 then

				-- Owned entity targets
				if NetworkGetEntityIsNetworked(entity) then
					local data = Entities[NetworkGetNetworkIdFromEntity(entity)]
					if data ~= nil then
						Functions.CheckEntity(hit, data, entity, #(plyCoords - coords))
					end
				end

				-- Player and Ped targets
				if entityType == 1 then
					local data = Models[GetEntityModel(entity)]
					if IsPedAPlayer(entity) then data = Players end
					if data ~= nil then
						Functions.CheckEntity(hit, data, entity, #(plyCoords - coords))
					end

				-- Vehicle bones
				elseif entityType == 2 then
					local closestBone, closestPos, closestBoneName = Functions.CheckBones(coords, entity, Config.VehicleBones)
					local datatable = Bones[closestBoneName]
					if closestBone then
						local send_options, send_distance, slot = {}, {}, 0
						for o, data in pairs(datatable) do
							if Functions.CheckOptions(data, entity, #(plyCoords - coords)) then
								slot = #send_options + 1
								send_options[slot] = data
								send_options[slot].entity = entity
								send_distance[data.distance] = true
							else send_distance[data.distance] = false end
						end
						sendData = send_options
						if next(send_options) then
							success = true
							SendNUIMessage({response = "foundTarget", data = sendData[slot].targeticon})
							Functions.DrawOutlineEntity(entity, true)
							while targetActive and success do
								local _, coords, entity2 = Functions.RaycastCamera(hit)
								if entity == entity2 then
									local playerCoords = GetEntityCoords(playerPed)
									local closestBone2 = Functions.CheckBones(coords, entity, Config.VehicleBones)
									local dist = #(playerCoords - coords)

									if closestBone ~= closestBone2 then
										if IsControlReleased(0, Config.OpenControlKey) or IsDisabledControlReleased(0, Config.OpenControlKey) then
											Functions.DisableTarget(true)
										else
											Functions.LeftTarget()
										end
										Functions.DrawOutlineEntity(entity, false)
										break
									elseif not hasFocus and (IsControlPressed(0, Config.MenuControlKey) or IsDisabledControlPressed(0, Config.MenuControlKey)) then
										Functions.EnableNUI(Functions.CloneTable(sendData))
										Functions.DrawOutlineEntity(entity, false)
									else
										for k, v in pairs(send_distance) do
											if v and dist > k then
												if IsControlReleased(0, Config.OpenControlKey) or IsDisabledControlReleased(0, Config.OpenControlKey) then
													Functions.DisableTarget(true)
												else
													Functions.LeftTarget()
												end
												Functions.DrawOutlineEntity(entity, false)
												break
											end
										end
									end
								else
									if IsControlReleased(0, Config.OpenControlKey) or IsDisabledControlReleased(0, Config.OpenControlKey) then
										Functions.DisableTarget(true)
									else
										Functions.LeftTarget()
									end
									Functions.DrawOutlineEntity(entity, false)
									break
								end
								Wait(0)
							end
							if IsControlReleased(0, Config.OpenControlKey) or IsDisabledControlReleased(0, Config.OpenControlKey) then
								Functions.DisableTarget(true)
							else
								Functions.LeftTarget()
							end
							Functions.DrawOutlineEntity(entity, false)
						end
					end

					-- Specific Vehicle targets
					local data = Models[GetEntityModel(entity)]
					if data ~= nil then
						Functions.CheckEntity(hit, data, entity, #(plyCoords - coords))
					end

				-- Entity targets
				elseif entityType > 2 then
					local data = Models[GetEntityModel(entity)]
					if data ~= nil then
						Functions.CheckEntity(hit, data, entity, #(plyCoords - coords))
					end
				end

				-- Generic targets
				if not success then
					local data = Types[entityType]
					if data ~= nil then
						Functions.CheckEntity(hit, data, entity, #(plyCoords - coords))
					end
				end
			end
			if not success then
				-- Zone targets
				for _, zone in pairs(Zones) do
					local distance = #(plyCoords - zone.center)
					if zone:isPointInside(coords) and distance <= zone.targetoptions.distance then
						local send_options, slot = {}, 0
						for o, data in pairs(zone.targetoptions.options) do
							if Functions.CheckOptions(data, entity, distance) then
								slot = #send_options + 1
								send_options[slot] = data
								send_options[slot].entity = entity
							end
						end
						TriggerEvent(CurrentResourceName..':client:enterPolyZone', send_options[slot])
						TriggerServerEvent(CurrentResourceName..':server:enterPolyZone', send_options[slot])
						sendData = send_options
						if next(send_options) then
							success = true
							SendNUIMessage({response = "foundTarget", data = sendData[slot].targeticon})
							Functions.DrawOutlineEntity(entity, true)
							while targetActive and success do
								local playerCoords = GetEntityCoords(playerPed)
								local _, endcoords, entity2 = Functions.RaycastCamera(hit)
								RequestStreamedTextureDict("shared")
								if not HasStreamedTextureDictLoaded("shared") then
									Wait(0)
								end
								SetDrawOrigin(zone.center, 0) --add this
								DrawSprite("shared", "emptydot_32", 0, 0, 0.02, 0.035, 0, 255,255,255, 255.0)
								if not zone:isPointInside(endcoords) then
									if IsControlReleased(0, Config.OpenControlKey) or IsDisabledControlReleased(0, Config.OpenControlKey) then
										Functions.DisableTarget(true)
									else
										Functions.LeftTarget()
									end
									Functions.DrawOutlineEntity(entity, false)
								elseif not hasFocus and (IsControlPressed(0, Config.MenuControlKey) or IsDisabledControlPressed(0, Config.MenuControlKey)) then
									Functions.EnableNUI(Functions.CloneTable(sendData))
									Functions.DrawOutlineEntity(entity, false)
								elseif #(playerCoords - zone.center) > zone.targetoptions.distance then
									if IsControlReleased(0, Config.OpenControlKey) or IsDisabledControlReleased(0, Config.OpenControlKey) then
										Functions.DisableTarget(true)
									else
										Functions.LeftTarget()
									end
									Functions.DrawOutlineEntity(entity, false)
								end
								Wait(0)
							end
							if IsControlReleased(0, Config.OpenControlKey) or IsDisabledControlReleased(0, Config.OpenControlKey) then
								Functions.DisableTarget(true)
							else
								Functions.LeftTarget()
							end
							TriggerEvent(CurrentResourceName..':client:exitPolyZone', send_options[slot])
							TriggerServerEvent(CurrentResourceName..':server:exitPolyZone', send_options[slot])
							Functions.DrawOutlineEntity(entity, false)
						end
					end
				end
			end
			Wait(100)
		end
		Functions.DisableTarget(false)
	end
end

function Functions.EnableNUI(options)
	if targetActive and not hasFocus then
		SetCursorLocation(0.5, 0.5)
		SetNuiFocus(true, true)
		SetNuiFocusKeepInput(true)
		hasFocus = true
		SendNUIMessage({response = "validTarget", data = options})
	end
end

function Functions.DisableNUI()
	SetNuiFocus(false, false)
	SetNuiFocusKeepInput(false)
	hasFocus = false
end

function Functions.LeftTarget()
	SetNuiFocus(false, false)
	SetNuiFocusKeepInput(false)
	success, hasFocus = false, false
	SendNUIMessage({response = "leftTarget"})
end

function Functions.DisableTarget(forcedisable)
	if (targetActive and not hasFocus) or forcedisable then
		SetNuiFocus(false, false)
		SetNuiFocusKeepInput(false)
		Wait(100)
		targetActive, success, hasFocus = false, false, false
		SendNUIMessage({response = "closeTarget"})
	end
end

function Functions.DrawOutlineEntity(entity, bool)
	if Config.EnableOutline then
		if not IsEntityAPed(entity) then
			SetEntityDrawOutline(entity, bool)
		end
	end
end

function Functions.CheckEntity(hit, datatable, entity, distance)
	local send_options, send_distance, slot = {}, {}, 0
	for o, data in pairs(datatable) do
		if Functions.CheckOptions(data, entity, distance) then
			slot = #send_options + 1
			send_options[slot] = data
			send_options[slot].entity = entity
			send_distance[data.distance] = true
		else send_distance[data.distance] = false end
	end
	sendData = send_options
	if next(send_options) then
		success = true
		SendNUIMessage({response = "foundTarget", data = sendData[slot].targeticon})
		Functions.DrawOutlineEntity(entity, true)
		while targetActive and success do
			local playerCoords = GetEntityCoords(playerPed)
			local _, coords, entity2 = Functions.RaycastCamera(hit)
			local dist = #(playerCoords - coords)
			if entity ~= entity2 then
				if IsControlReleased(0, Config.OpenControlKey) or IsDisabledControlReleased(0, Config.OpenControlKey) then
					Functions.DisableTarget(true)
				else
					Functions.LeftTarget()
				end
				Functions.DrawOutlineEntity(entity, false)
				break
			elseif not hasFocus and (IsControlPressed(0, Config.MenuControlKey) or IsDisabledControlPressed(0, Config.MenuControlKey)) then
				Functions.EnableNUI(Functions.CloneTable(sendData))
				Functions.DrawOutlineEntity(entity, false)
			else
				for k, v in pairs(send_distance) do
					if v and dist > k then
						if IsControlReleased(0, Config.OpenControlKey) or IsDisabledControlReleased(0, Config.OpenControlKey) then
							Functions.DisableTarget(true)
						else
							Functions.LeftTarget()
						end
						Functions.DrawOutlineEntity(entity, false)
						break
					end
				end
			end
			Wait(0)
		end
		if IsControlReleased(0, Config.OpenControlKey) or IsDisabledControlReleased(0, Config.OpenControlKey) then
			Functions.DisableTarget(true)
		else
			Functions.LeftTarget()
		end
		Functions.DrawOutlineEntity(entity, false)
	end
end

function Functions.OpenSelfMenu(hit, datatable, entity, distance)
	local send_options, send_distance, slot = {}, {}, 0
	for o, data in pairs(datatable) do
		if Functions.CheckOptions(data, entity, distance) then
			slot = #send_options + 1
			send_options[slot] = data
			send_options[slot].entity = entity
			send_distance[data.distance] = true
		else send_distance[data.distance] = false end
	end
	sendData = send_options
	if next(send_options) then
		success = true
		SendNUIMessage({response = "foundTarget", data = sendData[slot].targeticon})
		Functions.DrawOutlineEntity(entity, true)
		while targetActive and success do
			if (IsControlPressed(0, 238) or IsDisabledControlPressed(0, 238)) then
			    local playerCoords = GetEntityCoords(playerPed)
			    local _, coords, entity2 = Functions.RaycastCamera(hit)
			    local dist = #(playerCoords - coords)
			    if entity ~= entity2 then
				    Functions.EnableNUI(Functions.CloneTable(sendData))
				    Functions.DrawOutlineEntity(entity, false)
			    end
			end
			Wait(0)
		end
		if IsControlReleased(0, Config.OpenControlKey) or IsDisabledControlReleased(0, Config.OpenControlKey) then
			Functions.DisableTarget(true)
		else
			Functions.LeftTarget()
		end
		Functions.DrawOutlineEntity(entity, false)
	end
end

function Functions.CheckBones(coords, entity, bonelist)
	local closestBone, closestDistance, closestPos, closestBoneName = -1, 20
	for k, v in pairs(bonelist) do
		if Bones[v] then
			local boneId = GetEntityBoneIndexByName(entity, v)
			local bonePos = GetWorldPositionOfEntityBone(entity, boneId)
			local distance = #(coords - bonePos)
			if closestBone == -1 or distance < closestDistance then
				closestBone, closestDistance, closestPos, closestBoneName = boneId, distance, bonePos, v
			end
		end
	end
	if closestBone ~= -1 then return closestBone, closestPos, closestBoneName
	else return false end
end

function Functions.AllowTargeting(bool)
	AllowTarget = bool
end

function Functions.SpawnPeds()
	if not PedsReady then
		if next(Config.Peds) then
			for k, v in pairs(Config.Peds) do
				local spawnedped = 0
				local networked = v.networked or false
				RequestModel(v.model)
				while not HasModelLoaded(v.model) do
					Wait(5)
				end

				if type(v.model) == 'string' then v.model = GetHashKey(v.model) end

				if v.minusOne then
					spawnedped = CreatePed(0, v.model, v.coords.x, v.coords.y, v.coords.z - 1.0, v.coords.w, networked, true)
				else
					spawnedped = CreatePed(0, v.model, v.coords.x, v.coords.y, v.coords.z, v.coords.w, networked, true)
				end

				if v.freeze then
					FreezeEntityPosition(spawnedped, true)
				end

				if v.invincible then
					SetEntityInvincible(spawnedped, true)
				end

				if v.blockevents then
					SetBlockingOfNonTemporaryEvents(spawnedped, true)
				end

				if v.animDict and v.anim then
					RequestAnimDict(v.animDict)
					while not HasAnimDictLoaded(v.animDict) do
						Wait(5)
					end

					TaskPlayAnim(spawnedped, v.animDict, v.anim, 8.0, 0, -1, v.flag or 1, 0, 0, 0, 0)
				end

				if v.scenario then
					TaskStartScenarioInPlace(spawnedped, v.scenario, 0, true)
				end

				if v.target then
					Functions.AddTargetModel(v.model, {
						options = v.target.options,
						distance = v.target.distance
					})
				end

				Config.Peds[k].currentpednumber = spawnedped
			end
			PedsReady = true
		end
	end
end

function Functions.DeletePeds()
	if PedsReady then
		if next(Config.Peds) then
			for k, v in pairs(Config.Peds) do
				DeletePed(v.currentpednumber)
				Config.Peds[k].currentpednumber = 0
			end
			PedsReady = false
		end
	end
end

function Functions.GetPeds()
	return Config.Peds
end

function Functions.UpdatePedsData(index, data)
	Config.Peds[index] = data
end

function Functions.SpawnPed(data)
	local spawnedped = 0
	local key, value = next(data)
	if key ~= 'target' and key ~= 'coords' and type(value) == 'table' then
		for k, v in pairs(data) do
			local networked = v.networked or false
			RequestModel(v.model)
			while not HasModelLoaded(v.model) do
				Wait(5)
			end

			if type(v.model) == 'string' then v.model = GetHashKey(v.model) end

			if v.minusOne then
				spawnedped = CreatePed(0, v.model, v.coords.x, v.coords.y, v.coords.z - 1.0, v.coords.w, networked, true)
			else
				spawnedped = CreatePed(0, v.model, v.coords.x, v.coords.y, v.coords.z, v.coords.w, networked, true)
			end

			if v.freeze then
				FreezeEntityPosition(spawnedped, true)
			end

			if v.invincible then
				SetEntityInvincible(spawnedped, true)
			end

			if v.blockevents then
				SetBlockingOfNonTemporaryEvents(spawnedped, true)
			end

			if v.animDict and v.anim then
				RequestAnimDict(v.animDict)
				while not HasAnimDictLoaded(v.animDict) do
					Wait(5)
				end

				TaskPlayAnim(spawnedped, v.animDict, v.anim, 8.0, 0, -1, v.flag or 1, 0, 0, 0, 0)
			end

			if v.scenario then
				TaskStartScenarioInPlace(spawnedped, v.scenario, 0, true)
			end

			if v.target then
				Functions.AddTargetModel(v.model, {
					options = v.target.options,
					distance = v.target.distance
				})
			end
			v.currentpednumber = spawnedped

			local nextnumber = #Config.Peds + 1
			if nextnumber <= 0 then
				nextnumber = 1
			end

			Config.Peds[nextnumber] = v
		end
	else
		if key ~= 'target' and key ~= 'coords' and type(value) == 'table' then
			if Config.Debug then
			end
			return
		end
		local networked = data.networked or false
		RequestModel(data.model)
		while not HasModelLoaded(data.model) do
			Wait(5)
		end

		if type(data.model) == 'string' then data.model = GetHashKey(data.model) end

		if data.minusOne then
			spawnedped = CreatePed(0, data.model, data.coords.x, data.coords.y, data.coords.z - 1.0, data.coords.w, networked, true)
		else
			spawnedped = CreatePed(0, data.model, data.coords.x, data.coords.y, data.coords.z, data.coords.w, networked, true)
		end

		if data.freeze then
			FreezeEntityPosition(spawnedped, true)
		end

		if data.invincible then
			SetEntityInvincible(spawnedped, true)
		end

		if data.blockevents then
			SetBlockingOfNonTemporaryEvents(spawnedped, true)
		end

		if data.animDict and data.anim then
			RequestAnimDict(data.animDict)
			while not HasAnimDictLoaded(data.animDict) do
				Wait(5)
			end

			TaskPlayAnim(spawnedped, data.animDict, data.anim, 8.0, 0, -1, data.flag or 1, 0, 0, 0, 0)
		end

		if data.scenario then
			TaskStartScenarioInPlace(spawnedped, data.scenario, 0, true)
		end

		if data.target then
			Functions.AddTargetModel(data.model, {
				options = data.target.options,
				distance = data.target.distance
			})
		end

		data.currentpednumber = spawnedped

		local nextnumber = #Config.Peds + 1
		if nextnumber <= 0 then
			nextnumber = 1
		end

		Config.Peds[nextnumber] = data
	end
end

-- Exports
exports("AddCircleZone", Functions.AddCircleZone)

exports("AddBoxZone", Functions.AddBoxZone)

exports("AddPolyZone", Functions.AddPolyZone)

exports("AddComboZone", Functions.AddComboZone)

exports("AddTargetBone", Functions.AddTargetBone)

exports("AddTargetEntity", Functions.AddTargetEntity)

exports("AddEntityZone", Functions.AddEntityZone)

exports("AddTargetModel", Functions.AddTargetModel)

exports("RemoveZone", Functions.RemoveZone)

exports("RemoveTargetModel", Functions.RemoveTargetModel)

exports("RemoveTargetEntity", Functions.RemoveTargetEntity)

exports("AddGlobalType", Functions.AddGlobalType)

exports("AddGlobalPed", Functions.AddGlobalPed)

exports("AddGlobalVehicle", Functions.AddGlobalVehicle)

exports("AddGlobalObject", Functions.AddGlobalObject)

exports("AddGlobalPlayer", Functions.AddGlobalPlayer)

exports("RemoveGlobalType", Functions.RemoveGlobalType)

exports("RemoveGlobalPed", Functions.RemoveGlobalPed)

exports("RemoveGlobalVehicle", Functions.RemoveGlobalVehicle)

exports("RemoveGlobalObject", Functions.RemoveGlobalObject)

exports("RemoveGlobalPlayer", Functions.RemoveGlobalPlayer)

exports("IsTargetActive", function()
	return Functions.IsTargetActive()
end)

exports("IsTargetSuccess", function()
	return Functions.IsTargetSuccess()
end)

exports("GetGlobalTypeData", function(type, label)
	return Functions.GetGlobalTypeData(type, label)
end)

exports("GetZoneData", function(name)
	return Functions.GetZoneData(name)
end)

exports("GetTargetBoneData", function(bone)
	return Functions.GetTargetBoneData(bone)
end)

exports("GetTargetEntityData", function(entity, label)
	return Functions.GetTargetEntityData(entity, label)
end)

exports("GetTargetModelData", function(model, label)
	return Functions.GetTargetModelData(model, label)
end)

exports("GetGlobalPedData", function(label)
	return Functions.GetGlobalPedData(label)
end)

exports("GetGlobalVehicleData", function(label)
	return Functions.GetGlobalVehicleData(label)
end)

exports("GetGlobalObjectData", function(label)
	return Functions.GetGlobalObjectData(label)
end)

exports("GetGlobalPlayerData", function(label)
	return Functions.GetGlobalPlayerData(label)
end)

exports("UpdateZoneData", Functions.UpdateZoneData)

exports("UpdateTargetBoneData", Functions.UpdateTargetBoneData)

exports("UpdateTargetEntityData", Functions.UpdateTargetEntityData)

exports("UpdateTargetModelData", Functions.UpdateTargetModelData)

exports("UpdateGlobalPedData", Functions.UpdateGlobalPedData)

exports("UpdateGlobalVehicleData", Functions.UpdateGlobalVehicleData)

exports("UpdateGlobalObjectData", Functions.UpdateGlobalObjectData)

exports("UpdateGlobalPlayerData", Functions.UpdateGlobalPlayerData)

exports("SpawnPed", Functions.SpawnPed)

exports("GetPeds", function()
	return Functions.GetPeds()
end)

exports("UpdatePedsData", Functions.UpdatePedsData)

exports("AllowTargeting", Functions.AllowTargeting)

exports("FetchFunctions", function()
    return Functions
end)

-- NUI Callbacks
RegisterNUICallback('selectTarget', function(option, cb)
    SetNuiFocus(false, false)
    SetNuiFocusKeepInput(false)
	Wait(100)
	targetActive, success, hasFocus = false, false, false
    local data = sendData[option]
	if not data then return end
	if not next(sendData) then return end
    CreateThread(function()
        Wait(50)
        if data.action then
            data.action(data.entity)
        elseif data.event then
            if data.type == "client" then
                TriggerEvent(data.event, data)
            elseif data.type == "server" then
                TriggerServerEvent(data.event, data)
            elseif data.type == "command" then
                ExecuteCommand(data.event)
            elseif data.type == "qbcommand" then
                TriggerServerEvent('QBCore:CallCommand', data.event, data)
            else
                TriggerEvent(data.event, data)
            end
        else
            print("No trigger setup")
        end
    end)

    sendData = nil
end)

RegisterNUICallback('closeTarget', function(data, cb)
	SetNuiFocus(false, false)
	SetNuiFocusKeepInput(false)
	Wait(100)
	targetActive, success, hasFocus = false, false, false
end)

-- Startup thread
CreateThread(function()
    RegisterCommand('+playerTarget', Functions.EnableTarget, false)
    RegisterCommand('-playerTarget', Functions.DisableTarget, false)
    RegisterKeyMapping("+playerTarget", "ALT (Göz) Target", "keyboard", Config.OpenKey)
    TriggerEvent("chat:removeSuggestion", "/+playerTarget")
    TriggerEvent("chat:removeSuggestion", "/-playerTarget")

    if next(Config.CircleZones) then
        for k, v in pairs(Config.CircleZones) do
            Functions.AddCircleZone(v.name, v.coords, v.radius, {
                name = v.name,
                debugPoly = v.debugPoly,
            }, {
                options = v.options,
                distance = v.distance
            })
        end
    end

    if next(Config.BoxZones) then
        for k, v in pairs(Config.BoxZones) do
            Functions.AddBoxZone(v.name, v.coords, v.length, v.width, {
                name = v.name,
                heading = v.heading,
                debugPoly = v.debugPoly,
                minZ = v.minZ,
                maxZ = v.maxZ
            }, {
                options = v.options,
                distance = v.distance
            })
        end
    end

    if next(Config.PolyZones) then
        for k, v in pairs(Config.PolyZones) do
            Functions.AddPolyZone(v.name, v.points, {
                name = v.name,
                debugPoly = v.debugPoly,
                minZ = v.minZ,
                maxZ = v.maxZ
            }, {
                options = v.options,
                distance = v.distance
            })
        end
    end

    if next(Config.TargetBones) then
        for k, v in pairs(Config.TargetBones) do
            Functions.AddTargetBone(v.bones, {
                options = v.options,
                distance = v.distance
            })
        end
    end

    if next(Config.TargetEntities) then
        for k, v in pairs(Config.TargetEntities) do
            Functions.AddTargetEntity(v.entity, {
                options = v.options,
                distance = v.distance
            })
        end
    end

    if next(Config.TargetModels) then
        for k, v in pairs(Config.TargetModels) do
            Functions.AddTargetModel(v.models, {
                options = v.options,
                distance = v.distance
            })
        end
    end

    if next(Config.GlobalPedOptions) then
        Functions.AddGlobalPed(Config.GlobalPedOptions)
    end

    if next(Config.GlobalVehicleOptions) then
        Functions.AddGlobalVehicle(Config.GlobalVehicleOptions)
    end

    if next(Config.GlobalObjectOptions) then
        Functions.AddGlobalObject(Config.GlobalObjectOptions)
    end

    if next(Config.GlobalPlayerOptions) then
        Functions.AddGlobalPlayer(Config.GlobalPlayerOptions)
    end

	if next(Config.GlobalSelfMenu) then
        Functions.AddSelfMenu(Config.GlobalSelfMenu)
    end
end)

-- Events

-- This is to make sure the peds spawn on restart too instead of only when you load/log-in.
AddEventHandler('onResourceStart', function(resource)
	if resource == CurrentResourceName then
		Functions.SpawnPeds()
	end
end)

-- This will delete the peds when the resource stops to make sure you don't have random peds walking
AddEventHandler('onResourceStop', function(resource)
	if resource == CurrentResourceName then
		Functions.DeletePeds()
	end
end)

-- Debug Options
-- Debug Options
if Config.Debug then
	AddEventHandler(CurrentResourceName..':debug', function(data)
		print('Flag: '..curFlag, 'Entity: '..data.entity, 'Entity Model: '..GetEntityModel(data.entity), 'Type: '..GetEntityType(data.entity))
		if data.remove then
			Functions.RemoveTargetEntity(data.entity, 'HelloWorld')
		else
			Functions.AddTargetEntity(data.entity, {
				options = {
					{
						type = "client",
						event = CurrentResourceName..':debug',
						icon = "fas fa-box-circle-check",
						label = "HelloWorld",
						remove = true
					},
				},
				distance = 3.0
			})
		end
	end)

	Functions.AddGlobalPed({
		options = {
			{
				type = "client",
				event = CurrentResourceName..':debug',
				icon = "fas fa-male",
				label = "(Debug) Ped",
			},
		},
		distance = Config.MaxDistance
	})

	Functions.AddGlobalVehicle({
		options = {
			{
				type = "client",
				event = CurrentResourceName..':debug',
				icon = "fas fa-car",
				label = "(Debug) Vehicle",
			},
		},
		distance = Config.MaxDistance
	})

	Functions.AddGlobalObject({
		options = {
			{
				type = "client",
				event = CurrentResourceName..':debug',
				icon = "fas fa-cube",
				label = "(Debug) Object",
			},
		},
		distance = Config.MaxDistance
	})

	Functions.AddGlobalPlayer({
		options = {
			{
				type = "client",
				event = CurrentResourceName..':debug',
				icon = "fas fa-cube",
				label = "(Debug) Player",
			},
		},
		distance = Config.MaxDistance
	})
end

RegisterNetEvent("polis:silahtamir")
AddEventHandler("polis:silahtamir", function()
    QBCore.Functions.Notify("Üstünde Silah Olarak Sadece Tamir Edeceğin Silah Olduğundan Emin Ol Yoksa Yanlış Silahı Tamir Edebilirsin!", "error", 25000)
    QBCore.UI.Menu.Open('default', GetCurrentResourceName(), 'npc_craft', {
        title    = "Silah Tamir Menüsü",
        align    = 'top-left',
        elements = {
            {label = "Tabanca Tamir Et", value = "pistol"},
            {label = "SMG Tamir Et", value = "smg"},
            {label = "Tüfek Tamir Et", value = "taarruz"},
            {label = "Taser ve Yakın Dövüş Silahlarını Tamir Et", value = "diger"},
        }
    },function(data, menu)
        if data.current.value then	
            SetCurrentPedWeapon(PlayerPedId(), `WEAPON_UNARMED`, true)
            TriggerServerEvent("tgiann-merrtweather:repair-weapon", data.current.value, true)
            menu.close()
        end
    end, function(data, menu)
        menu.close()
    end)
    --break
end)

RegisterNetEvent("ems:trash")
AddEventHandler("ems:trash", function()
    TriggerEvent("inventory:client:SetCurrentStash", "emstrash", QBCore.Key)
    TriggerServerEvent("inventory:server:OpenInventory", "stash", "emstrash", {maxweight = 4000000,slots = 300})
end)

RegisterNetEvent("ems:kisisel")
AddEventHandler("ems:kisisel", function()
    TriggerEvent("inventory:client:SetCurrentStash", "EMS_"..QBCore.Functions.GetPlayerData().citizenid, QBCore.Key)
    TriggerServerEvent("inventory:server:OpenInventory", "stash", "EMS_"..QBCore.Functions.GetPlayerData().citizenid)
end)

RegisterNetEvent("ems:techizat")
AddEventHandler("ems:techizat", function()
    TriggerServerEvent("inventory:server:OpenInventory", "shop", "police", Config.Ems)
end)



RegisterNetEvent("polis:kasapara")
AddEventHandler("polis:kasapara", function()
	local keyboard = exports['qb-input']:ShowInput({
		header = "Polis kasasına para yok!",
		submitText = "Onayla",
		inputs = {
			{
				type = 'text',
				isRequired = true,
				text = "Para Miktarı Girin",
				name = 'input',
			}
		}
	})
	local keyboard = keyboard.input
    TriggerServerEvent("tgiann-police:put-money", keyboard)
	-- TriggerServerEvent('DiscordBot:ToDiscord', 'diger', 'İsimli Oyuncu Polis Kaasasına' ..keyboard.. "$ Para Yatırdı".. os.dat e("%H:%M:%S"), source)
end)

RegisterNetEvent("polis:depo")
AddEventHandler("polis:depo", function()
    TriggerEvent("inventory:client:SetCurrentStash", "policeevidence", QBCore.Key)
    TriggerServerEvent("inventory:server:OpenInventory", "stash", "policeevidence", {maxweight = 4000000,slots = 500})
end)

RegisterNetEvent("polis:trash")
AddEventHandler("polis:trash", function()
    TriggerEvent("inventory:client:SetCurrentStash", "policetrash", QBCore.Key)
    TriggerServerEvent("inventory:server:OpenInventory", "stash", "policetrash", {maxweight = 4000000,slots = 300})
end)

-- RegisterNetEvent("pd:kisisel")
-- AddEventHandler("pd:kisisel", function()
--     TriggerEvent("inventory:client:SetCurrentStash", "Polis_"..QBCore.Functions.GetPlayerData().citizenid, QBCore.Key)
-- 	TriggerServerEvent("inventory:server:OpenInventory", "stash", "Polis_"..QBCore.Functions.GetPlayerData().citizenid)
-- end)

RegisterNetEvent("polis:cephanelik")
AddEventHandler("polis:cephanelik", function()
    TriggerServerEvent("inventory:server:OpenInventory", "shop", "police", Config.Polis)
end)




RegisterNetEvent("polis:cephanelikrutbeli")
AddEventHandler("polis:cephanelikrutbeli", function()
	if PlayerData.job.grade >= 8 then 
    TriggerServerEvent("inventory:server:OpenInventory", "shop", "police", Config.PolisRutbeli)
	else
		QBCore.Functions.Notify('Rütben Bu Cephaneliği Açmana Yetmiyor!', 'error')
	end
end)

RegisterNetEvent("polis:mekanik")
AddEventHandler("polis:mekanik", function()
    TriggerEvent("tgiann-mekanik:polisjob")
end)

RegisterNetEvent("ybindir:ybindir")
AddEventHandler("ybindir:ybindir", function()
    ExecuteCommand('ybindir')
end)

-- RegisterNetEvent("tasi")
-- AddEventHandler("tasi", function()
--     ExecuteCommand('taşı')
-- end)

RegisterNetEvent("kucakla")
AddEventHandler("kucakla", function()
    ExecuteCommand('kucakla')
end)


RegisterNetEvent("tasi")
AddEventHandler("tasi", function()
    ExecuteCommand('taşı')
end)


RegisterNetEvent("kilitkir")
AddEventHandler("kilitkir", function()
	local playerPed = PlayerPedId()
    local coords = GetEntityCoords(playerPed)
    local vehicle = QBCore.Functions.GetClosestVehicle(coords)
		local playerPed = PlayerPedId()
		local lock = GetVehicleDoorLockStatus(vehicle)
		kilitac = true
		TriggerEvent("kilitacaq")
		QBCore.Functions.Progressbar("vehicle_repair", "Kapının Kilidi Kırılıyor", 16000, false, true, { -- p1: menu name, p2: yazı, p3: ölü iken kullan, p4:iptal edilebilir
		disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
		}, {}, {}, {}, function() -- Done
		SetVehicleDoorsLocked(vehicle, 1)
		SetVehicleDoorsLockedForAllPlayers(vehicle, false)
		QBCore.Functions.Notify('Aracın Kilidi Açıldı')
		kilitac = false
	end, function() -- Cancel
		IsBusy = false
		kilitac = false
	end)
end)

-- RegisterNetEvent("imodifiye")
-- AddEventHandler("imodifiye", function()
-- 	local playerPed = PlayerPedId()
--     local coords = GetEntityCoords(playerPed)
--     local vehicle = QBCore.Functions.GetClosestVehicle(coords)
-- 	local kaput = GetEntityBoneIndexByName(vehicle, 'engine')
-- 	local kaputkordinat = GetWorldPositionOfEntityBone(vehicle, kaput)
-- 	if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), kaputkordinat, true) <= 2.3 then
-- 	QBCore.Functions.Progressbar("vehicle_repair", "Araç İnceleniyor", 16000, false, true, { -- p1: menu name, p2: yazı, p3: ölü iken kullan, p4:iptal edilebilir
-- 	disableMovement = true,
-- 	disableCarMovement = true,
-- 	disableMouse = false,
-- 	disableCombat = true,
-- }, {
-- 	animDict = "amb@prop_human_bum_bin@base",
-- 	anim = "base",
-- 	flags = 128,
-- }, {}, {}, function() -- Done
-- 		QBCore.Functions.TriggerCallback('carmod:isChiped', function(chiped)
-- 			if chiped then
-- 				QBCore.Functions.Notify("Araçta Tunner Çip Takılı")
-- 			else
-- 				QBCore.Functions.Notify("Araç Temiz")
-- 			end
-- 		end, GetVehicleNumberPlateText(vehicle))
-- 	end, function() -- Cancel
-- 		QBCore.Functions.Notify('İşlem İptal Edildi', "error")
-- 	end)

-- else
-- 	QBCore.Functions.Notify('Kontrol İçin Kaputa Yakın Olmalısın', "error")
-- end

-- end)

-- RegisterCommand("imodifiyearastir", function()
-- 	local playerPed = PlayerPedId()
--     local coords = GetEntityCoords(playerPed)
--     local vehicle = QBCore.Functions.GetClosestVehicle(coords)
-- 	QBCore.Functions.TriggerCallback('carmod:isChiped', function(chiped)
-- 		if chiped then
-- 			QBCore.Functions.Notify("Araçta Tunner Çip Takılı")
-- 		else
-- 			QBCore.Functions.Notify("Araç Temiz")
-- 		end
-- 	end, GetVehicleNumberPlateText(vehicle))
-- end)




function GetClosestPlayerMenu()
	local player, distance = QBCore.Functions.GetClosestPlayer()
	if distance ~= -1 and distance <= 3.0 then
		return true, GetPlayerServerId(player)
	else
		return false
	end
end

RegisterNetEvent("emssandalye")
AddEventHandler("emssandalye", function()
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed)
	local vehicle, mesafe = QBCore.Functions.GetClosestVehicle(coords)
	if not inVehicle then
		if mesafe > 2 then
			local playerheading = GetEntityHeading(playerPed)
			local spawnpoint = GetOffsetFromEntityInWorldCoords(playerPed, 0.0, 1.0, 0.5)

			QBCore.Functions.SpawnVehicle(`npwheelchair`, function(veh)
				local vehicle = veh  
				TriggerEvent("x-hotwire:give-keys", vehicle)
			end, {x=spawnpoint.x, y=spawnpoint.y, z=coords.z-1, h=playerheading }, true)
		else
			if IsVehicleModel(vehicle, `npwheelchair`) then
				if mesafe < 5 then
					QBCore.Functions.DeleteVehicle(vehicle)
				end
			else
				QBCore.Functions.Notify("Yakınında Araç Varken Tekerlekli Sandalye Çıkaramazsın!", "error", 5000)
			end
		end
	else
		QBCore.Functions.Notify("Araç İçindeyken Bunu Yapamazsın!", "error")
	end
end)

RegisterNetEvent("makanikfatura")
AddEventHandler("makanikfatura", function()
	local found, player = GetClosestPlayerMenu()
	if not found then 
		QBCore.Functions.Notify("Yakında Oyuncu Yok", "error")
		return 
	end
	TriggerEvent("tgiann-meslekmekanik:TgiannFatura", player)
end)

RegisterNetEvent("emsigne")
AddEventHandler("emsigne", function()
	local found, player = GetClosestPlayerMenu()
	if not found then 
		QBCore.Functions.Notify("Yakında Oyuncu Yok", "error")
		return 
	end
	TriggerEvent("esx_ambulancejob:TgiannIgne", player)
end)


RegisterNetEvent("iyilestiraq")
AddEventHandler("iyilestiraq", function()
	local found, player = GetClosestPlayerMenu()
	if not found then 
		QBCore.Functions.Notify("Yakında Oyuncu Yok", "error")
		return 
	end
	TriggerEvent("esx_ambulancejob:TgiannCanlandir", player)
end)

RegisterNetEvent("polis:kamu")
AddEventHandler("polis:kamu", function()
	local found, player = GetClosestPlayerMenu()
	if not found then return end
	TriggerEvent('esx_policejob:kamu', player)
end)

RegisterNetEvent("polis:cezabak")
AddEventHandler("polis:cezabak", function()
	local found, player = GetClosestPlayerMenu()
	if not found then return end
	TriggerEvent('esx_policejob:cezalarinabak', player)
end)



RegisterNetEvent("polis:kimlik")
AddEventHandler("polis:kimlik", function()
	local found, player = GetClosestPlayerMenu()
    if PlayerData.job.name >= "police" then 
        if not found then 
            QBCore.Functions.Notify('Yakında Oyuncu Yok', "error")
            return 
        end
        local model = `prop_police_phone`
        while not HasModelLoaded(model) do print("model") RequestModel(model) Citizen.Wait(100) end
        local prop = CreateObject(`prop_police_phone`, 1.0, 1.0, 1.0, 1, 1, 0)
        AttachEntityToEntity(prop, playerPed, GetPedBoneIndex(playerPed, 57005), 0.12, 0.01, -0.045, 110.0, 120.0, -15.0, 1, 0, 0, 0, 2, 1)
        SetModelAsNoLongerNeeded(model)
        while (not HasAnimDictLoaded("paper_1_rcm_alt1-9")) do RequestAnimDict("paper_1_rcm_alt1-9") Citizen.Wait(100) end
        TaskPlayAnim(playerPed, "paper_1_rcm_alt1-9", "player_one_dual-9", 1.0, 1.0, 5500, 33, 1, false, false, false)
        TriggerServerEvent("jsfour-idcard:server:open-pd", player)
        Citizen.Wait(3100)
        DeleteEntity(prop)
    end
end)

-- RegisterNetEvent("imodifiyesok")
-- AddEventHandler("imodifiyesok", function()
-- 	local playerPed = PlayerPedId()
--     local coords = GetEntityCoords(playerPed)
--     local vehicle = QBCore.Functions.GetClosestVehicle(coords)
-- 	local kaput = GetEntityBoneIndexByName(vehicle, 'engine')
-- 	local kaputkordinat = GetWorldPositionOfEntityBone(vehicle, kaput)
-- 	if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), kaputkordinat, true) <= 2.3 then
-- 		QBCore.Functions.TriggerCallback('carmod:isChiped', function(chiped)
-- 			if chiped then
-- 				QBCore.Functions.Notify("Araç Temiz")
-- 			end
-- 			print(chiped, "araç temizmi la")
-- 			QBCore.Functions.Progressbar("vehicle_repair", "Çip Sökülüyor", 16000, false, true, { -- p1: menu name, p2: yazı, p3: ölü iken kullan, p4:iptal edilebilir
-- 			disableMovement = true,
-- 		disableCarMovement = true,
-- 		disableMouse = false,
-- 		disableCombat = true,
-- 	}, {
-- 		animDict = "amb@prop_human_bum_bin@base",
-- 		anim = "base",
-- 		flags = 128,
-- 	}, {}, {}, function() -- Done
-- 		TriggerServerEvent("carmod:chipRemove", GetVehicleNumberPlateText(vehicle))
-- 				QBCore.Functions.Notify("illegal Modifiye Söküldü")
-- 		end, GetVehicleNumberPlateText(vehicle))
-- 	end, function() -- Cancel
-- 		QBCore.Functions.Notify('İşlem İptal Edildi', "error")
-- 	end)

-- 	else
-- 		QBCore.Functions.Notify('Kontrol İçin Kaputa Yakın Olmalısın', "error")
-- 	end
-- end)

-- RegisterNetEvent("imodifiye")
-- AddEventHandler("imodifiye", function()
-- 	local playerPed = PlayerPedId()
--     local coords = GetEntityCoords(playerPed)
--     local vehicle = QBCore.Functions.GetClosestVehicle(coords)
-- 	local kaput = GetEntityBoneIndexByName(vehicle, 'engine')
-- 	local kaputkordinat = GetWorldPositionOfEntityBone(vehicle, kaput)
-- 	if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), kaputkordinat, true) <= 2.3 then
-- 	QBCore.Functions.Progressbar("vehicle_repair", "Araç İnceleniyor", 16000, false, true, { -- p1: menu name, p2: yazı, p3: ölü iken kullan, p4:iptal edilebilir
-- 	disableMovement = true,
-- 	disableCarMovement = true,
-- 	disableMouse = false,
-- 	disableCombat = true,
-- }, {
-- 	animDict = "amb@prop_human_bum_bin@base",
-- 	anim = "base",
-- 	flags = 128,
-- }, {}, {}, function() -- Done
-- 		QBCore.Functions.TriggerCallback('carmod:isChiped', function(chiped)
-- 			if chiped then
-- 				QBCore.Functions.Notify("Araçta Tunner Çip Takılı")
-- 			else
-- 				QBCore.Functions.Notify("Araç Temiz")
-- 			end
-- 		end, GetVehicleNumberPlateText(vehicle))
-- 	end, function() -- Cancel
-- 		QBCore.Functions.Notify('İşlem İptal Edildi', "error")
-- 	end)

-- else
-- 	QBCore.Functions.Notify('Kontrol İçin Kaputa Yakın Olmalısın', "error")
-- end

-- end)




RegisterNetEvent('kilitacaq')
AddEventHandler('kilitacaq', function()
	local Ped = PlayerPedId()
	RequestAnimDict("veh@break_in@0h@p_m_one@")
	while not HasAnimDictLoaded("veh@break_in@0h@p_m_one@") do
		Citizen.Wait(0)
	end
	while kilitac do
		TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 3.0, 'lockpick', 0.4)
		TaskPlayAnim(Ped, "veh@break_in@0h@p_m_one@", "low_force_entry_ds", 1.0, 1.0, 1.0, 16, 0.0, 0, 0, 0)
		Citizen.Wait(1500)
		ClearPedTasks(Ped)
		TaskPlayAnim(Ped, "veh@break_in@0h@p_m_one@", "low_force_entry_ds", 1.0, 1.0, 1.0, 16, 0.0, 0, 0, 0)
		Citizen.Wait(1500)
		ClearPedTasks(Ped)
		TaskPlayAnim(Ped, "veh@break_in@0h@p_m_one@", "low_force_entry_ds", 1.0, 1.0, 1.0, 16, 0.0, 0, 0, 0)
		Citizen.Wait(1500)
		ClearPedTasks(Ped)
		TaskPlayAnim(Ped, "veh@break_in@0h@p_m_one@", "low_force_entry_ds", 1.0, 1.0, 1.0, 16, 0.0, 0, 0, 0)
		Citizen.Wait(1250)
	end
	ClearPedTasks(Ped)
end)

-- RegisterNetEvent('arac:cekpolicefull')
-- AddEventHandler('arac:cekpolicefull', function()
-- 	if PlayerData.job.name == "police" then
--         local playerPed = PlayerPedId()
--         local coords = GetEntityCoords(playerPed)
--         local vehicle, mesafe = QBCore.Functions.GetClosestVehicle(coords)
--         if mesafe < 8 then
--             QBCore.Functions.Progressbar("full_impound", "Araç Çekiliyor(Full Impound)", 35000, false, true, { -- p1: menu name, p2: yazı, p3: ölü iken kullan, p4:iptal edilebilir
--                 disableMovement = true,
--                 disableCarMovement = true,
--                 disableMouse = false,
--                 disableCombat = true,
--             }, {}, {}, {}, function() -- Done
--                 if not inVehicle then
--                     if DoesEntityExist(vehicle) then
--                         deleteVeh(vehicle)
--                     Citizen.Wait(3000)
-- 						local properties = QBCore.Functions.GetVehicleProperties(vehicle)
-- 						local plate = properties["plate"]
-- 						TriggerServerEvent("haso_aracgg", plate, properties)
--                         TriggerServerEvent("tgiann-menuv2:impound", QBCore.Shared.Trim(GetVehicleNumberPlateText(vehicle)))
--                     end
--                 end
--             end, function() -- Cancel
--             end)
--         end
--     else
--         QBCore.Functions.Notify("Polis Değilsin")
--     end
-- end)



RegisterNetEvent('arac:cek')
AddEventHandler('arac:cek', function()
        local playerPed = PlayerPedId()
        local coords = GetEntityCoords(playerPed)
        local vehicle, mesafe = QBCore.Functions.GetClosestVehicle(coords)
        if mesafe < 8 then
            if not inVehicle then
                if DoesEntityExist(vehicle) then
                    deleteVeh(vehicle)
                    Citizen.Wait(3000)
					local properties = QBCore.Functions.GetVehicleProperties(vehicle)
                    if PlayerData.job.name == "police" then
                        local para = exports["elixir-base"]:itemPrice('PolisAracCek')
                        QBCore.Functions.Notify("Araç Çektin ve Çektiğin İçin " .. para .. " Dolar Aldın")
                        TriggerServerEvent("menu:TgiannParaVer", para, QBCore.Key)
                    end
                end
            end
        end
end)

function deleteVeh(veh)
	SetVehicleHasBeenOwnedByPlayer(veh, true)
	NetworkRequestControlOfEntity(veh)
	TaskStartScenarioInPlace(PlayerPedId(), 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)

	QBCore.Functions.Progressbar("arac_cek", "Araç Çekiliyor...", 25000, false, false, { -- p1: menu name, p2: yazı, p3: ölü iken kullan, p4:iptal edilebilir
		disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
	}, {}, {}, {}, function() -- Done
		Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(veh))
		DeleteEntity(veh)
		DeleteVehicle(veh)
		SetEntityAsNoLongerNeeded(veh)
        ClearPedTasksImmediately(PlayerPedId()) 
	end, function() -- Cancel
		ClearPedTasksImmediately(PlayerPedId()) 
	end)
end


RegisterNetEvent('araciyukle')
AddEventHandler('araciyukle', function()
    if PlayerData.job.name == "police" or string.find(PlayerData.job.name, "mechanic") then
        local playerPed = PlayerPedId()
        local coords = GetEntityCoords(playerPed)
        local vehicle, mesafe = QBCore.Functions.GetClosestVehicle(coords)
        local inVehicle = IsPedInAnyVehicle(playerPed, false)
		local inVhicleId = 0
		local vehicle, mesafe = 0, 999
		if inVehicle then
			inVhicleId =  GetVehiclePedIsIn(playerPed, false)
		else
			vehicle, mesafe = QBCore.Functions.GetClosestVehicle(coords)
		end
		if mesafe < 4.0 then
            TriggerEvent("tgiann-meslekmekanik:yukleyici", vehicle)
        else
            QBCore.Functions.Notify('Yakınlarda Araç Yok')
        end
	end
end)

RegisterNetEvent('aracitemizle')
AddEventHandler('aracitemizle', function()
    if PlayerData.job.name == "police" or string.find(PlayerData.job.name, "mechanic") then
        local playerPed = PlayerPedId()
        local coords = GetEntityCoords(playerPed)
        local vehicle, mesafe = QBCore.Functions.GetClosestVehicle(coords)
        local inVehicle = IsPedInAnyVehicle(playerPed, false)
		local inVhicleId = 0
		local vehicle, mesafe = 0, 999
		if inVehicle then
			inVhicleId =  GetVehiclePedIsIn(playerPed, false)
		else
			vehicle, mesafe = QBCore.Functions.GetClosestVehicle(coords)
		end
		if DoesEntityExist(vehicle) and mesafe < 2 then
            TaskStartScenarioInPlace(playerPed, 'WORLD_HUMAN_MAID_CLEAN', 0, true)
            Citizen.Wait(10000)
            SetVehicleDirtLevel(vehicle, 0)
            ClearPedTasksImmediately(playerPed)
            QBCore.Functions.Notify('Araç Temizlendi!')
        else
            QBCore.Functions.Notify('Yakınlarda Araç Yok')
        end	
	end
end)

RegisterNetEvent('mekaniktamir')
AddEventHandler('mekaniktamir', function()
    if PlayerData.job.name == "police" or string.find(PlayerData.job.name, "mechanic") then
        local playerPed = PlayerPedId()
        local coords = GetEntityCoords(playerPed)
        local vehicle, mesafe = QBCore.Functions.GetClosestVehicle(coords)
        local inVehicle = IsPedInAnyVehicle(playerPed, false)
		local inVhicleId = 0
		local vehicle, mesafe = 0, 999
		if inVehicle then
			inVhicleId =  GetVehiclePedIsIn(playerPed, false)
		else
			vehicle, mesafe = QBCore.Functions.GetClosestVehicle(coords)
		end
		if inVehicle then
			QBCore.Functions.Notify("Araç İçinden Motoru Tamir Edemezsin")
			return
		end

		local kaput = GetEntityBoneIndexByName(vehicle, 'engine')
		local kaputkordinat = GetWorldPositionOfEntityBone(vehicle, kaput)
		
		if #(coords - kaputkordinat) <= 2.3 then
			if DoesEntityExist(vehicle) then

				local time = 40000
				for i=1, #mechanicLocation do
					if #(GetEntityCoords(playerPed) - vector3(mechanicLocation[i].x, mechanicLocation[i].y, mechanicLocation[i].z)) < 150 then
						time = 10000
						break
					end
				end
				
				SetVehicleDoorOpen(vehicle, 4, 0, 0)
				TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_BUM_BIN", 0, true)
				QBCore.Functions.Progressbar("vehicle_repair", "Araç Tamir Ediliyor", time, false, true, { -- p1: menu name, p2: yazı, p3: ölü iken kullan, p4:iptal edilebilir
					disableMovement = true,
					disableCarMovement = true,
					disableMouse = false,
					disableCombat = true,
				}, {}, {}, {}, function() -- Done
					SetVehicleFixed(vehicle)
					SetVehicleDeformationFixed(vehicle)
					SetVehicleUndriveable(vehicle, false)
					ClearPedTasksImmediately(playerPed)
					QBCore.Functions.Notify("Tamir Tamamlandı")
					SetVehicleDoorShut(vehicle, 4, 0)
					IsBusy = false
				end, function() -- Cancel
					IsBusy = false
				end)
			
			end
		else
			QBCore.Functions.Notify("Tamir İçin Motara Yakın Olman Lazım")
		end
	end
end)

RegisterNetEvent('mekanikkriko')
AddEventHandler('mekanikkriko', function()
    if PlayerData.job.name == "police" or string.find(PlayerData.job.name, "mechanic") then
        local playerPed = PlayerPedId()
        local coords = GetEntityCoords(playerPed)
        local vehicle, mesafe = QBCore.Functions.GetClosestVehicle(coords)
        local inVehicle = IsPedInAnyVehicle(playerPed, false)
		local inVhicleId = 0
		local vehicle, mesafe = 0, 999
		if inVehicle then
			inVhicleId =  GetVehiclePedIsIn(playerPed, false)
		else
			vehicle, mesafe = QBCore.Functions.GetClosestVehicle(coords)
		end
		if inVehicle then
			QBCore.Functions.Notify("Araç İçinden Aracı Tamir Edemezsin")
			return
		end

		local veh = QBCore.Functions.GetVehicleInDirection()
		if veh == nil then QBCore.Functions.Notify("Önünde Araç Yok!", "error") return end
		IsBusy = true

		local time = 74000
		for i=1, #mechanicLocation do
			if #(GetEntityCoords(playerPed) - vector3(mechanicLocation[i].x, mechanicLocation[i].y, mechanicLocation[i].z)) < 150 then
				time = 11000
				break
			end
		end
		
		SetEntityAsMissionEntity(veh, true, true)
		FreezeEntityPosition(veh, true)
		TaskTurnPedToFaceEntity(playerPed, veh, 1000)
		Citizen.Wait(1200)

		local offset = GetOffsetFromEntityInWorldCoords(playerPed, 0.0, -2.0, 0.0)
		local headin = GetEntityHeading(playerPed)
		local vehpos = GetEntityCoords(veh)
		local dict = 'mp_car_bomb'
		local model = 'prop_carjack'

		RequestAnimDict(dict)
		while not HasAnimDictLoaded(dict) or not HasModelLoaded(model) do
			RequestModel(model)
			Citizen.Wait(1)
		end
		
		local vehjack = CreateObject(GetHashKey(model), vehpos.x, vehpos.y, vehpos.z - 0.5, true, true, true)
		asycProgressbar(9250, "Araç Yükseltiliyor") -- TRANSLATE THIS, THAT SAY WHEN YOU PUT THE CRIC

		AttachEntityToEntity(vehjack, veh, 0, 0.0, 0.0, -1.0, 0.0, 0.0, 0.0, false, false, false, false, 0, true)
		TaskPlayAnimAdvanced(playerPed, dict, 'car_bomb_mechanic', coords, 0.0, 0.0, headin, 1.0, 0.5, 1250, 1, 0.0, 1, 1)
		Citizen.Wait(1250)
		SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.01, true, true, true)
		TaskPlayAnimAdvanced(playerPed, dict, 'car_bomb_mechanic', coords, 0.0, 0.0, headin, 1.0, 0.5, 1000, 1, 0.25, 1, 1)
		Citizen.Wait(1000)
		SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.025, true, true, true)
		TaskPlayAnimAdvanced(playerPed, dict, 'car_bomb_mechanic', coords, 0.0, 0.0, headin, 1.0, 0.5, 1000, 1, 0.25, 1, 1)
		Citizen.Wait(1000)
		SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.05, true, true, true)
		TaskPlayAnimAdvanced(playerPed, dict, 'car_bomb_mechanic', coords, 0.0, 0.0, headin, 1.0, 0.5, 1000, 1, 0.25, 1, 1)
		Citizen.Wait(1000)
		SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.1, true, true, true)
		TaskPlayAnimAdvanced(playerPed, dict, 'car_bomb_mechanic', coords, 0.0, 0.0, headin, 1.0, 0.5, 1000, 1, 0.25, 1, 1)
		Citizen.Wait(1000)
		SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.15, true, true, true)
		TaskPlayAnimAdvanced(playerPed, dict, 'car_bomb_mechanic', coords, 0.0, 0.0, headin, 1.0, 0.5, 1000, 1, 0.25, 1, 1)
		Citizen.Wait(1000)
		SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.2, true, true, true)
		TaskPlayAnimAdvanced(playerPed, dict, 'car_bomb_mechanic', coords, 0.0, 0.0, headin, 1.0, 0.5, 1000, 1, 0.25, 1, 1)
		Citizen.Wait(1000)
		SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.3, true, true, true)
		TaskPlayAnimAdvanced(playerPed, dict, 'car_bomb_mechanic', coords, 0.0, 0.0, headin, 1.0, 0.5, 1000, 1, 0.25, 1, 1)
		local dict = 'move_crawl'
		Citizen.Wait(1000)
		SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.4, true, true, true)
		TaskPlayAnimAdvanced(playerPed, dict, 'car_bomb_mechanic', coords, 0.0, 0.0, headin, 1.0, 0.5, 1000, 1, 0.25, 1, 1)
		SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.5, true, true, true)
		SetEntityCollision(veh, false, false)
		TaskPedSlideToCoord(playerPed, offset, headin, 1000)
		Citizen.Wait(1500)
		while not HasAnimDictLoaded(dict) do
			RequestAnimDict(dict)
			Citizen.Wait(100)
		end
		asycProgressbar(time, "Araç Tamir Ediliyor") -- TRANSLATE THIS - THAT SAY WHEN YOU REPAIR THE VEHICLE
		TaskPlayAnimAdvanced(playerPed, dict, 'onback_bwd', coords, 0.0, 0.0, headin - 180, 1.0, 0.5, 3000, 1, 0.0, 1, 1)
		local dict = 'amb@world_human_vehicle_mechanic@male@base'
		Citizen.Wait(3000)
		RequestAnimDict(dict)
		while not HasAnimDictLoaded(dict) do
			Citizen.Wait(1)
		end
		TaskPlayAnim(playerPed, dict, 'base', 8.0, -8.0, time, 1, 0, false, false, false)
		dict = 'move_crawl'
		Citizen.Wait(time)
		local coords2 = GetEntityCoords(playerPed)
		RequestAnimDict(dict)
		while not HasAnimDictLoaded(dict) do
			Citizen.Wait(1)
		end
		TaskPlayAnimAdvanced(playerPed, dict, 'onback_fwd', coords2, 0.0, 0.0, headin - 180, 1.0, 0.5, 2000, 1, 0.0, 1, 1)
		Citizen.Wait(3000)
		local dict = 'mp_car_bomb'
		RequestAnimDict(dict)
		while not HasAnimDictLoaded(dict) do
			Citizen.Wait(1)
		end
		SetVehicleFixed(veh)
		SetVehicleDeformationFixed(veh)
		SetVehicleUndriveable(veh, false)
		SetVehicleEngineOn(veh, true, true)
		ClearPedTasksImmediately(playerPed)
		Citizen.Wait(500)
		asycProgressbar(8250, "Araç İndiriliyor") -- TLANSTALE THIS - THAT SAY WHEN YOU LEAVE THE CRIC
		TaskPlayAnimAdvanced(playerPed, dict, 'car_bomb_mechanic', coords, 0.0, 0.0, headin, 1.0, 0.5, 1250, 1, 0.0, 1, 1)
		Citizen.Wait(1250)
		SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.4, true, true, true)
		TaskPlayAnimAdvanced(playerPed, dict, 'car_bomb_mechanic', coords, 0.0, 0.0, headin, 1.0, 0.5, 1000, 1, 0.25, 1, 1)
		Citizen.Wait(1000)
		SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.3, true, true, true)
		TaskPlayAnimAdvanced(playerPed, dict, 'car_bomb_mechanic', coords, 0.0, 0.0, headin, 1.0, 0.5, 1000, 1, 0.25, 1, 1)
		Citizen.Wait(1000)
		SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.2, true, true, true)
		TaskPlayAnimAdvanced(playerPed, dict, 'car_bomb_mechanic', coords, 0.0, 0.0, headin, 1.0, 0.5, 1000, 1, 0.25, 1, 1)
		Citizen.Wait(1000)
		SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.15, true, true, true)
		TaskPlayAnimAdvanced(playerPed, dict, 'car_bomb_mechanic', coords, 0.0, 0.0, headin, 1.0, 0.5, 1000, 1, 0.25, 1, 1)
		Citizen.Wait(1000)
		SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.1, true, true, true)
		TaskPlayAnimAdvanced(playerPed, dict, 'car_bomb_mechanic', coords, 0.0, 0.0, headin, 1.0, 0.5, 1000, 1, 0.25, 1, 1)
		Citizen.Wait(1000)
		SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.05, true, true, true)
		TaskPlayAnimAdvanced(playerPed, dict, 'car_bomb_mechanic', coords, 0.0, 0.0, headin, 1.0, 0.5, 1000, 1, 0.25, 1, 1)
		Citizen.Wait(1000)
		SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.025, true, true, true)
		TaskPlayAnimAdvanced(playerPed, dict, 'car_bomb_mechanic', coords, 0.0, 0.0, headin, 1.0, 0.5, 1000, 1, 0.25, 1, 1)
		local dict = 'move_crawl'
		Citizen.Wait(1000)
		SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.01, true, true, true)
		TaskPlayAnimAdvanced(playerPed, dict, 'car_bomb_mechanic', coords, 0.0, 0.0, headin, 1.0, 0.5, 1000, 1, 0.25, 1, 1)
		SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z, true, true, true)
		FreezeEntityPosition(veh, false)
		DeleteObject(vehjack)
		SetEntityCollision(veh, true, true)
		IsBusy = false
	end
end)

function asycProgressbar(time, text)
    Citizen.CreateThread(function()
        QBCore.Functions.Progressbar("ozel_name", text, time, false, false, { -- p1: menu name, p2: yazı, p3: ölü iken kullan, p4:iptal edilebilir
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {}, {}, {}, function() -- Done
        end, function() -- Cancel
        end)
    end)
end

RegisterNetEvent('haso:arac-cek')
AddEventHandler('haso:arac-cek', function()
    if PlayerData.job.name == "police" or string.find(PlayerData.job.name, "mechanic") then
        local playerPed = PlayerPedId()
        local coords = GetEntityCoords(playerPed)
        local vehicle, mesafe = QBCore.Functions.GetClosestVehicle(coords)
        if mesafe < 8 then
            if not inVehicle then
                if DoesEntityExist(vehicle) then
                    deleteVeh(vehicle)
                    Citizen.Wait(3000)
					local properties = QBCore.Functions.GetVehicleProperties(vehicle)
            		local plate = properties["plate"]
					TriggerServerEvent("haso_aracgg", plate, properties)
                    if PlayerData.job.name == "police" then
                        local para = exports["elixir-base"]:itemPrice('PolisAracCek')
                        QBCore.Functions.Notify("You pulled a vehicle and for " .. para .. " $")
                        TriggerServerEvent("menu:TgiannParaVer", para, QBCore.Key)
                    end
                end
            end
        end
    else
        QBCore.Functions.Notify("You are not a police")
    end
end)

Config.Polis = {
    label = "Police Craftsmanship",
    slots = 40,
    items = {
        {
            name = "flashlight",
            amount = 1,
            type = "item",
            slot = 1,
			price = 5,
        },
        {
            name = "clip",
            amount = 1,
            type = "item",
            slot = 2,
			price = 5,
        },
        {
            name = "grip",
            amount = 1,
            type = "item",
            slot = 3,
			price = 5,
        },
        {
            name = "scope",
            amount = 1,
            type = "item",
            slot = 4,
			price = 5,
        },
		{
            name = "weapon_nightstick",
            amount = 1,
            type = "weapon",
            slot = 5,
			price = 50,
        },
        {
            name = "weapon_stungun",
            amount = 1,
            type = "weapon",
            slot = 6,
			price = 150,
		},
        {
            name = "weapon_glock",
            amount = 1,
            type = "weapon",
            slot = 7,
			price = 250,
        },
        {
            name = "polis_karti",
            amount = 1,
            type = "item",
            slot = 8,
			price = 5,
        },
		{
            name = "weapon_flashlight",
            amount = 1,
            type = "weapon",
            slot = 9,
			price = 50,
		},
        {
            name = "walkie_lspd",
            amount = 1,
            type = "item",
            slot = 10,
			price = 25,
        },
        {
            name = "gps",
            amount = 1,
            type = "item",
            slot = 11,
			price = 25,
		},
		{
            name = "pistol_ammo",
            amount = 50,
            type = "item",
            slot = 12,
			price = 10,
        },
		{
            name = "taser_ammo",
            amount = 50,
            type = "item",
            slot = 13,
			price = 25,
        },
        {
            name = "pkelepce",
            amount = 5,
            type = "item",
            slot = 14,
			price = 25,
        },
        {
            name = "pkelepceanahtar",
            amount = 1,
            type = "item",
            slot = 15,
			price = 25,
        },
        {
            name = "armor",
            amount = 50,
            type = "item",
            slot = 16,
			price = 50,
        },
        {
            name = "parasut",
            amount = 1,
			price = 1,
            type = "item",
            slot = 17,
			price = 25,
        },
		{
            name = "bandage",
            amount = 10,
			price = 1,
            type = "item",
            slot = 18,
			price = 15,
        },
		{
            name = "medikit",
            amount = 10,
			price = 1,
            type = "item",
            slot = 19,
			price = 55,
        },
		{
            name = "tamirkiti",
            amount = 1,
			price = 1,
            type = "item",
            slot = 20,
			price = 50,
        },
		{
            name = "ifak",
            amount = 50,
			price = 1,
            type = "item",
            slot = 21,
			price = 50,
        },
		{
            name = "camera",
            amount = 1,
			price = 10,
            type = "item",
            slot = 22,
        },
		{
            name = "spikestrip",
            amount = 1,
			price = 50,
            type = "item",
            slot = 23,
        },	
		{
            name = "drone_flyer_7",
            amount = 1,
			price = 1000,
            type = "item",
            slot = 24,
        },	
		{
			name = "bodycam",
			amount = 1,
			price = 100,
			type = "item",
			slot = 25,
		},	
		{
			name = "dashcam",
			amount = 1,
			price = 100,
			type = "item",
			slot = 26,
		},	
    }
}

Config.PolisRutbeli = {
    label = "Certified Weapons",
    slots = 40,
    items = {
        {
			name = "weapon_combatpdw",
			amount = 1,
			type = "weapon",
			slot = 1,
			price = 1000,
		},
		{
			name = "weapon_specialcarbine_mk2",
			amount = 1,
			type = "weapon",
			slot = 2,
			price = 2500,
		},
		{
			name = "weapon_carbinerifle",
			amount = 1,
			type = "weapon",
			slot = 3,
			price = 2500,
		},
		{
			name = "weapon_m14",
			amount = 1,
			type = "weapon",
			slot = 4,
			price = 10000,
		},
		{
			name = "smg_ammo",
			amount = 1,
			type = "item",
			slot = 5,
			price = 100,
		},
		{
			name = "rifle_ammo",
			amount = 1,
			type = "item",
			slot = 6,
			price = 200,
		},
    }
}

Config.Ems = {
	label = "EMS equipment cabinet",
	slots = 30,
	items = {
		  {
				name = "weapon_flashlight",
				amount = 1,
				type = "weapon",
				price = 20,
				slot = 1,
		  },
		  {
				name = "WEAPON_STUNGUN",
				amount = 1,
				type = "weapon",
				price = 20,
				slot = 2,
		  },
		  {
				name = "bandage",
				amount = 10,
				type = "item",
				price = 20,
				slot = 3,
		  },
		  {
				name = "walkie_lspd",
				amount = 1,
				type = "item",
				price = 20,
				slot = 4,
		  },
		  {
				name = "medikit",
				amount = 1,
				type = "item",
				price = 20,
				slot = 5,
		  },
		  {
				name = "pk",
				amount = 1,
				type = "item",
				price = 20,
				slot = 6,
		  },
		  {
				name = "ab", 
				amount = 1,
				type = "item",
				price = 20,
				slot = 7,
		  },
		  {
				name = "gps",
				amount = 1,
				type = "item",
				price = 20,
				slot = 8,
		  },
		  {
				name = "su_alti",
				amount = 1,
				type = "item",
				price = 20,
				slot = 9,
		  },
	}
}

RegisterNetEvent('mekanislemleri')
AddEventHandler('mekanislemleri', function()
	options = {
		{
            type = "client",
            event = "LegacyFuel:blipAcKapa",
            icon = "fas fa-gas-pump",
            label = "Open / off the gas station blips",
        },
		{
            type = "client",
            event = "market:blipAcKapa",
            icon = "fas fa-shopping-basket",
            label = "Open the Market Blips / Cover",
        },
		{
			type = "client",
            event = "esx_barbershop:blipAcKapa",
            icon = "fas fa-hand-scissors",
            label = "Open the Barber Blips / Shut",
        },
		{
			type = "client",
            event = "tattoo:blipAcKapa",
            icon = "fas fa-smog",
            label = "Open / Off the Tattooist Blips",
        },
		{
			type = "client",
            event = "esx_eden_clotheshop:blipAcKapa",
            icon = "fas fa-tshirt",
            label = "Open the clothes blips / off",
        },
		{
			type = "client",
			event = "new_banking:blipAcKapa",
			icon = "fas fa-university",
			label = "Open your bank blips / off"
		},
		{
            type = "client",
            event = "meslekler",
            icon = "fas fa-audio-description",
            label = "Open / Off Vocational Blips",
        },
		{
            type = "client",
            event = "tgiann-garaj:blipAcKapa",
            icon = "fas fa-car-alt",
            label = "Open Garage Blips / Shut",
        },
	},
	SetCursorLocation(0.5, 0.5)
	SetNuiFocus(true, true)
	SetNuiFocusKeepInput(true)
	hasFocus = true
	SendNUIMessage({response = "validTarget", data = options})
	sendData = options
end)

RegisterNetEvent("meslekler", function()
	TriggerEvent("kfzeu-meat-farm:blipAcKapa")
	TriggerEvent("kfzeu-meat-farm:blipAcKapa2")
end)





RegisterNetEvent("mekanlar:ackapa")
AddEventHandler("mekanlar:ackapa", function()
	if mekanlaraq == false then
		mekanlaraq = true
		QBCore.Functions.Notify('Venue Blips Opened', "success")
	else
		mekanlaraq = false
		QBCore.Functions.Notify('Venue Blips Closed', "error")
	end
	TriggerEvent("esx-kr-advanced-shops:blipAcKapa")
	TriggerEvent("new_banking:blipAcKapa")
	TriggerEvent("esx_weaponshop:blipAcKapa")
	TriggerEvent("LegacyFuel:blipAcKapa")
	TriggerEvent("esx_barbershop:blipAcKapa")
	TriggerEvent("tattoo:blipAcKapa")
	TriggerEvent("esx_eden_clotheshop:blipAcKapa")
	TriggerEvent("meslekler")
	TriggerEvent("tgiann-garaj:blipAcKapa")
end)

local banks = {
	{name="Bank", id=108, x=150.266, y=-1040.203, z=29.374},
	{name="Bank", id=108, x=-1212.980, y=-330.841, z=37.787},
	{name="Bank", id=108, x=-2962.582, y=482.627, z=15.703},
	{name="Bank", id=108, x=-112.202, y=6469.295, z=31.626},
	{name="Bank", id=108, x=314.187, y=-278.621, z=54.170},
	{name="Bank", id=108, x=-351.534, y=-49.529, z=49.042},
	
}

local blip = false
local aktifblipler = {}
RegisterNetEvent("new_banking:blipAcKapa")
AddEventHandler("new_banking:blipAcKapa", function()
	if blip then
		pasifblip()
		blip = false
		QBCore.Functions.Notify("BANK BLIPS CLOSED")
	else
		aktifblip()
		QBCore.Functions.Notify("Bank Blips Opened", "success")
		blip = true
	end
end)

function aktifblip()
	for k,v in ipairs(banks)do
		local blip = AddBlipForCoord(v.x, v.y, v.z)
		SetBlipSprite(blip, v.id)
		SetBlipDisplay(blip, 4)
		SetBlipScale  (blip, 0.5)
		SetBlipColour (blip, 2)
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Banka")
		EndTextCommandSetBlipName(blip)
		table.insert(aktifblipler, blip)
	end	
end
  
function pasifblip()
	for i = 1, #aktifblipler do
		RemoveBlip(aktifblipler[i])
	end
	aktifblipler = {}
end

function GetTheStreet()
    local ZoneNames = exports["jtDispatch"]:bolgeler()
    local x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
    local currentStreetHash, intersectStreetHash = GetStreetNameAtCoord(x, y, z, currentStreetHash, intersectStreetHash)
    currentStreetName = GetStreetNameFromHashKey(currentStreetHash)
    intersectStreetName = GetStreetNameFromHashKey(intersectStreetHash)
    zone = tostring(GetNameOfZone(x, y, z))
    playerStreetsLocation = ZoneNames[tostring(zone)]

    if not zone then
        zone = "UNKNOWN"
        ZoneNames['UNKNOWN'] = zone
    elseif not ZoneNames[tostring(zone)] then
        local undefinedZone = zone .. " " .. x .. " " .. y .. " " .. z
        ZoneNames[tostring(zone)] = "Unknown area"
    end

    if (intersectStreetName ~= nil and intersectStreetName ~= "") or (currentStreetName ~= nil and currentStreetName ~= "") then
        playerStreetsLocation = currentStreetName
    else
        playerStreetsLocation = ZoneNames[tostring(zone)]
    end

    return playerStreetsLocation
end

function GetStreetAndZone()
    local playerPed = PlayerPedId()
    local coords = GetEntityCoords(playerPed)
    local currentStreetHash, intersectStreetHash = GetStreetNameAtCoord(coords.x, coords.y, coords.z)
    local currentStreetName = GetStreetNameFromHashKey(currentStreetHash)
    local area = GetLabelText(tostring(GetNameOfZone(coords.x, coords.y, coords.z)))
    local playerStreetsLocation = area
    if not zone then zone = "UNKNOWN" end
    if currentStreetName ~= nil and currentStreetName ~= "" then playerStreetsLocation = currentStreetName .. ", " ..area
    else playerStreetsLocation = area end
    return playerStreetsLocation
end

function polisBildirim()  
    local ped = PlayerPedId()
    local playerPos = GetEntityCoords(ped)
	local id = math.random(1, 9999)
    
    data = {
        id = id,
        code = 10-78,
        description = "Wounded citizen.",
        location = GetTheStreet(),
        coords = playerPos,
        sprite = 274
    }   
    TriggerServerEvent("jtDispatch:add-notification", data, "police")
end

function emsbildirim()  
    local ped = PlayerPedId()
    local playerPos = GetEntityCoords(ped)
	local id = math.random(1, 9999)
    
    data = {
        id = id,
        code = 10-78,
        description = "Wounded citizen.",
        location = GetTheStreet(),
        coords = playerPos,
        sprite = 274
    }   
    TriggerServerEvent("jtDispatch:add-notification", data, "ambulance")
end

local emsBildirimCd = false
local pdBildirimCd = false

RegisterNetEvent('polisyarali')
AddEventHandler('polisyarali', function()
	if not pdBildirimCd then
		QBCore.Functions.TriggerCallback('elixir-base:item-kontrol', function(qtty)
			if qtty > 0 then
				-- TriggerEvent("Tgiann-PolisBildirim:BildirimGonder", "Yaralı Vatandaş", false)
				polisBildirim()
				pdBildirimCd = true
				Citizen.Wait(180000) -- 5 dakika
				pdBildirimCd = false
		 	else
		 		QBCore.Functions.Notify('You cant send GPS location because you dont have a phone on it')
		 	end
		 end, "white_phone")
	 else
	 	QBCore.Functions.Notify('You can send a notification 3 every minute')
	 end
end)

RegisterNetEvent('emsbildirimgonder')
AddEventHandler('emsbildirimgonder', function()
	if not emsBildirimCd then
		QBCore.Functions.TriggerCallback('elixir-base:item-kontrol', function(qtty)
			if qtty > 0 then
				QBCore.Functions.TriggerCallback('elixir-base:ems-sayi', function(AktifEMS)
					emsbildirim() 
					QBCore.Functions.Notify('Notification has been sent to active units! Active EMS Number: '.. AktifEMS)
					emsBildirimCd = true
					Citizen.Wait(85000) -- 5 dakika
					emsBildirimCd = false
				end)
			else
				QBCore.Functions.Notify('You cant send GPS location because you dont have a phone on it')
			end
		end, "white_phone")
	else
		QBCore.Functions.Notify('You can send a notification every 1.5  minute')
	end
end)

isDead = false

AddEventHandler('tgiann:playerdead', function(dead)
    isDead = dead
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if not hasFocus and targetActive and (IsControlPressed(0, 238) or IsDisabledControlPressed(0, 238)) then
			data = Self
			Functions.OpenSelfMenu(-1, data, 313131, 1)
		end
	end
end)

-- Citizen.CreateThread(function()
-- 	while true do
-- 		Citizen.Wait(0)
-- 		if not hasFocus and targetActive and (IsControlPressed(0,238) or IsDisabledControlPressed(0, 238)) then
-- 			local inVehicle = IsPedInAnyVehicle(PlayerPedId(), false)
-- 			if isDead then
-- 				options = {
-- 					{
-- 						type = "client",
-- 						event = "kiyafetamkcocu",
-- 						icon = "fas fa-tshirt",
-- 						label = "Kıyafetler",
-- 					},
-- 					{
-- 						type = "client",
-- 						event = "polisbildirimgonder",
-- 						icon = "fas fa-id-card",
-- 						label = "Polis Bildirim Gönder",
-- 					},
-- 					{
-- 						type = "client",
-- 						event = "emsbildirimgonder",
-- 						icon = "fas fa-id-card",
-- 						label = "EMS Bildirim Gönder",
-- 					},
-- 				},
-- 				SetCursorLocation(0.5, 0.5)
-- 				SetNuiFocus(true, true)
-- 				SetNuiFocusKeepInput(true)
-- 				hasFocus = true
-- 				sendData = options
-- 				SendNUIMessage({response = "foundTarget"})
-- 				SendNUIMessage({response = "validTarget", data = options})
-- 			else	
-- 				if inVehicle and PlayerData.job.name == 'police' then
-- 					options = {
-- 						{
-- 							type = "client",
-- 							event = "kimlikislemleri",
-- 							icon = "fas fa-id-card",
-- 							label = "Kimlik İşlemleri",
-- 						},
-- 						{
-- 							type = "client",
-- 							event = "kiyafetamkcocu",
-- 							icon = "fas fa-tshirt",
-- 							label = "Kıyafetler",
-- 						},
-- 						{
-- 							type = "client",
-- 							event = "dpemotes:animation-menu",
-- 							icon = "fas fa-play",
-- 							label = "Animasyon",
-- 						},
-- 						{
-- 							type = "client",
-- 							event = "mekanislemleri",
-- 							icon = "fas fa-map-marked-alt",
-- 							label = "Mekan Blipleri Aç / Kapa",
-- 						},
-- 						{
-- 							type = "client",
-- 							event = "tgiann-carcontrol:open",
-- 							icon = "fas fa-wrench",
-- 							label = "Araç Menüsü",
-- 						},
-- 						{
-- 							type = "command",
-- 							event = "pdepo",
-- 							icon = "fas fa-box",
-- 							label = "Özel Araç Envanterini Aç",
-- 						},
-- 					},
-- 					SetCursorLocation(0.5, 0.5)
-- 					SetNuiFocus(true, true)
-- 					SetNuiFocusKeepInput(true)
-- 					hasFocus = true
-- 					sendData = options
-- 					SendNUIMessage({response = "foundTarget"})
-- 					SendNUIMessage({response = "validTarget", data = options})				
-- 				elseif inVehicle then
-- 					options = {
-- 						{
-- 							type = "client",
-- 							event = "kimlikislemleri",
-- 							icon = "fas fa-id-card",
-- 							label = "Kimlik İşlemleri",
-- 						},
-- 						{
-- 							type = "client",
-- 							event = "kiyafetamkcocu",
-- 							icon = "fas fa-tshirt",
-- 							label = "Kıyafetler",
-- 						},
-- 						{
-- 							type = "client",
-- 							event = "dpemotes:animation-menu",
-- 							icon = "fas fa-play",
-- 							label = "Animasyon",
-- 						},
-- 						{
-- 							type = "client",
-- 							event = "mekanislemleri",
-- 							icon = "fas fa-map-marked-alt",
-- 							label = "Mekan Blipleri Aç / Kapa",
-- 						},
-- 						{
-- 							type = "client",
-- 							event = "tgiann-carcontrol:open",
-- 							icon = "fas fa-wrench",
-- 							label = "Araç Menüsü",
-- 						},
-- 					},
-- 					SetCursorLocation(0.5, 0.5)
-- 					SetNuiFocus(true, true)
-- 					SetNuiFocusKeepInput(true)
-- 					hasFocus = true
-- 					sendData = options
-- 					SendNUIMessage({response = "foundTarget"})
-- 					SendNUIMessage({response = "validTarget", data = options})				
-- 				else
-- 					if not isDead and PlayerData.job.name == 'police' or PlayerData.job.name == 'ambulance' then
-- 					options = {
-- 						{
-- 							type = "client",
-- 							event = "kimlikislemleri",
-- 							icon = "fas fa-id-card",
-- 							label = "Kimlik İşlemleri",
-- 						},
-- 						{
-- 							type = "client",
-- 							event = "kiyafetamkcocu",
-- 							icon = "fas fa-tshirt",
-- 							label = "Kıyafetler",
-- 						},
-- 						{
-- 							type = "client",
-- 							event = "dpemotes:animation-menu",
-- 							icon = "fas fa-play",
-- 							label = "Animasyon",
-- 						},
-- 						{
-- 							type = "command",
-- 							event = "yenile",
-- 							icon = "fas fa-exchange-alt",
-- 							label = "Karakteri Yenile",
-- 						},
-- 						{
-- 							type = "client",
-- 							event = "mekanislemleri",
-- 							icon = "fas fa-map-marked-alt",
-- 							label = "Mekan Blipleri Aç / Kapa",
-- 						},
-- 						{
-- 							type = "client",
-- 							event = "meslekislemleri",
-- 							icon = "fas fa-map-marker",
-- 							label = "Meslek İşlemleri",
-- 						},
-- 					},
-- 					SetCursorLocation(0.5, 0.5)
-- 					SetNuiFocus(true, true)
-- 					SetNuiFocusKeepInput(true)
-- 					hasFocus = true
-- 					sendData = options
-- 					SendNUIMessage({response = "foundTarget"})
-- 					SendNUIMessage({response = "validTarget", data = options})				
-- 					elseif not isDead then
-- 						options = {
-- 							{
-- 								type = "client",
-- 								event = "kimlikislemleri",
-- 								icon = "fas fa-id-card",
-- 								label = "Kimlik İşlemleri",
-- 							},
-- 							{
-- 								type = "client",
-- 								event = "kiyafetamkcocu",
-- 								icon = "fas fa-tshirt",
-- 								label = "Kıyafetler",
-- 							},
-- 							{
-- 								type = "client",
-- 								event = "dpemotes:animation-menu",
-- 								icon = "fas fa-play",
-- 								label = "Animasyon",
-- 							},
-- 							{
-- 								type = "command",
-- 								event = "yenile",
-- 								icon = "fas fa-exchange-alt",
-- 								label = "Karakteri Yenile",
-- 							},
-- 							{
-- 								type = "client",
-- 								event = "mekanislemleri",
-- 								icon = "fas fa-map-marked-alt",
-- 								label = "Mekan Blipleri Aç / Kapa",
-- 							},
-- 						},
-- 						SetCursorLocation(0.5, 0.5)
-- 						SetNuiFocus(true, true)
-- 						SetNuiFocusKeepInput(true)
-- 						hasFocus = true
-- 						sendData = options
-- 						SendNUIMessage({response = "foundTarget"})
-- 						SendNUIMessage({response = "validTarget", data = options})
-- 					end
-- 				end
-- 			end
-- 		end
-- 	end
-- end)

RegisterNetEvent('oyuncuislemleri')
AddEventHandler('oyuncuislemleri', function()
	options = {
		{
            type = "command",
            event = "nearby bro2",
            icon = "fas fa-hand-paper",
            label = "Shaketing",
        },
		{
		  type = "client",
		  event = "kucakla",
		  icon = "fas fa-people-carry",
		  label = "Lap",
		},
		{
		  type = "client",
		  event = "tasi",
		  icon = "fas fa-people-carry",
		  label = "Move",
		},
		{
		 type = "client",
		 event = "tgiann-kelepce:client:ybindir",
		 icon = "fas fa-sign-out-alt",
		 label = "Download wounded / put",
		},
		{
		 type = "client",
		 event = "tgiann-kelepce:client:tasi",
		 icon = "fas fa-sign-out-alt",
		 label = "Handcuffed / wounded stone",
		},
		{
		 type = "client",
		 event = "tgiann-kelepce:arac",
		 icon = "fas fa-sign-in-alt",
		 label = "Clamped Download / Overload",
		},
		{
			type = "client",
			event = "esx_barbie_lyftupp:TgiannRehinAl",
			icon = "fas fa-hands-helping",
			label = "Take Pledge",
		},
		{
			type = "client",
			event = "x-hotwire:tgiannf3inahtar",
			icon = "fas fa-key",
			label = "Give Key",
		},
		{
			type = "client",
			event = "qb-phone:client:GiveContactDetails",
			icon = "fas fa-phone-square",
			label = "Give Phone Number",
		},
	},
	SetCursorLocation(0.5, 0.5)
	SetNuiFocus(true, true)
	SetNuiFocusKeepInput(true)
	hasFocus = true
	SendNUIMessage({response = "validTarget", data = options})
	sendData = options
end)

RegisterNetEvent('polisislemleri')
AddEventHandler('polisislemleri', function()
	options = {
		{
			type = "client",
			event = "polis:kimlik",
			icon = "far fa-id-badge",
			label = "Show Police ID",
			job = "police"
		},
		{
			type = "client",
			event = "esx_policejob:cezakes",
			icon = "far fa-money-bill-alt",
			label = "Cut a Fine",
			job = "police"
		},
		{
			type = "client",
			event = "polis:kamu",
			icon = "fas fa-broom",
			label = "Cut a Public Penalty",
			job = "police"
		},
		{
			type = "client",
			event = "esx-qalle-jail:hapisat",
			icon = "fas fa-user-lock",
			label = "Cut a Jail",
			job = "police"
		},
		{
			type = "client",
			event = "polis:cezabak",
			icon = "fas fa-money-check",
			label = "Unpaid Fines",
			job = "police"
		},
	},
	SetCursorLocation(0.5, 0.5)
	SetNuiFocus(true, true)
	SetNuiFocusKeepInput(true)
	hasFocus = true
	SendNUIMessage({response = "validTarget", data = options})
	sendData = options
end)

RegisterNetEvent('emsislemleri')
AddEventHandler('emsislemleri', function()
	options = {
		{
			type = "client",
			event = "iyilestiraq",
			icon = "fas fa-briefcase-medical",
			label = "Heal the Injured",
			job = "ambulance"
		},
		{
			type = "client",
			event = "emsFatura:Kes",
			icon = "far fa-money-bill-alt",
			label = "Issue EMS Invoice",
			job = "ambulance"
		},
		{
			type = "client",
			event = "emsigne",
			icon = "fas fa-syringe",
			label = "Dope Injection",
			job = "ambulance"
		},
		{
			type = "client",
			event = "emssandalye",
			icon = "fab fa-accessible-icon",
			label = "Wheelchair",
			job = "ambulance"
		},
	},
	SetCursorLocation(0.5, 0.5)
	SetNuiFocus(true, true)
	SetNuiFocusKeepInput(true)
	hasFocus = true
	SendNUIMessage({response = "validTarget", data = options})
	sendData = options
end)

-- RegisterNetEvent('kiyafetamkcocu')
-- AddEventHandler('kiyafetamkcocu', function()       
--     exports['qb-menu']:openMenu({
-- 		{
--             header = "Kıyafet İşlemleri",
-- 			icon = "fas fa-user-circle",
--             isMenuHeader = true
--         },
--         {
--             header = " Tişört Giy/Çıkar",
-- 			icon = "fas fa-tshirt",
--             -- txt = "" .. PlayerData.charinfo.firstname .. " " .. PlayerData.charinfo.lastname .. " İsimli Kimliğini İncele",
-- 			isServer = false,
--             params = {
--                 event = "tisort",
--             }
--         },
--         {
--             header = "Pantalonunu Giy/Çıkar",
-- 			icon = "fas fa-columns",
--         --    txt = "" .. PlayerData.charinfo.firstname .. " " .. PlayerData.charinfo.lastname .. " İsimli Kimliği Yakınındakine Ver",
-- 			isServer = false,
--             params = {
--                 event = "pantalon",
--             }
--         },
--         {
--             header = "Ayakkabını Giy/Çıkar",
-- 			icon = "fas fa-shoe-prints",
-- 			isServer = false,
--             params = {
-- 				event = "ayakkabi",
--             }
--         },
-- 		{
--             header = "Gözlüğünü Tak/Çıkar",
-- 			icon = "fas fa-glasses",
--           --  txt = "" .. PlayerData.charinfo.firstname .. " " .. PlayerData.charinfo.lastname .. " İsimli Ehliyeti Yakınıdaki Kişiye Ver",
-- 			isServer = false,
--             params = {
-- 				event = "gozluk",
--             }
--         },
-- 		{
--             header = "Maskeni Tak/Çıkar",
-- 			icon = "fas fa-mask",
--           --  txt = "" .. PlayerData.charinfo.firstname .. " " .. PlayerData.charinfo.lastname .. " İsimli Ehliyeti Yakınıdaki Kişiye Ver",
-- 			isServer = false,
--             params = {
-- 				event = "maske",
--             }
--         },
-- 		{
--             header = "Şapkanı Tak/Çıkar",
-- 			icon = "fas fa-graduation-cap",
--           --  txt = "" .. PlayerData.charinfo.firstname .. " " .. PlayerData.charinfo.lastname .. " İsimli Ehliyeti Yakınıdaki Kişiye Ver",
-- 			isServer = false,
--             params = {
-- 				event = "sapka",
--             }
--         },
-- 		{
--             header = "Eldivenlerini Giy/Çıkar",
--           --  txt = "" .. PlayerData.charinfo.firstname .. " " .. PlayerData.charinfo.lastname .. " İsimli Ehliyeti Yakınıdaki Kişiye Ver",
-- 		  	icon = "fas fa-mitten",
-- 			isServer = false,
--             params = {
-- 				event = "eldiven",
--             }
--         },
-- 		{
--             header = "Çantanı Tak/Çıkar",
-- 			icon = "fas fa-briefcase",
--           --  txt = "" .. PlayerData.charinfo.firstname .. " " .. PlayerData.charinfo.lastname .. " İsimli Ehliyeti Yakınıdaki Kişiye Ver",
-- 			isServer = false,
--             params = {
-- 				event = "sapka",
--             }
--         },
-- 		{
--             header = "Zırh Aksesuarını Giy/Çıkar",
-- 			icon = "fas fa-user-shield",
--           --  txt = "" .. PlayerData.charinfo.firstname .. " " .. PlayerData.charinfo.lastname .. " İsimli Ehliyeti Yakınıdaki Kişiye Ver",
-- 			isServer = false,
--             params = {
-- 				event = "zırh",
--             }
--         },
--     })
-- end)




RegisterNetEvent('aracislemlerigenel')
AddEventHandler('aracislemlerigenel', function()
	options = {
		{
			event = "tgiann-kelepce:arac",
			icon = "fas fa-sign-in-alt",
			label = "Clamped Download / Overload"
		},
		{
			event = "tgiann-kelepce:client:ybindir",
			icon = "fas fa-sign-out-alt",
			label = "Injured Download / Overload"
		},
		{
			event = "x-hotwire:tgiannf3inahtar",
			icon = "fas fa-key",
			label = "Give Key"
		},
	},
	SetCursorLocation(0.5, 0.5)
	SetNuiFocus(true, true)
	SetNuiFocusKeepInput(true)
	hasFocus = true
	SendNUIMessage({response = "validTarget", data = options})
	sendData = options
end)

RegisterNetEvent('arackapiislemleri')
AddEventHandler('arackapiislemleri', function()
	options = {
		{
			event = "kapi2:Ac",
			icon = "fas fa-door-open",
			label = "Open/Close Left Front Door"
		},
		{
			event = "kapi1:Ac",
			icon = "fas fa-door-open",
			label = "Open/Close Right Front Door"
		},
		{
			event = "kapi4:Ac",
			icon = "fas fa-door-open",
			label = "Open/Close Left Back Door"
		},
		{
			event = "kapi3:Ac",
			icon = "fas fa-door-open",
			label = "Open/Close Right Back Door"
		},
		{
			event = "bagaj:Ac",
			icon = "fas fa-door-open",
			label = "Open/Close Luggage"
		},
		{
			event = "kaput:Ac",
			icon = "fas fa-door-open",
			label = "Open/Close Hood"
		},
	},
	SetCursorLocation(0.5, 0.5)
	SetNuiFocus(true, true)
	SetNuiFocusKeepInput(true)
	hasFocus = true
	SendNUIMessage({response = "validTarget", data = options})
	sendData = options
end)

RegisterNetEvent('meslekislemleri')
AddEventHandler('meslekislemleri', function()
	options = {
		{
			event = "gpsacamk",
			icon = "fas fa-map-marker",
			label = "GPS On"
		},
		{
			event = "gpskapatamk",
			icon = "fas fa-map-marker-alt",
			label = "GPS Close"
		},
		{
			type = "client",
			event = "tgiann-police:obje-menu-ac",
			icon = "fas fa-exclamation-triangle",
			label = "Object Operations",
		},
	},
	SetCursorLocation(0.5, 0.5)
	SetNuiFocus(true, true)
	SetNuiFocusKeepInput(true)
	hasFocus = true
	SendNUIMessage({response = "validTarget", data = options})
	sendData = options
end)

RegisterNetEvent('gpsacamk')
AddEventHandler('gpsacamk', function()
	TriggerEvent("tgiann-menuv2:gpsac")
end)

RegisterNetEvent('gpskapatamk')
AddEventHandler('gpskapatamk', function()
	TriggerEvent("tgiann-menuv2:gpskapat")
end)

RegisterNetEvent('sapka')
AddEventHandler('sapka', function()
	TriggerEvent("qb-clothing:client:adjustfacewear", 3)
end)

RegisterNetEvent('maske')
AddEventHandler('maske', function()
	TriggerEvent("qb-clothing:client:adjustfacewear", 2)
end)

RegisterNetEvent('eldiven')
AddEventHandler('eldiven', function()
	TriggerEvent("qb-clothing:client:adjustfacewear", 315)
end)

RegisterNetEvent('gozluk')
AddEventHandler('gozluk', function()
	TriggerEvent("qb-clothing:client:adjustfacewear", 4)
end)

RegisterNetEvent('tisort')
AddEventHandler('tisort', function()
	TriggerEvent("qb-clothing:client:adjustfacewear", 5)
end)

RegisterNetEvent('canta')
AddEventHandler('canta', function()
	TriggerEvent("qb-clothing:client:adjustfacewear", 6)
end)

RegisterNetEvent('pantalon')
AddEventHandler('pantalon', function()
	TriggerEvent("qb-clothing:client:adjustfacewear", 7)
end)

RegisterNetEvent('ayakkabi')
AddEventHandler('ayakkabi', function()
	TriggerEvent("qb-clothing:client:adjustfacewear", 8)
end)

local copKaristirCD = false
RegisterNetEvent('copkaristir')
AddEventHandler('copkaristir', function()
    if not copKaristirCD then
        copKaristirCD = true
        QBCore.Functions.Progressbar("cop_kariştir", "You're Mixing the Trash", 10000, false, true, { -- p1: menu name, p2: yazı, p3: ölü iken kullan, p4:iptal edilebilir
            disableMovement = false,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        }, {
            animDict = "amb@prop_human_bum_bin@base",
            anim = "base",
            flags = 33,
        }, {}, {}, function() -- Done
            TriggerServerEvent("tgiann-menu:cop-esyasi-ver")
			Citizen.Wait(60000)
			copKaristirCD = false
        end, function() -- Cancel
        end)
    else
        QBCore.Functions.Notify('You Can Mix Up a Trash in 1 Minute!')
    end
end)

local function AllowRefuel(state, electric) 
    if state then
		if electric then
			AllowElectricRefuel = true
		else
        	Allowrefuel = true
		end
    else
		if electric then
			AllowElectricRefuel = false
		else
			Allowrefuel = false
		end
    end
end exports('AllowRefuel', AllowRefuel)

local hashBin = {
    1437508529,
    -819563011,
    -289082718,
    1437508529,
    1614656839,
    -289082718,
    1437508529,
    1614656839,
    -130812911,
    -93819890,
    1329570871,
    1143474856,
    -228596739,
    -468629664,
    -1426008804,
    -1187286639,
    -1096777189,
    -413198204,
    437765445,
    122303831,
    1748268526,
    998415499,
    234941195,
    -2096124444,
    1792999139,
    -341442425,
    -329415894,
    -1830793175,
    -654874323,
    1010534896,
    651101403,
    909943734,
    1919238784,
    274859350,
    751349707,
    1627301588,
    1388415578,
    1813879595,
    1098827230,
    1388308576,
    600967813,
    1948359883,
    -1681329307,
    -96647174,
    811169045,
    -14708062,
    354692929,
    673826957,
    375956747,
    1233216915,
    -85604259,
    -115771139,
    -1998455445,
    577432224,
    684586828,
    218085040,
    666561306,
    -58485588,
    -206690185,
    1511880420,
    682791951,
    -1587184881
}


AddEventHandler('copbak', function()
    local nearGarbage = checkNearGarbage()
    if nearGarbage then
        local id = ObjToNet(nearGarbage)
        TriggerEvent("inventory:client:SetCurrentStash", "trash_"..id, QBCore.Key)
        TriggerServerEvent("inventory:server:OpenInventory", "stash", "trash_"..id, {maxweight = 20000,slots = 5})
    end
end)

function checkNearGarbage()
    local found = false
    local Ped = PlayerPedId()
    local Entity, Dist = QBCore.Functions.GetClosestObject()
    if Dist < 2 then
        for i=1, #hashBin do
            if GetEntityModel(Entity) == hashBin[i] then
                found = Entity
                break
            end
        end
    end
    return found
end


RegisterNetEvent('otur:event')
AddEventHandler('otur:event', function()	
	exports["ChairBedSystem"]:yatakVarmi()
    TriggerEvent("ChairBedSystem:Client:yatak-yatir", false, false)
end)


Config.kahve = {
    label = "Vending",
    slots = 40,
    items = {
        {
            name = "kahve",
            amount = 5,
			price = 20,
            type = "item",
            slot = 1,
        },
    }
}

Config.otomat = {
    label = "Vending",
    slots = 40,
    items = {
        {
            name = "kola",
            amount = 5,
			price = 20,
            type = "item",
            slot = 1,
        },
		{
            name = "enerji_icecegi",
            amount = 5,
			price = 20,
            type = "item",
            slot = 2,
        },
    }
}

Config.otomat2 = {
    label = "Vending",
    slots = 40,
    items = {
        {
            name = "kekuzum",
            amount = 5,
			price = 20,
            type = "item",
            slot = 1,
        },
		{
            name = "pogacadomates",
            amount = 5,
			price = 20,
            type = "item",
            slot = 2,
        },
		{
            name = "pogacapatates",
            amount = 5,
			price = 20,
            type = "item",
            slot = 3,
        },
    }
}

RegisterNetEvent("kahvealoc")
AddEventHandler("kahvealoc", function()
    TriggerServerEvent("inventory:server:OpenInventory", "shop", "police", Config.kahve)
end)

RegisterNetEvent("otomatac")
AddEventHandler("otomatac", function()
    TriggerServerEvent("inventory:server:OpenInventory", "shop", "police", Config.otomat)
end)

RegisterNetEvent("otomatac2")
AddEventHandler("otomatac2", function()
    TriggerServerEvent("inventory:server:OpenInventory", "shop", "police", Config.otomat2)
end)

RegisterNetEvent('sebilsu')
AddEventHandler('sebilsu', function()
	QBCore.Functions.Progressbar("sebil_su", "You're Drinking Water", 10000, false, true, { -- p1: menu name, p2: yazı, p3: ölü iken kullan, p4:iptal edilebilir
            disableMovement = false,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        }, {
            animDict = "amb@prop_human_bum_bin@base",
            anim = "base",
            flags = 33,
        }, {}, {}, function() -- Done
            --TriggerEvent('sebildensus:status')
			TriggerServerEvent("QBCore:Server:SetMetaData", "thirst", QBCore.Functions.GetPlayerData().metadata["thirst"] + 10)
        end, function() -- Cancel
			QBCore.Functions.Notify("It is cancelled!", "error")
        end)
end)

Citizen.CreateThread(function()
    local coffee = {
        690372739,
    }
    Functions.AddTargetModel(coffee, {
        options = {
            {
                event = "kahvealoc",
                icon = "fas fa-coffee",
                label = "Coffee Vending Machine",
            },
        },
        distance = 2.5
    })

	local otomat = {
        1114264700,
        992069095,
    }
    Functions.AddTargetModel(otomat, {
        options = {
            {
                event = "otomatac",
                icon = "fas fa-shopping-basket",
                label = "Vending Machine",
            },
        },
        distance = 2.5
    })

    local otomat2 = {
        -654402915,
    }
    Functions.AddTargetModel(otomat2, {
        options = {
            {
                event = "otomatac2",
                icon = "fas fa-shopping-basket",
                label = "Vending Machine",
            },
        },
        distance = 2.5
    })

	local sebil = {
        -742198632,
    }
    Functions.AddTargetModel(sebil, {
        options = {
            {
                event = "sebilsu",
                icon = "fas fa-tint",
                label = "Dispenser",
            },
        },
        distance = 2.5
    })
end)

function GetNearestVehicle()
    local playerPed = GetPlayerPed(-1)
    local playerCoords = GetEntityCoords(playerPed)
    if not (playerCoords and playerPed) then
        return
    end

    local pointB = GetEntityForwardVector(playerPed) * 0.001 + playerCoords

    local shapeTest = StartShapeTestCapsule(playerCoords.x, playerCoords.y, playerCoords.z, pointB.x, pointB.y, pointB.z, 1.0, 10, playerPed, 7)
    local _, hit, _, _, entity = GetShapeTestResult(shapeTest)

    return (hit == 1 and IsEntityAVehicle(entity)) and entity or false
end



RegisterNetEvent("market:ac")
AddEventHandler("market:ac", function()
    TriggerServerEvent("inventory:server:OpenInventory", "shop", "market", Config.market)
end)

Config.market = {
    label = "Market",
    slots = 40,
    items = {
        {
            name = "kraker",
            amount = 100,
            type = "item",
            slot = 1,
        },
        {
            name = "water",
            amount = 100,
            type = "item",
            slot = 2,
        },
		{
            name = "cigarette",
            amount = 100,
            type = "item",
            slot = 3,
        },
		{
            name = "lighter",
            amount = 100,
            type = "item",
			price = 5,
            slot = 4,
        },
    }
}

Citizen.CreateThread(function()
	AddBoxZone("bankapark", vector3(149.1780, -1041.0, 29.374), 0.5, 6.0, {
        name="bankapark",
        heading=158.0,
        debugPoly=false,
        minZ=28.541,
        maxZ=30.941
    }, {
        options = {
            {
				type = "client",
                type = "client",
				event = "bankanim",
                icon = "far fa-credit-card",
                label = "Bank",
                jobs = {"all"},
            },
        },
        distance = 2
    })
    AddBoxZone("bankamotel", vector3(313.4426, -279.5, 54.170), 0.5, 6.0, {
        name="bankamotel",
        heading=160.0,
        debugPoly=false,
        minZ=52.541,
        maxZ=55.941
    }, {
        options = {
            {
                type = "client",
				event = "bankanim",
                icon = "far fa-credit-card",
                label = "Bank",
                jobs = {"all"},
            },
        },
        distance = 2
    })
    AddBoxZone("bankamekanik", vector3(-351.533, -50.2, 49.036), 0.5, 6.0, {
        name="bankamekanik",
        heading=160.0,
        debugPoly=false,
        minZ=48.2,
        maxZ=51.2
    }, {
        options = {
            {
                type = "client",
				event = "bankanim",
                icon = "far fa-credit-card",
                label = "Bank",
                jobs = {"all"},
            },
        },
        distance = 2
    })
    AddBoxZone("bankahayes", vector3(-1213.32, -331.6, 37.787), 0.5, 6.0, {
        name="bankahayes",
        heading=207.0,
        debugPoly=false,
        minZ=37.0,
        maxZ=39.5
    }, {
        options = {
            {
                type = "client",
				event = "bankanim",
                icon = "far fa-credit-card",
                label = "Bank",
                jobs = {"all"},
            },
        },
        distance = 2
    })
    AddBoxZone("bankaharmony", vector3(1175.722, 2707.4, 38.094), 0.5, 6.0, {
        name="bankaharmony0",
        heading=0.0,
        debugPoly=false,
        minZ=37.0,
        maxZ=39.7
    }, {
        options = {
            {
                type = "client",
				event = "bankanim",
                icon = "far fa-credit-card",
                label = "Bank",
                jobs = {"all"},
            },
        },
        distance = 2
    })
    AddBoxZone("bankapaleto", vector3(-111.910, 6469.748, 31.626), 0.5, 6.0, {
        name="bankapaleto",
        heading=315.0,
        debugPoly=false,
        minZ=30.8,
        maxZ=33.2
    }, {
        options = {
            {
                type = "client",
				event = "bankanim",
                icon = "far fa-credit-card",
                label = "Bank",
                jobs = {"all"},
            },
        },
        distance = 2
    })
end)

RegisterNetEvent("Player:Disconnects", function()
	local PlayerData = QBCore.Functions.GetPlayerData()
	FreezeEntityPosition(PlayerPedId(), true)
	exports["elix1rBase"]:SendAlert("" ..PlayerData.charinfo.firstname .. " " .. PlayerData.charinfo.lastname.. " You came out of your character.", "info", 5000)
	DoScreenFadeOut(2500)
	Citizen.Wait(5000)
	DoScreenFadeIn(2500)
	TriggerServerEvent("Player:Disconnect")
	FreezeEntityPosition(PlayerPedId(), false)
	exports["elix1rBase"]:SendAlert("You left your character and returned to the home screen", "success", 4000)
end)




exports['qb-target']:AddTargetModel("a_m_y_business_03", {
    options = {
        {
            type = "client",
            event = "Player:Disconnects",
            icon = "fas fa-car",
            label = "Return to Character screen",
        },
    },
    distance = 2.0
})

CreateThread(function()
    SpawnNPC()
end)


SpawnNPC = function()
    CreateThread(function()
       
        RequestModel(GetHashKey('a_m_y_business_03'))
        while not HasModelLoaded(GetHashKey('a_m_y_business_03')) do
            Wait(1)
        end
        CreateNPC()   
    end)
end


CreateNPC = function()
    created_ped = CreatePed(5, GetHashKey('a_m_y_business_03') , -260.000, -964.901, 30.224, 111.5, false, true)
    FreezeEntityPosition(created_ped, true)
    SetEntityInvincible(created_ped, true)
    SetBlockingOfNonTemporaryEvents(created_ped, true)
    TaskStartScenarioInPlace(created_ped, 'WORLD_HUMAN_CLIPBOARD', 0, true)
end




