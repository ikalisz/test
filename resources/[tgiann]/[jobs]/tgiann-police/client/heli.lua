local fov_max = 110
local fov_min = 7.5 -- max zoom level (smaller fov is more zoom)
local zoomspeed = 3.0 -- camera zoom speed
local speed_lr = 8.0 -- speed by which the camera pans left-right
local speed_ud = 8.0 -- speed by which the camera pans up-down
local minHeightAboveGround = 1.5 -- default: 1.5. Minimum height above ground to activate Heli Cam (in metres). Should be between 1 and 20.
local termal = true
local useMilesPerHour = false -- 0 is kmh; 1 is mph
local policeVehicles = {`polas350`, `maverick2`, `seasparrow2`}

-- Script starts here
local helicam = false -- is in helicam
local fov = (fov_max + fov_min) * 0.5
local vision_state = 0 -- 0 is normal, 1 is night vision, 2 is thermal vision
local spotlight_state = false
local lastVisionTime = 0

local currentPlayerId = GetPlayerServerId(NetworkGetEntityOwner(PlayerPedId()))

Citizen.CreateThread(function()
	RegisterKeyMapping('+policeHeliCam', 'Helicopter (Camera)', 'keyboard', 'e')
    RegisterKeyMapping('+policeRappel', 'Helicopter (Rope)', 'keyboard', 'x')
    RegisterKeyMapping('+policeSpotLight', 'Helicopter (Spot Light)', 'keyboard', 'g')
    RegisterKeyMapping('+policeVision', 'Helicopter (Camera View)', 'mouse_button', 'mouse_right')
end)

RegisterCommand('+policeHeliCam', function()
    local veh = GetVehiclePedIsIn(playerPed)
    if IsPlayerInPolmav() then
        if IsHeliHighEnough(veh) then
            if not helicam then
                if GetPedInVehicleSeat(veh, 0) == playerPed then
                    PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)
                    helicam = true
                    SendNUIMessage({type = 'show'})
                else
                    QBCore.Functions.Notify("You can only use the camera while in the Co-Pilot seat!", "error")
                end
            else
                PlaySoundFrontend(-1, "SELECT","HUD_FRONTEND_DEFAULT_SOUNDSET", false)
                helicam = false
                SendNUIMessage({type = 'hide'})
            end
        end
    end
end, false)

RegisterCommand('+policeRappel', function()
    local veh = GetVehiclePedIsIn(playerPed)
    if IsPlayerInPolmav() then
        if IsHeliHighEnough(veh) then
            if GetPedInVehicleSeat(veh, 1) == playerPed or GetPedInVehicleSeat(veh, 2) == playerPed then
                PlaySoundFrontend(-1, "SELECT","HUD_FRONTEND_DEFAULT_SOUNDSET", false)
                TaskRappelFromHeli(playerPed, 1)
            else
                SetNotificationTextEntry("STRING")
                QBCore.Functions.Notify("You can't use the rope while you're in the pilot seat!", "error", 5000)
                PlaySoundFrontend(-1, "5_Second_Timer", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", false)
            end
        end
    end
end, false)

RegisterCommand('+policeSpotLight', function()
    if helicam or spotlight_state then
        PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)
        spotlight_state = not spotlight_state
        if spotlight_state then
            TriggerServerEvent("heli:spotlight_on", currentPlayerId, 0)
        else
            TriggerServerEvent("heli:spotlight_off", currentPlayerId, 0)
        end
    end
end, false)

RegisterCommand('+policeVision', function()
    if helicam then
        PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)
        ChangeVision()
    end
end, false)

