local baitLocation = nil
local baitLastPlaced = 0
local targetedEntity = nil
local huntingAreData = {}
local targetedEntityCoord = nil

local baitDistanceInUnits = 40
local spawnDistanceRadius = 30
local validHuntingZones = {
    ["Paleto Forest"] = true,
    ["Raton Canyon"] = true,
    ["Mount Chiliad"] = true,
    ["Cassidy Creek"] = true
}

exports("huntingArea", function()
    return validHuntingZones
end)

DecorRegister("HuntingMySpawn", 2)

QBCore = nil
Citizen.CreateThread(function() 
    while QBCore == nil do
        TriggerEvent("QBCore:GetObject", function(obj) QBCore = obj end)    
        Citizen.Wait(200)
    end
end)


Citizen.CreateThread(function()
    while true do
        local idle = 250
        local PlayerPed = PlayerPedId()
        local entity, entityType, entityCoords = GetEntityPlayerIsLookingAt(3.0, 0.2, 286, PlayerPed)

        if entity and entityType ~= 0 then
            if entity ~= CurrentTarget then
                CurrentTarget = entity
                TriggerEvent('target:changed', CurrentTarget, entityType, entityCoords)
            end
        elseif CurrentTarget then
            CurrentTarget = nil
            TriggerEvent('target:changed', CurrentTarget)
        end

        Citizen.Wait(idle)
    end
end)

function GetEntityPlayerIsLookingAt(pDistance, pRadius, pFlag, pIgnore)
    local distance = pDistance or 3.0
    local originCoords = GetPedBoneCoords(PlayerPedId(), 31086)
    local forwardVectors = GetForwardVector(GetGameplayCamRot(2))
    local forwardCoords = originCoords + (forwardVectors * (IsInVehicle and distance + 1.5 or distance))

    if not forwardVectors then return end

    local _, hit, targetCoords, _, targetEntity = RayCast(originCoords, forwardCoords, pFlag or 286, pIgnore, pRadius or 0.2)

    if not hit and targetEntity == 0 then return end

    local entityType = GetEntityType(targetEntity)

    return targetEntity, entityType, targetCoords
end

function GetForwardVector(rotation)
    local rot = (math.pi / 180.0) * rotation
    return vector3(-math.sin(rot.z) * math.abs(math.cos(rot.x)), math.cos(rot.z) * math.abs(math.cos(rot.x)), math.sin(rot.x))
end

function RayCast(origin, target, options, ignoreEntity, radius)
    local handle = StartShapeTestSweptSphere(origin.x, origin.y, origin.z, target.x, target.y, target.z, radius, options, ignoreEntity, 0)
    return GetShapeTestResult(handle)
end

RegisterNetEvent("target:changed")
AddEventHandler("target:changed", function(pEntity, type, coords)
    targetedEntity = pEntity
    targetedEntityCoord = coords
end)

local function isValidZone()
    return validHuntingZones[GetLabelText(GetNameOfZone(GetEntityCoords(PlayerPedId())))] == true
end

local function getSpawnLoc()
    local playerCoords = GetEntityCoords(PlayerPedId())
    local spawnCoords = nil
    while spawnCoords == nil do
        local spawnX = math.random(-spawnDistanceRadius, spawnDistanceRadius)
        local spawnY = math.random(-spawnDistanceRadius, spawnDistanceRadius)
        local spawnZ = baitLocation.z
        local vec = vector3(baitLocation.x + spawnX, baitLocation.y + spawnY, spawnZ)
        if #(playerCoords - vec) > spawnDistanceRadius then
            spawnCoords = vec
        end
    end
    local worked, groundZ, normal = GetGroundZAndNormalFor_3dCoord(spawnCoords.x, spawnCoords.y, 1023.9)
    spawnCoords = vector3(spawnCoords.x, spawnCoords.y, groundZ)
    return spawnCoords
end

