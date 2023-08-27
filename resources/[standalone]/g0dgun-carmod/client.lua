QBCore = nil
Citizen.CreateThread(function() 
    while QBCore == nil do
        TriggerEvent("QBCore:GetObject", function(obj) QBCore = obj end)    
        Citizen.Wait(200)
    end
end)

local driftMod, oldSportMod = {}, {}
local driftCd, sportCd = false, false



-- Drift Mod
CreateThread( function()
	while true do
        local time = 1000
        local ped = PlayerPedId()
        local vehicle = GetVehiclePedIsIn(ped, false)

        if IsPedInAnyVehicle(ped) and GetPedInVehicleSeat(vehicle, -1) == ped then	
            time = 1
            if GetVehicleClass(vehicle) == 1 or GetVehicleClass(vehicle) == 3 or GetVehicleClass(vehicle) == 4 or GetVehicleClass(vehicle) == 5 or GetVehicleClass(vehicle) == 6 or GetVehicleClass(vehicle) == 7 then 
                local plate = GetVehicleNumberPlateText(vehicle)

                if IsControlJustReleased(0, 29) and not driftMod[plate] and not driftCd then
                    QBCore.Functions.TriggerCallback('carmod:isChiped', function(chiped)
                        if chiped then
                            driftMod[plate] = true
                            QBCore.Functions.Notify("Drift Mode Active")
                        end
                    end, plate)
                    TriggerEvent("g0dgun-carmod:driftCd")
                elseif IsControlJustReleased(0, 29) and driftMod[plate] and not driftCd then
                    driftMod[plate] = false
                    QBCore.Functions.Notify("Drift Mode Disabled")
                    TriggerEvent("g0dgun-carmod:driftCd")
                elseif IsControlJustReleased(0, 29) and driftCd and (driftMod[plate] or driftMod[plate] == false) then
                    QBCore.Functions.Notify("You Can't Change Mode That Fast!", "error")
                end

                if driftMod[plate] then
                    if IsControlPressed(1, 21) then
                        SetVehicleReduceGrip(vehicle, true)
                        TriggerEvent("simplecarhud:zorlahizsabitle", vehicle, true, 120)
                    elseif IsControlJustReleased(1, 21) then
                        SetVehicleReduceGrip(vehicle, false)
                        TriggerEvent("simplecarhud:zorlahizsabitle", vehicle, false)
                    end
                end
          
            end

            -- Sport Mod
            if GetVehicleClass(vehicle) == 1 or GetVehicleClass(vehicle) == 3 or GetVehicleClass(vehicle) == 4 or GetVehicleClass(vehicle) == 5 or GetVehicleClass(vehicle) == 6 or GetVehicleClass(vehicle) == 7 then 
                local plate = GetVehicleNumberPlateText(vehicle)
          
                if IsControlJustReleased(0, 131) and not sportCd then
                    QBCore.Functions.TriggerCallback('carmod:isChiped', function(chiped, onOrOff, olddata)
                        if chiped then
                            if onOrOff == nil or onOrOff == false then
                                SportModOn(vehicle, plate)
                            else
                                SportModOff(vehicle, plate, olddata)
                            end
                        end
                    end, plate)
                    TriggerEvent("g0dgun-carmod:sportCd")
                elseif IsControlJustReleased(1, 131) and sportCd then
                    QBCore.Functions.Notify("You Can't Change Mode That Fast!", "error")
                end	
            end      
        end
        Wait(time)
	end
end)

