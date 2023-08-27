local searchedVehs = {}
local hotwiredVehs = {}
local isActive = false
local animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@"
local anim = "machinic_loop_mechandplayer"
local flags = 49
local trackedVehicles = {}
local hassearched = {}
local duzkontaklandi = {}
local maymuncuklandi = {}
local Plakalar = {}
local kilitac = false
local duzKontakSes = false
local playerLogin = false

QBCore = nil
Citizen.CreateThread(function() 
    while QBCore == nil do
        TriggerEvent("QBCore:GetObject", function(obj) QBCore = obj end)    
        Citizen.Wait(200)
    end
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    PlayerData = QBCore.Functions.GetPlayerData()
end)



RegisterNetEvent('elixir-base:araclarim')
AddEventHandler('elixir-base:araclarim', function(plaka)
	for i=1, #plaka do
        local newPlate = tgiannTrim(plaka[i].plate)
        if trackedVehicles[newPlate] == nil then TrackVehicle(newPlate) end
        if trackedVehicles[newPlate].canTurnOver == false then
            trackedVehicles[newPlate].canTurnOver = true 
            TriggerEvent("tgiann-arackilit:plakaekle", newPlate)
            TriggerEvent("tgiann-arackilit:plakaekle-xhotwire", newPlate)
        end
    end	
    playerLogin = true
end)

local playerPed = PlayerPedId()
local inVeh = IsPedInAnyVehicle(playerPed)
local playerCoords = GetEntityCoords(playerPed)
local playerVehicle = 0
local vehiclePlate = ""
local vehicleClass = 0

Citizen.CreateThread(function()
    while true do
        if playerLogin then
            playerPed = PlayerPedId()
            inVeh = IsPedInAnyVehicle(playerPed)
            playerCoords = GetEntityCoords(playerPed)
            if inVeh then
                playerVehicle = GetVehiclePedIsIn(playerPed)
                vehiclePlate = tgiannTrim(GetVehicleNumberPlateText(playerVehicle))
                vehicleClass = GetVehicleClass(playerVehicle)
                inDriveSeat = GetPedInVehicleSeat(playerVehicle, -1) == playerPed

                if inDriveSeat then
                    if trackedVehicles[vehiclePlate] then
                        if not trackedVehicles[vehiclePlate].canTurnOver or trackedVehicles[vehiclePlate].state == 0 then
                            SetVehicleEngineOn(playerVehicle, false, false, true)
                        elseif trackedVehicles[vehiclePlate].state == 1 then
                            SetVehicleEngineOn(playerVehicle, true, false, false)
                            trackedVehicles[vehiclePlate].state = -1
                        end
                    else
                        SetVehicleEngineOn(playerVehicle, false, false, false)
                    end
                end

            else
                playerVehicle, vehiclePlate, inDriveSeat = 0, "", false
            end
        end
        Citizen.Wait(250)
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(100)
        if DoesEntityExist(GetVehiclePedIsTryingToEnter(playerPed)) then
            local veh = GetVehiclePedIsTryingToEnter(playerPed)
            local driverPed = GetPedInVehicleSeat(veh, -1)
            
            SetVehicleNeedsToBeHotwired(veh) -- disable native hotwire
            if GetEntityModel(veh) == 1747439474 then
                if #(playerCoords - GetEntryPositionOfDoor(veh, 2)) < 1 or #(playerCoords - GetEntryPositionOfDoor(veh, 3)) < 1 then
                    ClearPedTasks(playerPed)
                    Citizen.Wait(100)
                end
            end

            if GetVehicleDoorLockStatus(veh) == 7 then
                SetVehicleDoorsLocked(veh, 2)
            end
            
            if driverPed and DoesEntityExist(driverPed) then
                SetPedCanBeDraggedOut(driverPed, false)
            end

            if GetVehicleDoorLockStatus(veh) == 4 then
                ClearPedTasks(playerPed)
                Citizen.Wait(100)
			end

            if GetIsVehicleEngineRunning(veh) then
                Citizen.Wait(100)
                if GetPedInVehicleSeat(veh, -1) == playerPed and GetVehicleClass(veh) ~= 15 and GetVehicleClass(veh) ~= 16 and GetVehicleClass(veh) ~= 19 then
                    TriggerEvent("x-hotwire:give-keys", veh)
                    Citizen.Wait(5000)
                end
            end
        end
    end
end)