local function spawnAnimal(loc)
    local foundAnimal = false

    local modelName = `a_c_deer`
    RequestModel(modelName)
    while not HasModelLoaded(modelName) do
        Citizen.Wait(0)
    end
    local spawnLoc = getSpawnLoc()
    local spawnedAnimal = CreatePed(28, modelName, spawnLoc, true, true, true)
    DecorSetBool(spawnedAnimal, "HuntingMySpawn", true)
    SetModelAsNoLongerNeeded(modelName)
    TaskGoStraightToCoord(spawnedAnimal, loc, 1.0, -1, 0.0, 0.0)
    Citizen.CreateThread(function()
        local finished = false
        while not IsPedDeadOrDying(spawnedAnimal) and not finished do
            local spawnedAnimalCoords = GetEntityCoords(spawnedAnimal)
            if #(loc - spawnedAnimalCoords) < 0.5 then
                ClearPedTasks(spawnedAnimal)
                Citizen.Wait(1500)
                TaskStartScenarioInPlace(spawnedAnimal, "WORLD_DEER_GRAZING", 0, true)
                Citizen.SetTimeout(7500, function()
                    finished = true
                end)
            end
            if #(spawnedAnimalCoords - GetEntityCoords(PlayerPedId())) < 15.0 then
                ClearPedTasks(spawnedAnimal)
                TaskSmartFleePed(spawnedAnimal, PlayerPedId(), 600.0, -1)
                finished = true
            end
            Citizen.Wait(1000)
        end
        if not IsPedDeadOrDying(spawnedAnimal) then
            TaskSmartFleePed(spawnedAnimal, PlayerPedId(), 600.0, -1)
        end
    end)
end

local function baitDown()
    Citizen.CreateThread(function()
        while baitLocation ~= nil do
            if #(baitLocation - GetEntityCoords(PlayerPedId())) > baitDistanceInUnits then
                if math.random() < 0.15 then
                    spawnAnimal(baitLocation)
                    baitLocation = nil
                end
            end
            Citizen.Wait(5000)
        end
    end)
end

local bussy = true
local lastTime = GetGameTimer() + 3000
RegisterNetEvent('tgiann-hunting:use-item')
AddEventHandler('tgiann-hunting:use-item', function(item)
    if GetGameTimer() > lastTime then
        lastTime = GetGameTimer() + 3000
        if item == "huntingbait" then
            if not isValidZone() then
                QBCore.Functions.Notify("You Can't Hunt In This Environment!", "error")
                return
            end
            if baitLastPlaced ~= 0 and GetGameTimer() < (baitLastPlaced + 180000) then -- 5 minutes
                QBCore.Functions.Notify("You Can Place a Bait Every 3 Minutes", "error")
                return
            end
            if bussy then
                bussy = false
                baitLocation = nil
                TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_GARDENER_PLANT", 0, true)

                QBCore.Functions.Progressbar("placing_bait", "Feed is placed...", 15000, false, false, { -- p1: menu name, p2: yazı, p3: ölü iken kullan, p4:iptal edilebilir
                    disableMovement = true,
                    disableCarMovement = false,
                    disableMouse = false,
                    disableCombat = true,
                }, {}, {}, {}, function() -- Done
                    ClearPedTasksImmediately(PlayerPedId())
                    baitLastPlaced = GetGameTimer()
                    baitLocation = GetEntityCoords(PlayerPedId())
                    QBCore.Functions.Notify("The Bait Is Placed, Now Move Away And Wait For Your Prey")
                    TriggerServerEvent("tgiann-hunting:removeItem", item)
                    baitDown()
                    bussy = true
                end, function() -- Cancel
                    bussy = true
                end)
            end
        end
        if item == "huntingknife" then
            if GetPedType(targetedEntity) ~= 28 or not IsPedDeadOrDying(targetedEntity) then
                QBCore.Functions.Notify("You're Not Looking at an Animal!")
                return
            end

            if GetEntityModel(targetedEntity) ~= -664053099 then
                QBCore.Functions.Notify("You Can't Kill an Animal Except a Deer!", "error")
                return
            end

            local found, player = GetClosestPlayerMenu()
            if found then
                QBCore.Functions.Notify("You Can't Do This With Someone Near You!", "error")
                return
            end

            if #(targetedEntityCoord - GetEntityCoords(PlayerPedId())) > 3 then
                QBCore.Functions.Notify("You Are Too Far From The Animal!", "error")
                return
            end

            if bussy then
                bussy = false
                local myAnimal = targetedEntity
                TriggerEvent("inventory:drop-weapon", false)
                TaskTurnPedToFaceEntity(PlayerPedId(), myAnimal, -1)
                Citizen.Wait(1500)
                ClearPedTasksImmediately(PlayerPedId())
                TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_GARDENER_PLANT", 0, true)

                QBCore.Functions.Progressbar("preparing_animal", "cutting off...", 40000, false, true, { -- p1: menu name, p2: yazı, p3: ölü iken kullan, p4:iptal edilebilir
                    disableMovement = true,
                    disableCarMovement = false,
                    disableMouse = false,
                    disableCombat = true,
                }, {}, {}, {}, function() -- Done
                    ClearPedTasksImmediately(PlayerPedId())
                    local mySpawn = DecorExistOn(myAnimal, "HuntingMySpawn") and DecorGetBool(myAnimal, "HuntingMySpawn")
                    TriggerServerEvent("tgiann-hunting:giveItem", QBCore.Key)
                    TriggerServerEvent("lapdance:delete-ped", NetworkGetNetworkIdFromEntity(myAnimal))
                    bussy = true
                    -- exports['jtLevelSystem']:updateXPavci(5)
                end, function() -- Cancel
                    ClearPedTasksImmediately(PlayerPedId())
                    bussy = true
                end)
            end
        end
    else
        QBCore.Functions.Notify("You Can Use This Item Every 3 Seconds!", "error")
    end
end)

