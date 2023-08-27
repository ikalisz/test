local mp_pointing = false
local keyPressed = false

local function startPointing()
    RequestAnimDict("anim@mp_point")
    while not HasAnimDictLoaded("anim@mp_point") do
        Wait(0)
    end
    SetPedCurrentWeaponVisible(playerPed, 0, 1, 1, 1)
    SetPedConfigFlag(playerPed, 36, 1)
    TaskMoveNetworkByName(playerPed, "task_mp_pointing", 0.5, 0, "anim@mp_point", 24)
    RemoveAnimDict("anim@mp_point")
end

local function stopPointing()
    RequestTaskMoveNetworkStateTransition(playerPed, "Stop")
    if not IsPedInjured(playerPed) then
        ClearPedSecondaryTask(playerPed)
    end
    if not IsPedInAnyVehicle(playerPed, 1) then
        SetPedCurrentWeaponVisible(playerPed, 1, 1, 1, 1)
    end
    SetPedConfigFlag(playerPed, 36, 0)
    ClearPedSecondaryTask(playerPed)
end


local oldval = false
local oldvalped = false

Citizen.CreateThread(function()
    while true do
        local time = 50
        if not keyPressed then
            if IsControlPressed(0, 29) and not mp_pointing and IsPedOnFoot(playerPed) and not IsPedArmed(playerPed, 6) then
                Wait(200)
                if not IsControlPressed(0, 29) then
                    keyPressed = true
                    startPointing()
                    mp_pointing = true
                else
                    keyPressed = true
                    while IsControlPressed(0, 29) do
                        Wait(50)
                    end
                end
            elseif (IsControlPressed(0, 29) and mp_pointing) or (not IsPedOnFoot(playerPed) and mp_pointing) then
                keyPressed = true
                mp_pointing = false
                stopPointing()
            end
        else
            if not IsControlPressed(0, 29) then
                keyPressed = false
            end
        end

        if IsTaskMoveNetworkActive(playerPed) and not mp_pointing then
            stopPointing()
        end
        if IsTaskMoveNetworkActive(playerPed) then
            time = 1
            if not IsPedOnFoot(playerPed) then
                stopPointing()
            else
                local camPitch = GetGameplayCamRelativePitch()
                if camPitch < -70.0 then
                    camPitch = -70.0
                elseif camPitch > 42.0 then
                    camPitch = 42.0
                end
                camPitch = (camPitch + 70.0) / 112.0

                local camHeading = GetGameplayCamRelativeHeading()
                local cosCamHeading = Cos(camHeading)
                local sinCamHeading = Sin(camHeading)
                if camHeading < -180.0 then
                    camHeading = -180.0
                elseif camHeading > 180.0 then
                    camHeading = 180.0
                end
                camHeading = (camHeading + 180.0) / 360.0

                local blocked = 0
                local nn = 0

                local coords = GetOffsetFromEntityInWorldCoords(playerPed, (cosCamHeading * -0.2) - (sinCamHeading * (0.4 * camHeading + 0.3)), (sinCamHeading * -0.2) + (cosCamHeading * (0.4 * camHeading + 0.3)), 0.6)
                local ray = Cast_3dRayPointToPoint(coords.x, coords.y, coords.z - 0.2, coords.x, coords.y, coords.z + 0.2, 0.4, 95, playerPed, 7);
                nn,blocked,coords,coords = GetRaycastResult(ray)

                SetTaskMoveNetworkSignalFloat(playerPed, "Pitch", camPitch)
                SetTaskMoveNetworkSignalFloat(playerPed, "Heading", camHeading * -1.0 + 1.0)
                SetTaskMoveNetworkSignalBool(playerPed, "isBlocked", blocked)
                SetTaskMoveNetworkSignalBool(playerPed, "isFirstPerson", Citizen.InvokeNative(0xEE778F8C7E1142E2, Citizen.InvokeNative(0x19CAFA3C87F7C2FF)) == 4)

            end
        end
        Citizen.Wait(time)
    end
end)