Citizen.CreateThread(function()
    while true do
        local time = 100
        if helicam then
            time = 1
            local scaleform = RequestScaleformMovie("DRONE_CAM")
            while not HasScaleformMovieLoaded(scaleform) do
                Citizen.Wait(0)
            end

            local heli = GetVehiclePedIsIn(playerPed)
            local cam = CreateCam("DEFAULT_SCRIPTED_FLY_CAMERA", true)
            AttachCamToEntity(cam, heli, 0.0, 0.0, -1.5, true)
            SetCamRot(cam, 0.0, 0.0, GetEntityHeading(heli))
            SetCamFov(cam, fov)
            RenderScriptCams(true, false, 0, 1, 0)

            local locked_on_vehicle = nil
            while helicam and not IsEntityDead(playerPed) and GetVehiclePedIsIn(playerPed) == heli and IsHeliHighEnough(heli) do

                DisableControlAction(0, 75, true) -- disable exit vehicle
                DisableControlAction(27, 75, true) -- disable exit vehicle

                local vehicle = nil

                local zoomvalue = (1.0 / (fov_max - fov_min)) * (fov - fov_min)
                CheckInputRotation(cam, zoomvalue)
                local vehicle_detected = GetVehicleInView(cam)
                if DoesEntityExist(vehicle_detected) then
                    vehicle = vehicle_detected 
                end

                HandleZoom(cam)
                HideHUDThisFrame()

                HandleSpotlight(cam)

                BeginScaleformMovieMethod(scaleform, "SET_DISPLAY_CONFIG")
                ScaleformMovieMethodAddParamInt(0)
                ScaleformMovieMethodAddParamInt(0)
                ScaleformMovieMethodAddParamFloat(0.0)
                ScaleformMovieMethodAddParamFloat(0.0)
                ScaleformMovieMethodAddParamFloat(0.0)
                ScaleformMovieMethodAddParamFloat(0.0)
                ScaleformMovieMethodAddParamBool(true)
                ScaleformMovieMethodAddParamBool(true)
                ScaleformMovieMethodAddParamBool(false)
                EndScaleformMovieMethod()

                BeginScaleformMovieMethod(scaleform, "SET_ALT_FOV_HEADING")
                ScaleformMovieMethodAddParamFloat(GetEntityCoords(heli).z)
                ScaleformMovieMethodAddParamFloat(zoomvalue)
                ScaleformMovieMethodAddParamFloat(GetCamRot(cam, 2).z)
                EndScaleformMovieMethod()

                DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255)

                local streetname = GetStreetNameFromHashKey(GetStreetNameAtCoord(playerCoord.x,playerCoord.y,playerCoord.z))
                local roadHashNearHeli

                if vehicle == nil then
                    SendNUIMessage({
                        type = "update",
                        info = {
                            fov = fov,
                            numPlate = "",
                            vehRoadName = "",
                            acftRoadName = streetname,
                            acftHeading = ((Citizen.InvokeNative( 0x837765A25378F0BB, 0, Citizen.ResultAsVector()).z + 360.0) % 360.0),
                            heading = GetCamRot(cam, 2).z,
                            vehHeading = -1,
                            altitude = GetEntityHeight(playerPed, playerCoord.x,playerCoord.y,playerCoord.z, true,true),
                            altitudeAGL = GetEntityHeightAboveGround(playerPed),
                            locked = not not locked_on_vehicle,
                            camtype = vision_state,
                            speed = "",
                            spotlight = spotlight_state
                        }
                    })
                else
                    local vehicleCoords = GetEntityCoords(vehicle)
                    local vehstreetname = GetStreetNameFromHashKey(GetStreetNameAtCoord(vehicleCoords.x,vehicleCoords.y,vehicleCoords.z))

                    local vehspd = ""

                    if useMilesPerHour then
                        vehspd = string.format("%." .. (numDecimalPlaces or 0) .. "f", GetEntitySpeed(vehicle) * 2.236936) .." mph"
                    else
                        vehspd = string.format("%." .. (numDecimalPlaces or 0) .. "f",GetEntitySpeed(vehicle) * 3.6) .. " kmh"
                    end

                    SendNUIMessage({
                        type = "update",
                        info = {
                            fov = fov,
                            numPlate = GetVehicleNumberPlateText(vehicle),
                            vehRoadName = vehstreetname,
                            acftRoadName = streetname,
                            acftHeading = ((Citizen.InvokeNative( 0x837765A25378F0BB, 0, Citizen.ResultAsVector()).z + 360.0) % 360.0),
                            heading = RotAnglesToVec(GetCamRot(cam, 2)).z,
                            vehHeading = GetEntityHeading(vehicle),
                            altitude = GetEntityHeight(heli, playerCoord.x, playerCoord.y, playerCoord.z, true, false),
                            altitudeAGL = GetEntityHeightAboveGround(playerPed),
                            locked = not not locked_on_vehicle,
                            camtype = vision_state,
                            speed = vehspd,
                            spotlight = spotlight_state
                        }
                    })
                end

                Citizen.Wait(0)
            end
            helicam = false
            fov = (fov_max + fov_min) * 0.5 -- reset to starting zoom level
            RenderScriptCams(false, false, 0, 1, 0) -- Return to gameplay camera
            SetScaleformMovieAsNoLongerNeeded(scaleform) -- Cleanly release the scaleform
            DestroyCam(cam, false)
            SetNightvision(false)
            SetSeethrough(false)
            SendNUIMessage({type = "hide"})
            vision_state = 0
            spotlight_state = false
        end
        Citizen.Wait(time)
    end