function GetClosestPlayerMenu()
	local player, distance = QBCore.Functions.GetClosestPlayer()
	if distance ~= -1 and distance <= 5.0 then
		return true, GetPlayerServerId(player)
	else
		return false
	end
end

Citizen.CreateThread(function()
    while true do
        local time = 2000
        local ped = PlayerPedId()
        if IsPedArmed(ped, 7) then
            time = 1
            if IsPedShooting(ped) then
                if math.random(1,2) == 1 then
                    local weaponSlec = GetSelectedPedWeapon(ped)
                    if weaponSlec ~= `WEAPON_SNOWBALL` then
                        local isStungun = weaponSlec == `weapon_stungun`
                        local PlayerData = QBCore.Functions.GetPlayerData()
                        if PlayerData.job == nil then PlayerData = QBCore.Functions.GetPlayerData() end
                        local duty = false
                        local police = false
                            if weaponSlec == `weapon_sniperrifle` then
                                HuntingArea = huntingAreData[GetLabelText(GetNameOfZone(GetEntityCoords(PlayerPedId())))] == true
                                if not HuntingArea and  QBCore.Functions.GetPlayerData().metadata["huntinglicense"] == 0 then
                                local ped = PlayerPedId()
                                local playerPos = GetEntityCoords(ped)
                                local id = math.random(1, 9999)
                                    data = {
                                        id = id,
                                        code = 10-78,
                                        description = "Unlicensed Hunting.",
                                        location = GetTheStreet(),
                                        coords = playerPos,
                                        sprite = 160
                                    }   
                                    TriggerServerEvent("jtDispatch:add-notification", data, "police")
                                end
                            else
                                if isStungun then
                                    if PlayerData.job.name ~= 'ambulance' then
                                    end
                                else
                                
                                end
                            end
                            Citizen.Wait(2000)
                    end
                else
                    Citizen.Wait(2000)
                end
            end
        end
        Citizen.Wait(time)
    end
end)

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
        ZoneNames[tostring(zone)] = "Unknown Region"
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


local function polisbildirim()
local ped = PlayerPedId()
local playerPos = GetEntityCoords(ped)
local id = math.random(1, 9999)

    data = {
        id = id,
        code = 10-78,
        description = "Unlicensed Hunting.",
        location = GetTheStreet(),
        coords = playerPos,
        sprite = 439
    }   
    TriggerServerEvent("jtDispatch:add-notification", data, "police")
end

-- function polisBildirim2()  
--     local ped = PlayerPedId()
--     local playerPos = GetEntityCoords(ped)
--     local id = math.random(25, 99)
    
--     data = {
--         id = id,
--         code = 10-40,
--         description = "Stinger S-200(Taser) Kullanımı",
--         location = GetTheStreet()
--         coords = playerPos,
--         sprite = 439
--     }   ,
--     TriggerServerEvent("jtDispatch:add-notification", data, "police")
-- end