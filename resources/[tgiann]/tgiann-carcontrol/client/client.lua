Citizen.CreateThread(function() 
    while QBCore == nil do
        TriggerEvent("QBCore:GetObject", function(obj) QBCore = obj end)    
        Citizen.Wait(200)
    end
end)

local HasNuiFocus = false

AddEventHandler('onResourceStop', function(resourceName)
    if (GetCurrentResourceName() == resourceName) then
        SetCustomNuiFocus(false, false)
    end
end)

-- arkasagcam = not arkasagcam
-- if arkasagcam then
--     RollDownWindow(lastvehicle, 3)
--     exports["elix1rBase"]:SendAlert("Arka Sağ Cam Açıldı", "info")
-- else
--     RollUpWindow(lastvehicle, 3)
--     exports["elix1rBase"]:SendAlert("Arka Sol Cam Kapatıldı", "error")
-- end
-- end

-- RegisterCommand("neons", function()
--     local player = PlayerPedId()
-- 	if vehicle == nil then
-- 		vehicle = GetVehiclePedIsIn(player, false)
-- 	end

-- 	if vehicleplate == nil then
-- 		vehicleplate = GetVehicleNumberPlateText(vehicle)
-- 	end	
--     local neoncheck = IsVehicleNeonLightEnabled(vehicle, 0)
--     if neoncheck then
--         if vehicleplate or neoncheck then
--             SetVehicleNeonLightEnabled(vehicle, 0, false)
--             SetVehicleNeonLightEnabled(vehicle, 1, false)
--             SetVehicleNeonLightEnabled(vehicle, 2, false)
--             SetVehicleNeonLightEnabled(vehicle, 3, false)
--             QBCore.Functions.Notify('Neonlar Kapatıldı', 'error', 7500)
--         else
--             SetVehicleNeonLightEnabled(vehicle, 0, true)
--             SetVehicleNeonLightEnabled(vehicle, 1, true)
--             SetVehicleNeonLightEnabled(vehicle, 2, true)
--             SetVehicleNeonLightEnabled(vehicle, 3, true)
--             QBCore.Functions.Notify('Neonlar Açıldı', 'error', 7500)
--         end
--     else
--         QBCore.Functions.Notify('Aracının Plakasına Kayıtlı Neon Modifikasyonu Bulunmuyor', 'error', 7500)
--     end
-- end)

RegisterNUICallback('kapat', function(data, cb)
    Citizen.Wait(100)
    SetCustomNuiFocus(false, false)
end)

RegisterNetEvent('tgiann-carcontrol:open')
AddEventHandler('tgiann-carcontrol:open', function(hasFocus, hasKeyboard, hasMouse, allControl)
    Citizen.Wait(100)
    SendNUIMessage({type = "open"})
    SetCustomNuiFocus(true, true)
    exports["elix1rBase"]:SendAlert('Vehicle Interaction Menu Opened. You Can Close the Menu With "ESC" or "BACKSPACE" Keys.', "info")

end)

function SetCustomNuiFocus(hasKeyboard, hasMouse)
    HasNuiFocus = hasKeyboard or hasMouse
    SetNuiFocus(hasKeyboard, hasMouse)
    SetNuiFocusKeepInput(HasNuiFocus)
    TriggerEvent("tgiann-menuv3:nui-focus", HasNuiFocus, hasKeyboard, hasMouse, true)
end

local checkCar = true
local lastvehicle = 0

local onsolcam = false
local onsagcam = false
local arkasolcam = false
local arkasagcam = false

local inDriveSeat = false