end)

function IsPlayerInPolmav()
    local inPoliceHeli = false
    local vehicle = GetVehiclePedIsIn(PlayerPedId())
    for i=1, #policeVehicles do
        if IsVehicleModel(vehicle, policeVehicles[i]) then
            inPoliceHeli = true
            break
        end
    end
    return inPoliceHeli
end

function IsHeliHighEnough(heli)
    return GetEntityHeightAboveGround(heli) > minHeightAboveGround
end

function ChangeVision()
    if termal then
        if vision_state == 0 then
            if GetGameTimer() > lastVisionTime or lastVisionTime == 0 then
                lastVisionTime = GetGameTimer() + 30000
                SetNightvision(false)
                SetSeethrough(true)
                vision_state = 1
                Citizen.CreateThread(function()
                    Citizen.Wait(5500)
                    SetNightvision(false)
                    SetSeethrough(false)
                    vision_state = 0
                end)
            else
                QBCore.Functions.Notify("Installing Thermal Vision "..QBCore.Shared.Round( (lastVisionTime - GetGameTimer()) / 1000 ).."sec Exists!", "error")
                SetNightvision(false)
                SetSeethrough(false)
                vision_state = 0
            end
        else
            SetNightvision(false)
            SetSeethrough(false)
            vision_state = 0
        end
    else
        if vision_state == 0 then
            SetNightvision(true)
            vision_state = 1
        elseif vision_state == 1 then
            SetNightvision(false)
            vision_state = 0
        end
    end
end

function HideHUDThisFrame()
    HideHelpTextThisFrame()
    HideHudAndRadarThisFrame()
    HideHudComponentThisFrame(1) -- Wanted Stars
    HideHudComponentThisFrame(2) -- Weapon icon
    HideHudComponentThisFrame(3) -- Cash
    HideHudComponentThisFrame(4) -- MP CASH
    HideHudComponentThisFrame(7) -- Area Name
    HideHudComponentThisFrame(8) -- Vehicle Class
    HideHudComponentThisFrame(9) -- Street Name
    HideHudComponentThisFrame(11) -- Floating Help Text
    HideHudComponentThisFrame(12) -- more floating help text
    HideHudComponentThisFrame(13) -- Cash Change
    HideHudComponentThisFrame(15) -- Subtitle Text
    HideHudComponentThisFrame(18) -- Game Stream
    HideHudComponentThisFrame(19) -- weapon wheel
    HideHudComponentThisFrame(21) -- weapon wheel
end