RegisterNetEvent('x-hotwire:tgiannf3inahtar')
AddEventHandler('x-hotwire:tgiannf3inahtar', function()
    if IsPedInAnyVehicle(playerPed, false) then
        vehicle = GetVehiclePedIsIn(playerPed, false)
    else
        vehicle, mesafe = QBCore.Functions.GetClosestVehicle(playerCoords)
    end 

    local plate = tgiannTrim(GetVehicleNumberPlateText(vehicle))
    if Plakalar[plate] then
        local closestPlayer, closestDistance = QBCore.Functions.GetClosestPlayer()
        if closestDistance < 4.0 and closestDistance ~= -1 then
            TriggerServerEvent("ARPF:GiveKeys", GetPlayerServerId(closestPlayer), vehicle, plate)
            QBCore.Functions.Notify('You Give Your Key To Someone Nearby')  
        else
            QBCore.Functions.Notify('No One Near You To Give The Key To')
        end
    else
        QBCore.Functions.Notify('No One Near You To Give The Key To!')
    end           
end)


RegisterNetEvent('x-hotwire:give-keys')
AddEventHandler('x-hotwire:give-keys', function(veh, plate)
    if plate == nil then plate = GetVehicleNumberPlateText(veh) end
    local newPlate = tgiannTrim(plate)
    if trackedVehicles[newPlate] == nil then TrackVehicle(newPlate) end
    if trackedVehicles[newPlate].canTurnOver == false then
        trackedVehicles[newPlate].canTurnOver = true 
        SetVehicleHasBeenOwnedByPlayer(veh, true)
        SetNetworkIdCanMigrate(NetworkGetNetworkIdFromEntity(veh), true)
        TriggerEvent("tgiann-arackilit:plakaekle", newPlate)
        TriggerEvent("tgiann-arackilit:plakaekle-xhotwire", newPlate)
    end
end)

RegisterNetEvent('tgiann-arackilit:plakaekle-xhotwire')
AddEventHandler('tgiann-arackilit:plakaekle-xhotwire', function(yeniplaka)
    local newPlate = tgiannTrim(yeniplaka)
    if Plakalar[newPlate] == nil then Plakalar[newPlate] = true end
end)

RegisterNetEvent('disc-hotwire:forceTurnOver')
AddEventHandler('disc-hotwire:forceTurnOver', function(vehicle)
    local plate = tgiannTrim(GetVehicleNumberPlateText(vehicle))
    TrackVehicle(plate)
    trackedVehicles[plate].canTurnOver = true
end)

RegisterNetEvent("disc-hotwire:disardanMaymuncuk")
AddEventHandler("disc-hotwire:disardanMaymuncuk", function()
    if isActive then return end
    local vehicle, mesafe = QBCore.Functions.GetClosestVehicle(playerCoords)
    if mesafe < 3 then
        if GetVehiclePedIsIn(playerPed, false) == 0 and DoesEntityExist(vehicle) and  GetVehicleDoorLockStatus(vehicle) == 2 then
            isActive = true

            time = 10000
            duzKontakSes = true
            kilitac = true
            TriggerEvent("animation:lockpickinvtestoutside")
            TriggerEvent("x-hotwire:duzKontakSes")
            SetVehicleDoorsShut(vehicle, true)
            SetVehicleAlarm(vehicle, true)
            SetVehicleAlarmTimeLeft(vehicle, 20 * 1000)
            local finished = exports["tgiann-skillbar"]:taskBar(15600,math.random(5,8))
            if not finished then
                isActive = false
                duzKontakSes = false
                kilitac = false
            else
                local finished2 = exports["tgiann-skillbar"]:taskBar(13500,math.random(5,8))
                if not finished2 then
                    isActive = false
                    duzKontakSes = false
                    kilitac = false
                else
                    local finished3 = exports["tgiann-skillbar"]:taskBar(9900,math.random(5,8))
                    if not finished3 then
                        isActive = false
                        duzKontakSes = false
                        kilitac = false
                    else
                        local finished4 = exports["tgiann-skillbar"]:taskBar(8500,math.random(5,8))
                        if not finished4 then
                            isActive = false
                            duzKontakSes = false
                         kilitac = false
                    else
                            local Plate = QBCore.Shared.Trim(GetVehicleNumberPlateText(vehicle))
                            TriggerServerEvent("tgiann-arackilit:lock-car-server", 1, Plate)
                            SetVehicleDoorsLocked(vehicle, 1)
                            isActive = false
                            duzKontakSes = false
                            kilitac = false 
                            QBCore.Functions.Notify('Door Opened Successfully')
                            if math.random(1,100) < 50 then
                                TriggerEvent("dp", GetEntityModel(vehicle), Plate)
                            end
                        end
                    end
                end
            end
         
        end
    end
end)