Citizen.CreateThread(function()
    while true do 
        local time = 100
        local playerPed = PlayerPedId()
        local inVeh = IsPedInAnyVehicle(playerPed)
        if inVeh then
            local veh = GetVehiclePedIsIn(playerPed)
            if lastvehicle ~= veh then
                lastvehicle = veh
                for i=0, 3 do
                    RollUpWindow(lastvehicle, i)
                end
                onsolcam = false
                onsagcam = false
                arkasolcam = false
                arkasagcam = false
            end
        end

        if HasNuiFocus then
            time = 1
            
            if inVeh then
                SetPauseMenuActive(false)
                if IsControlJustReleased(0, 177) then
                    SendNUIMessage({type = "close"})
                end

                inDriveSeat = GetPedInVehicleSeat(lastvehicle, -1) == playerPed

                local data = {
                    onsolkoltuk = checkSeat(-1),
                    onsagkoltuk = checkSeat(0),
                    arkasolkoltuk = checkSeat(1),
                    arkasagkoltuk = checkSeat(2),

                    start = checkInDriveSeat(GetIsVehicleEngineRunning(lastvehicle)),

                    bagaj = checkInDriveSeat(GetVehicleDoorAngleRatio(lastvehicle, 5) > 0),
                    kaput = checkInDriveSeat(GetVehicleDoorAngleRatio(lastvehicle, 4) > 0),

                    onsolcam = checkInDriveSeat(onsolcam),
                    onsagcam = checkInDriveSeat(onsagcam),
                    arkasolcam = checkInDriveSeat(arkasolcam),
                    arkasagcam = checkInDriveSeat(arkasagcam),

                    onsolkapi = checkInDriveSeat(GetVehicleDoorAngleRatio(lastvehicle, 0) > 0),
                    onsagkapi = checkInDriveSeat(GetVehicleDoorAngleRatio(lastvehicle, 1) > 0),
                    arkasolkapi = checkInDriveSeat(GetVehicleDoorAngleRatio(lastvehicle, 2) > 0),
                    arkasagkapi = checkInDriveSeat(GetVehicleDoorAngleRatio(lastvehicle, 3) > 0),

                }
                SendNUIMessage({type = "update", data = data})
            else
                SendNUIMessage({type = "close"})
            end
        end
        Citizen.Wait(time)
    end
end)

function checkSeat(no)
    if IsVehicleSeatFree(lastvehicle, no) then
        return false
    elseif GetPedInVehicleSeat(lastvehicle, no) == PlayerPedId() and not IsVehicleSeatFree(lastvehicle, no) then
        return true
    else
        return "pasif"
    end
end

function checkInDriveSeat(firstData)
    if inDriveSeat then
        return firstData
    else
        return "pasif"
    end
end