-- Çip Takma
RegisterNetEvent("carmod:chipAddClient")
AddEventHandler("carmod:chipAddClient", function()
	local playerPed = PlayerPedId()
	
	if IsPedInAnyVehicle(playerPed, false) then
		QBCore.Functions.Notify("You cannot insert the chip inside the vehicle.!")
		return
    end

    local coords = GetEntityCoords(playerPed)
    local vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)	
    if GetVehicleClass(vehicle) == 1 or GetVehicleClass(vehicle) == 3 or GetVehicleClass(vehicle) == 4 or GetVehicleClass(vehicle) == 5 or GetVehicleClass(vehicle) == 6 or GetVehicleClass(vehicle) == 7 then 
        local kaputkordinat = GetWorldPositionOfEntityBone(vehicle, GetEntityBoneIndexByName(vehicle, 'engine'))
        
        if #(coords - kaputkordinat) <= 2.3 then
            if DoesEntityExist(vehicle) then
                TriggerServerEvent("carmod:chipAdd", GetVehicleNumberPlateText(vehicle))
                SetVehicleDoorOpen(vehicle, 4, 0, 0)
                TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_BUM_BIN", 0, true)

                QBCore.Functions.Progressbar("cip_tak", "Chip Plugging", 10000, false, true, { -- p1: menu name, p2: yazı, p3: ölü iken kullan, p4:iptal edilebilir
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                }, {}, {}, {}, function() -- Done
                    QBCore.Functions.Notify("Chip Inserted")
                    ClearPedTasksImmediately(playerPed)
                    SetVehicleDoorShut(vehicle, 4, 0)
                end, function() -- Cancel
                    -- Cancel
                end)
            end
        else
            QBCore.Functions.Notify("You need to be close to the engine to install the chip")
        end
    else
        QBCore.Functions.Notify("This Vehicle Cannot Be Chipped")
    end
end)


RegisterNetEvent("g0dgun-carmod:driftCd")
AddEventHandler("g0dgun-carmod:driftCd", function()
    driftCd = true
    Citizen.Wait(3000)
    driftCd = false
end)

RegisterNetEvent("g0dgun-carmod:sportCd")
AddEventHandler("g0dgun-carmod:sportCd", function()
    sportCd = true
    Citizen.Wait(3000)
    sportCd = false
end)

function SportModOn(vehicle, plate)
    local oldfInitialDriveMaxFlatVelData = GetVehicleHandlingFloat(vehicle, "CHandlingData", "fInitialDriveMaxFlatVel")
    local oldffDriveInertiaData = GetVehicleHandlingFloat(vehicle, "CHandlingData", "fDriveInertia")
    local oldfClutchChangeRateScaleUpShiftData = GetVehicleHandlingFloat(vehicle, "CHandlingData", "fClutchChangeRateScaleUpShift")
    local oldfClutchChangeRateScaleDownShiftData = GetVehicleHandlingFloat(vehicle, "CHandlingData", "fClutchChangeRateScaleDownShift")

    oldSportMod[plate] = {
        oldfInitialDriveMaxFlatVel = oldfInitialDriveMaxFlatVelData,
        oldffDriveInertia = oldfInitialDriveMaxFlatVelData,
        oldfClutchChangeRateScaleUpShift = oldfInitialDriveMaxFlatVelData,
        oldfClutchChangeRateScaleDownShift = oldfInitialDriveMaxFlatVelData,
    }
	
	SetVehicleHandlingField(vehicle, 'CHandlingData', 'fInitialDriveMaxFlatVel', oldfInitialDriveMaxFlatVelData + (oldfInitialDriveMaxFlatVelData / 100 * 20))
	SetVehicleHandlingField(vehicle, 'CHandlingData', 'fDriveInertia', 2.000000)
	SetVehicleHandlingField(vehicle, 'CHandlingData', 'fClutchChangeRateScaleUpShift', oldfClutchChangeRateScaleUpShiftData * 8)
	SetVehicleHandlingField(vehicle, 'CHandlingData', 'fClutchChangeRateScaleDownShift', oldfClutchChangeRateScaleDownShiftData * 8)
    TriggerServerEvent("carmod:OpenSportMod", plate, oldSportMod[plate])

    QBCore.Functions.Notify("Sport Mode Active")
end

function SportModOff(vehicle, plate, olddata)
	SetVehicleHandlingField(vehicle, 'CHandlingData', 'fInitialDriveMaxFlatVel', olddata.oldfInitialDriveMaxFlatVel)
	SetVehicleHandlingField(vehicle, 'CHandlingData', 'fDriveInertia', olddata.oldffDriveInertia)
	SetVehicleHandlingField(vehicle, 'CHandlingData', 'fClutchChangeRateScaleUpShift', olddata.oldfClutchChangeRateScaleUpShift)
	SetVehicleHandlingField(vehicle, 'CHandlingData', 'fClutchChangeRateScaleDownShift', olddata.oldfClutchChangeRateScaleDownShift)
    TriggerServerEvent("carmod:CloseSportMod", plate)

    QBCore.Functions.Notify("Sport Mode Disabled")
end

RegisterCommand("pursuitmode", function()
    TriggerEvent("carmod:chipAddClient")
end)