RegisterNetEvent('disc-hotwire:maymuncuk')
AddEventHandler('disc-hotwire:maymuncuk', function()
    if isActive then return end
    if IsPedInAnyVehicle(playerPed) then 
        if GetIsVehicleEngineRunning(playerVehicle) or trackedVehicles[vehiclePlate].canTurnOver then return end
        if vehicleClass ~= 14 then
            SetVehicleAlarm(playerVehicle, false)
            SetVehicleAlarm(playerVehicle, true)
            SetVehicleAlarmTimeLeft(playerVehicle, 30 * 1000)
        end
        isActive = true
        TriggerEvent("dp")
        local finished = exports["tgiann-skillbar"]:taskBar(75000,math.random(5,8))
        if not finished then
            if math.random(1,3) == 1 then TriggerServerEvent('disc-hotwire:maymuncuksil') end
            isActive = false
            duzKontakSes = false
        else
            duzKontakSes = true
            TriggerEvent("x-hotwire:duzKontakSes")
            TriggerEvent("tgiann-stres:stres-arttir", 80)
            local finished2 = exports["tgiann-skillbar"]:taskBar(65000,math.random(5,12))
            if not finished2 then
                if math.random(1,3) == 1 then TriggerServerEvent('disc-hotwire:maymuncuksil') end
                isActive = false
                duzKontakSes = false
            else
                local finished3 = exports["tgiann-skillbar"]:taskBar(55000,math.random(5,12))
                if not finished3 then
                    if math.random(1,3) == 1 then TriggerServerEvent('disc-hotwire:maymuncuksil') end
                    isActive = false
                    duzKontakSes = false
                else
                TriggerEvent("tgiann-stres:stres-arttir", 80)
                local finished3 = exports["tgiann-skillbar"]:taskBar(35000, math.random(10,14))
                if not finished3 then
                    isActive = false
                    duzKontakSes = false
                else
                    trackedVehicles[vehiclePlate].canTurnOver = true
                    maymuncuklandi[vehiclePlate] = true 
                    local vehicleProps = QBCore.Functions.GetVehicleProperties(playerVehicle)
                    TriggerEvent("tgiann-arackilit:plakaekle", vehicleProps.plate)
                    TriggerEvent("tgiann-arackilit:plakaekle-xhotwire", vehicleProps.plate)
                    TriggerEvent("tgiann-stres:stres-arttir", 80)
                    SetVehicleEngineOn(playerVehicle, true, false, false)
                    duzKontakSes = false
                    isActive = false
                end
                end
            end
        end
    end
end)

-- Araç içi düzkontak
-- RegisterNetEvent('disc-hotwire:hotwire')
-- AddEventHandler('disc-hotwire:hotwire', function()
--     if inVeh then 
--         if GetIsVehicleEngineRunning(playerVehicle) or IsVehicleEngineStarting(playerVehicle) or trackedVehicles[vehiclePlate].canTurnOver or isActive then return end

--         isActive = true
--         if vehicleClass ~= 14 then
--             SetVehicleAlarm(playerVehicle, false)
--             SetVehicleAlarm(playerVehicle, true)
--             SetVehicleAlarmTimeLeft(playerVehicle, 30 * 1000)
--         end
--         local finished = exports["tgiann-skillbar"]:taskBar(30000,math.random(8,10))
--         if not finished then
--             isActive = false
--             duzKontakSes = false
--         else
--             duzKontakSes = true
--             TriggerEvent("x-hotwire:duzKontakSes")
--             TriggerEvent("tgiann-stres:stres-arttir", 80)
--             local finished2 = exports["tgiann-skillbar"]:taskBar(2000,math.random(8,12))
--             if not finished2 then
--                 isActive = false
--                 duzKontakSes = false
--             else
--                 TriggerEvent("tgiann-stres:stres-arttir", 80)
--                 local finished3 = exports["tgiann-skillbar"]:taskBar(1000,math.random(8,11))
--                 if not finished3 then
--                     isActive = false
--                     duzKontakSes = false
--                 else
--                     local finished4 = exports["tgiann-skillbar"]:taskBar(4200,math.random(10,18))
--                     if not finished4 then
--                         isActive = false
--                         duzKontakSes = false
--                     else
--                         local finished5 = exports["tgiann-skillbar"]:taskBar(1400,math.random(10,16))
--                         if not finished5 then
--                             isActive = false
--                             duzKontakSes = false
--                         else
--                             ClearPedSecondaryTask(playerPed)
--                             Citizen.Wait(2000)
--                             trackedVehicles[vehiclePlate].canTurnOver = true
--                             local vehicleProps = QBCore.Functions.GetVehicleProperties(playerVehicle)
--                             TriggerEvent("tgiann-arackilit:plakaekle", vehicleProps.plate)
--                             TriggerEvent("tgiann-arackilit:plakaekle-xhotwire", vehicleProps.plate)
--                             TriggerEvent("tgiann-stres:stres-arttir", 80)
--                             SetVehicleEngineOn(playerVehicle, true, false, false)
--                             RemoveAnimDict(animDict)
--                             isActive = false
--                             duzKontakSes = false
--                         end
--                     end
--                 end
--             end
--         end
--         isActive = false
--     end
-- end)