RegisterNUICallback('set', function(data)
    if data.tip == "onsolkoltuk" then
        if not checkSeat(-1) then
            QBCore.Functions.Progressbar("oyuncu_iyilestir", "Changing Seat", math.random(1500, 2850), false, true, { -- p1: menu name, p2: yazı, p3: ölü iken kullan, p4:iptal edilebilir
			disableMovement = true,
			disableCarMovement = true,
			disableMouse = false,
			disableCombat = true,
		}, {
		}, {}, {}, function() -- Done
            SetPedIntoVehicle(PlayerPedId(), lastvehicle, -1)
            exports["elix1rBase"]:SendAlert("Get in the Driver's Seat", "success")
        end)
        end
    elseif data.tip == "onsagkoltuk" then
        if not checkSeat(0) then
            QBCore.Functions.Progressbar("oyuncu_iyilestir", "Changing Seat", math.random(1500, 2850), false, true, { -- p1: menu name, p2: yazı, p3: ölü iken kullan, p4:iptal edilebilir
			disableMovement = true,
			disableCarMovement = true,
			disableMouse = false,
			disableCombat = true,
		}, {
		}, {}, {}, function() -- Done
            SetPedIntoVehicle(PlayerPedId(), lastvehicle, 0)
            exports["elix1rBase"]:SendAlert("You Moved to Seat 2", "success")
        end)
        end
    elseif data.tip == "arkasolkoltuk" then
        if not checkSeat(1) then
            QBCore.Functions.Progressbar("oyuncu_iyilestir", "Changing Seat", math.random(1500, 2850), false, true, { -- p1: menu name, p2: yazı, p3: ölü iken kullan, p4:iptal edilebilir
			disableMovement = true,
			disableCarMovement = true,
			disableMouse = false,
			disableCombat = true,
		}, {
		}, {}, {}, function() -- Done
            SetPedIntoVehicle(PlayerPedId(), lastvehicle, 1)
            exports["elix1rBase"]:SendAlert("You Moved to Seat 3", "success")
        end)
        end
    elseif data.tip == "arkasagkoltuk" then
        if not checkSeat(2) then
            QBCore.Functions.Progressbar("oyuncu_iyilestir", "Changing Seat", math.random(1500, 2850), false, true, { -- p1: menu name, p2: yazı, p3: ölü iken kullan, p4:iptal edilebilir
			disableMovement = true,
			disableCarMovement = true,
			disableMouse = false,
			disableCombat = true,
		}, {
		}, {}, {}, function() -- Done
            SetPedIntoVehicle(PlayerPedId(), lastvehicle, 2)
            exports["elix1rBase"]:SendAlert("You Moved to Seat 4", "success")
        end)
        end

    elseif data.tip == "onsolkapi" and inDriveSeat then
        if GetVehicleDoorAngleRatio(lastvehicle, 0) == 0 then
            SetVehicleDoorOpen(lastvehicle, 0, false, false)
            exports["elix1rBase"]:SendAlert("You Opened the Front Left Door", "success")
        else
            SetVehicleDoorShut(lastvehicle, 0, false, false)
            exports["elix1rBase"]:SendAlert("You Closed the Front Left Door", "error")
        end
    elseif data.tip == "onsagkapi" and inDriveSeat then
        if GetVehicleDoorAngleRatio(lastvehicle, 1) == 0 then
            SetVehicleDoorOpen(lastvehicle, 1, false, false)
            exports["elix1rBase"]:SendAlert("You Opened the Front Right Door", "success")
        else
            SetVehicleDoorShut(lastvehicle, 1, false, false)
            exports["elix1rBase"]:SendAlert("You Closed the Front Right Door", "error")
        end
    elseif data.tip == "arkasolkapi" and inDriveSeat then
        if GetVehicleDoorAngleRatio(lastvehicle, 2) == 0 then
            SetVehicleDoorOpen(lastvehicle, 2, false, false)
            exports["elix1rBase"]:SendAlert("You Opened the Rear Left Door", "success")
        else
            SetVehicleDoorShut(lastvehicle, 2, false, false)
            exports["elix1rBase"]:SendAlert("You Closed the Rear Left Door", "error")
        end
    elseif data.tip == "arkasagkapi" and inDriveSeat then
        if GetVehicleDoorAngleRatio(lastvehicle, 3) == 0 then
            SetVehicleDoorOpen(lastvehicle, 3, false, false)
            exports["elix1rBase"]:SendAlert("You Opened the Rear Right Door", "success")
        else
            SetVehicleDoorShut(lastvehicle, 3, false, false)
            exports["elix1rBase"]:SendAlert("You Closed the Rear Right Door", "error")
        end
    elseif data.tip == "start" and inDriveSeat then
        TriggerEvent("x-hotwire:motorAcKapat")
        exports["elix1rBase"]:SendAlert("Vehicle Engine Started", "success")

    elseif data.tip == "bagaj" and inDriveSeat then
        if GetVehicleDoorAngleRatio(lastvehicle, 5) == 0 then
            SetVehicleDoorOpen(lastvehicle, 5, false, false)
            exports["elix1rBase"]:SendAlert("Car Trunk Opened", "success")
        else
            SetVehicleDoorShut(lastvehicle, 5, false, false)
            exports["elix1rBase"]:SendAlert("Car Trunk Closed", "error")
        end
    elseif data.tip == "kaput" and inDriveSeat then
        if GetVehicleDoorAngleRatio(lastvehicle, 4) == 0 then
            SetVehicleDoorOpen(lastvehicle, 4, false, false)
            exports["elix1rBase"]:SendAlert("Vehicle Hood Opened", "success")
        else
            SetVehicleDoorShut(lastvehicle, 4, false, false)
            exports["elix1rBase"]:SendAlert("Vehicle Hood Closed", "error")
        end
    elseif data.tip == "onsolcam" and inDriveSeat then
        onsolcam = not onsolcam
        if onsolcam then
            RollDownWindow(lastvehicle, 0)
            exports["elix1rBase"]:SendAlert("Front Left Window Opened", "success")
        else
            RollUpWindow(lastvehicle, 0)
            exports["elix1rBase"]:SendAlert("Front Left Window Covered", "error")
        end
    elseif data.tip == "onsagcam" and inDriveSeat then
        onsagcam = not onsagcam
        if onsagcam then
            RollDownWindow(lastvehicle, 1)
            exports["elix1rBase"]:SendAlert("Front Right Window Opened", "success")
        else
            RollUpWindow(lastvehicle, 1)
            exports["elix1rBase"]:SendAlert("Front Right Window Covered", "error")
        end
    elseif data.tip == "arkasolcam" and inDriveSeat then
        arkasolcam = not arkasolcam
        if arkasolcam then
            RollDownWindow(lastvehicle, 2)
            exports["elix1rBase"]:SendAlert("Rear Left Window Opened", "success")
        else
            RollUpWindow(lastvehicle, 2)
            exports["elix1rBase"]:SendAlert("Rear Left Window Covered", "error")
        end
    elseif data.tip == "arkasagcam" and inDriveSeat then
        arkasagcam = not arkasagcam
        if arkasagcam then
            RollDownWindow(lastvehicle, 3)
            exports["elix1rBase"]:SendAlert("Rear Right Window Opened", "info")
        else
            RollUpWindow(lastvehicle, 3)
            exports["elix1rBase"]:SendAlert("Rear Right Window Covered", "error")
        end
    end
end)