function CheckInputRotation(cam, zoomvalue)
    local rightAxisX = GetDisabledControlNormal(0, 220)
    local rightAxisY = GetDisabledControlNormal(0, 221)
    local rotation = GetCamRot(cam, 2)
    if rightAxisX ~= 0.0 or rightAxisY ~= 0.0 then
        new_z = rotation.z + rightAxisX * -1.0 * (speed_ud) * (zoomvalue + 0.1)
        new_x = math.max(math.min(20.0, rotation.x + rightAxisY * -1.0 * (speed_lr) * (zoomvalue + 0.1)), -89.5) -- Clamping at top (cant see top of heli) and at bottom (doesn't glitch out in -90deg)
        SetCamRot(cam, new_x, 0.0, new_z, 2)
    end
end

function HandleZoom(cam)
    if IsControlJustReleased(0, 241) then -- Scrollup
        fov = math.max(fov - zoomspeed, fov_min)
    elseif IsControlJustReleased(0, 242) then
        fov = math.min(fov + zoomspeed, fov_max) -- ScrollDown
    end

    local current_fov = GetCamFov(cam)
    if math.abs(fov - current_fov) < 0.1 then -- the difference is too small, just set the value directly to avoid unneeded updates to FOV of order 10^-5
        fov = current_fov
    end
    SetCamFov(cam, current_fov + (fov - current_fov) * 0.05) -- Smoothing of camera zoom
end

function GetVehicleInView(cam)
    local coords = GetCamCoord(cam)
    local forward_vector = RotAnglesToVec(GetCamRot(cam, 2))
    local rayhandle = StartShapeTestRay(coords, coords + (forward_vector * 350.0), 10, GetVehiclePedIsIn(PlayerPedId()), 0)
    local _, _, _, _, entityHit = GetShapeTestResult(rayhandle)
    if entityHit > 0 and IsEntityAVehicle(entityHit) then
        return entityHit
    else
        return nil
    end
end


function HandleSpotlight(cam)
    if spotlight_state then
        local rotation = GetCamRot(cam, 2)
        local forward_vector = RotAnglesToVec(rotation)
        local camcoords = GetCamCoord(cam)
        DrawSpotLight(camcoords, forward_vector, 255, 255, 255, 300.0, 0.5, 0.5, 7.50, 75.0)
        TriggerServerEvent("heli:spotlight_update", currentPlayerId, {
            comcoords = camcoords,
            forward_vector = forward_vector
        })
    end
end

local spotlights = {}
Citizen.CreateThread(function()
    while true do
        local time = 100
        for key, value in pairs(spotlights) do
            if value.enabled and key ~= currentPlayerId and value.camcoords ~= nil and value.forward_vector ~= nil then
                time = 1
                DrawSpotLight(value.camcoords, value.forward_vector, 255, 255, 255, 300.0, 0.5, 0.5, 7.50, 75.0)
            end
        end
        Citizen.Wait(time)
    end
end)

RegisterNetEvent("heli:spotlight_on")
AddEventHandler("heli:spotlight_on", function(playerId)
    spotlights[tostring(playerId)] = {
        camcoords = nil,
        forward_vector = nil,
        enabled = true
    }
end)

RegisterNetEvent("heli:spotlight_off")
AddEventHandler("heli:spotlight_off", function(playerId) 
    spotlights[tostring(playerId)] = nil
end)

RegisterNetEvent("heli:spotlight_update")
AddEventHandler("heli:spotlight_update", function(playerId, data)
    spotlights[tostring(playerId)].camcoords = data.comcoords;
    spotlights[tostring(playerId)].forward_vector = data.forward_vector;
end)

function RotAnglesToVec(rot) -- input vector3
    local z = math.rad(rot.z)
    local x = math.rad(rot.x)
    local num = math.abs(math.cos(x))
    return vector3(-math.sin(z) * num, math.cos(z) * num, math.sin(x))
end