function searchvehicle()
    if trackedVehicles[vehiclePlate] then
        if trackedVehicles[vehiclePlate].canTurnOver == false then
            local luck = math.random(20,69)
            if not inVeh then QBCore.Functions.Notify('You are not in the vehicle?')  return  end
            if luck >= 66 then --66
                QBCore.Functions.Notify('You Found the Key and Youre Using It!')
                Citizen.Wait(3000)
                local vehicleProps = QBCore.Functions.GetVehicleProperties(playerVehicle)
                TriggerEvent("tgiann-arackilit:plakaekle", vehicleProps.plate)
                TriggerEvent("tgiann-arackilit:plakaekle-xhotwire", vehicleProps.plate)
                trackedVehicles[vehiclePlate].canTurnOver = true
            elseif luck >= 40 and luck <= 65 then  
                TriggerServerEvent("disc-hotwire:aracitem", QBCore.Key)
            elseif luck >= 15 and luck <= 39 then  
                QBCore.Functions.Notify('You Find Some Money In The Vehicle And You Take It..')
                Citizen.Wait(3000)
                cashreward = math.random(exports["elixir-base"]:itemPrice('AracAramaPara').r1, exports["elixir-base"]:itemPrice('AracAramaPara').r2)
                QBCore.Functions.Notify(cashreward .."$ Found")
                TriggerServerEvent("disc-hotwire:givereward", cashreward, QBCore.Key)
            else
                QBCore.Functions.Notify('You Didnt Find Anything!')  
            end
        end
    end
end

Citizen.CreateThread(function()
    while true do
        local time = 1000
        if inVeh then
            if inDriveSeat then
                if playerLogin and trackedVehicles[vehiclePlate] and not trackedVehicles[vehiclePlate].canTurnOver then
                    time = 1
                    arackontrol(playerPed, playerCoords, playerVehicle, vehiclePlate)
                else
                    TrackVehicle(vehiclePlate)
                    Citizen.Wait(1000)
                end
            end
        end
        Citizen.Wait(time)
    end
end)

function arackontrol(playerPed, coords, vehicle, plate)
    if vehicleClass ~= 15 and vehicleClass ~= 16 and vehicleClass ~= 19 and vehicleClass ~= 13 and vehicleClass ~= 10 and vehicleClass ~= 11 and vehicleClass ~= 17 then
        SetVehicleEngineOn(vehicle, false, false, false)
        local kaput = GetEntityBoneIndexByName(vehicle, 'engine')
        local vehiclePos = GetWorldPositionOfEntityBone(vehicle, kaput)
        DisableControlAction(0, 59) -- leaning left/right
        DisableControlAction(0, 60) -- leaning up/down
        if hassearched[plate] == false or hassearched[plate] == nil then 
            QBCore.Functions.DrawText3D(vehiclePos.x, vehiclePos.y, vehiclePos.z+0.20, "[M] Hotwire | [Z] Search")
        elseif hassearched[plate] == true then 
            QBCore.Functions.DrawText3D(vehiclePos.x, vehiclePos.y, vehiclePos.z+0.20, "[M] Hotwire")
        end

        if IsControlJustPressed(0, 304) and not duzkontaklandi[plate] == true then
            TriggerEvent("disc-hotwire:hotwire")
        elseif IsControlJustPressed(0, 244) and not maymuncuklandi[plate] == true then
            QBCore.Functions.TriggerCallback('elixir-base:item-kontrol', function(qtty)
                if qtty > 0 then
                    TriggerEvent('disc-hotwire:maymuncuk')
                else
                    QBCore.Functions.Notify('No Picks On you!')
                end
            end, "lockpick2")
        elseif IsControlJustPressed(0, 304) and not duzkontaklandi[plate] == false then
            QBCore.Functions.Notify('All the Cables Are Intertwined You Cant Solve!')
        end
        if IsDisabledControlJustPressed(0, 20) and not hassearched[plate] == true then
            if isActive then return end
            isActive = true

            if math.random(1,100) < 30 then end
            TriggerEvent("dp", GetEntityModel(vehicle), plate)
            TriggerEvent("tgiann-stres:stres-arttir", 80)

            QBCore.Functions.Progressbar("search", "Searching Vehicle", 25000, false, true, { -- p1: menu name, p2: yazı, p3: ölü iken kullan, p4:iptal edilebilir
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            }, {}, {}, {}, function() -- Done
                hassearched[plate] = true 
                isActive = false
                searchvehicle()
            end, function() -- Cancel
                isActive = false
                QBCore.Functions.Notify('You Canceled Searching!')
            end)
            
        end
    end
