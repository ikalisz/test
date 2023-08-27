Citizen.CreateThread(function()
    local resourceName = GetCurrentResourceName()
    local leftShoulderCamActive = false
    local leftShoulderCamThreadActive = false
    local leftShoulderCam = false
    local function createLeftShoulderCam()
        if leftShoulderCam and DoesCamExist(leftShoulderCam) then
            DestroyCam(leftShoulderCam)
        end
        leftShoulderCam = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
    end

    local function toggleLeftShoulderCam()
        leftShoulderCamActive = not leftShoulderCamActive
        if leftShoulderCamActive then
            createLeftShoulderCam()
            RenderScriptCams(true, true, 100, false, false)
            if not leftShoulderCamThreadActive then
                leftShoulderCamThreadActive = true
                Citizen.CreateThreadNow(function()
                    while leftShoulderCamActive do
                        if DoesCamExist(leftShoulderCam) and GetFollowPedCamViewMode() ~= 4 and IsPlayerFreeAiming(PlayerId()) then
                            local cameraCoords = GetGameplayCamCoord()
                            local cameraRotation = GetGameplayCamRot(0)
                            local cameraFov = GetGameplayCamFov()
                            local playerPed = PlayerPedId()
                            local coordsRelativeToPlayer = GetOffsetFromEntityGivenWorldCoords(playerPed, cameraCoords.x, cameraCoords.y, cameraCoords.z)
                            local xOffset = (coordsRelativeToPlayer.x * 2.3) * 0.8
                            local leftShoulderCoords = GetOffsetFromEntityInWorldCoords(playerPed, coordsRelativeToPlayer.x - xOffset, coordsRelativeToPlayer.y, coordsRelativeToPlayer.z)
                            SetCamCoord(leftShoulderCam, leftShoulderCoords, leftShoulderCoords.y, leftShoulderCoords.z)
                            SetCamRot(leftShoulderCam, cameraRotation.x, cameraRotation.y, cameraRotation.z, 0)
                            SetCamFov(leftShoulderCam, cameraFov)
                        else
                            toggleLeftShoulderCam()
                            break
                        end
                        Citizen.Wait(0)
                    end
                    leftShoulderCamThreadActive = false
                end)
            end
        else
            if DoesCamExist(leftShoulderCam) then
                DestroyCam(leftShoulderCam)
            end

            RenderScriptCams(false, true, 100, false, false)
        end
    end

    RegisterCommand("shoulder_swap", function()
        if GetFollowPedCamViewMode() ~= 4 and IsPlayerFreeAiming(PlayerId()) then
            toggleLeftShoulderCam()
        end
    end, false)

    AddEventHandler("onResourceStop", function(pResourceName)
        if pResourceName == resourceName and leftShoulderCamActive then
            toggleLeftShoulderCam()
        end
    end)
    RegisterKeyMapping("shoulder_swap", "Point of view", "keyboard", "H")
end)