end

RegisterNetEvent('animation:lockpickinvtestoutside')
AddEventHandler('animation:lockpickinvtestoutside', function()
    RequestAnimDict("veh@break_in@0h@p_m_one@")
    while not HasAnimDictLoaded("veh@break_in@0h@p_m_one@") do
        Citizen.Wait(0)
    end
    while kilitac do
      TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 3.0, 'lockpick', 0.4)
      TaskPlayAnim(playerPed, "veh@break_in@0h@p_m_one@", "low_force_entry_ds", 1.0, 1.0, 1.0, 16, 0.0, 0, 0, 0)
      Citizen.Wait(2000)
      ClearPedTasks(playerPed)
    end
    ClearPedTasks(playerPed)
end)

RegisterNetEvent('x-hotwire:duzKontakSes')
AddEventHandler('x-hotwire:duzKontakSes', function()
    while duzKontakSes do
      TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 3.0, 'duzkontak', 0.4)
      Citizen.Wait(3000)
    end
end)

function TrackVehicle(plate)
    if trackedVehicles[plate] == nil then
        trackedVehicles[plate] = {}
        trackedVehicles[plate].canTurnOver = false
    end
end

function VehicleInFront()
    local entityWorld = GetOffsetFromEntityInWorldCoords(playerPed, 0.0, 2.0, 0.0)
    local rayHandle = CastRayPointToPoint(playerCoords.x, playerCoords.y, playerCoords.z, entityWorld.x, entityWorld.y, entityWorld.z, 30, playerPed, 0)
    local _, _, _, _, result = GetRaycastResult(rayHandle)
    return result
end

-- Motor Aç Kapat
Citizen.CreateThread(function()
    while true do
        local time = 1000
        if inVeh and inDriveSeat then
            time = 1
            if IsControlJustReleased(1, 244) then
                motarAcKapat()
            end            
        end
        Citizen.Wait(time) 
    end
end)

RegisterNetEvent("x-hotwire:motorAcKapat")
AddEventHandler("x-hotwire:motorAcKapat" ,function()
    motarAcKapat()
end)

function motarAcKapat()
    if trackedVehicles[vehiclePlate] == nil then
        TrackVehicle(vehiclePlate)
    end

    if GetIsVehicleEngineRunning(playerVehicle) == 1 then
        trackedVehicles[vehiclePlate].state = 0
    elseif trackedVehicles[vehiclePlate].canTurnOver then
        trackedVehicles[vehiclePlate].state = 1
    elseif trackedVehicles[vehiclePlate] ~= nil then
        if Plakalar[vehiclePlate] then
            trackedVehicles[vehiclePlate].canTurnOver = true
            trackedVehicles[vehiclePlate].state = 1
        end
    end
end

tgiannTrim = function(value)
	if value then
		return (string.gsub(value, "^%s*(.-)%s*$", "%1"))
	else
		return nil
	end
end

function bildirim(v, p)  
    local ped = PlayerPedId()
    local playerPos = GetEntityCoords(ped)
    local id = math.random(25, 99)
    
    data = {
        id = id,
        code = 10-40,
        description = "Vehicle Theft",
        location = GetTheStreet(),
        coords = playerPos,
        sprite = 225,
        vehicleModel = v, 
        plate = p
    }   
    TriggerServerEvent("jtDispatch:add-notification", data, "police")
end



RegisterNetEvent("dp", function(v,p)
    bildirim(v,p)
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