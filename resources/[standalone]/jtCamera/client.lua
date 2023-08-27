QBCore = nil

Citizen.CreateThread(function() 
    while QBCore == nil do
        TriggerEvent("QBCore:GetObject", function(obj) QBCore = obj end)    
        Citizen.Wait(200)
    end
end)

local fov, binoculars, cekilenEsgal = (70.0+5.0)*0.5, false, false

Citizen.CreateThread(function()
	while true do
	    Citizen.Wait(1)
        if cekilenEsgal then
            Citizen.Wait(5000) -- 5 sn
			cekilenEsgal = false
		end 
	end
end)

RegisterNUICallback('Notify', function(data, cb)
    QBCore.Functions.Notify(data.message, data.type)
end)

RegisterNetEvent('foto:client:kullankamera')
AddEventHandler('foto:client:kullankamera', function() 
    local ped = PlayerPedId()
    binoculars = true
    if not ( IsPedSittingInAnyVehicle( ped ) ) then
        Citizen.CreateThread(function()
            TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_PAPARAZZI", 0, 1)
            PlayAmbientSpeech1(PlayerPedId(), "GENERIC_CURSE_MED", "SPEECH_PARAMS_FORCE")
        end)
    end

    Wait(2000)

    SetTimecycleModifier("default")

    SetTimecycleModifierStrength(0.3)

    local scaleform = RequestScaleformMovie("security_cam")

    -- while not HasScaleformMovieLoaded(scaleform) do
    --     Citizen.Wait(0)
    -- end

    local vehicle = GetVehiclePedIsIn(ped)
    local cam = CreateCam("DEFAULT_SCRIPTED_FLY_CAMERA", true)

    AttachCamToEntity(cam, ped, 0.0,0.0,1.0, true)
    SetCamRot(cam, 0.0,0.0,GetEntityHeading(ped))
    SetCamFov(cam, fov)
    RenderScriptCams(true, false, 0, 1, 0)
    -- PushScaleformMovieFunction(scaleform, "SET_CAM_LOGO")
    -- PushScaleformMovieFunctionParameterString("Grand Roleplay")
    -- PushScaleformMovieFunctionParameterInt(0) -- 0 for nothing, 1 for LSPD logo
    -- PopScaleformMovieFunctionVoid()
    DisableControlAction(0, 69, true) -- INPUT_VEH_ATTACK
    DisableControlAction(0, 92, true) -- INPUT_VEH_PASSENGER_ATTACK
    DisableControlAction(0, 114, true) -- INPUT_VEH_FLY_ATTACK
    DisableControlAction(0, 140, true) -- INPUT_MELEE_ATTACK_LIGHT
    DisableControlAction(0, 141, true) -- INPUT_MELEE_ATTACK_HEAVY
    DisableControlAction(0, 142, true) -- INPUT_MELEE_ATTACK_ALTERNATE
    DisableControlAction(0, 257, true) -- INPUT_ATTACK2
    DisableControlAction(0, 263, true) -- INPUT_MELEE_ATTACK1
    DisableControlAction(0, 264, true) -- INPUT_MELEE_ATTACK2
    DisableControlAction(0, 24, true) -- INPUT_ATTACK
    DisableControlAction(0, 25, true) -- INPUT_AIM
    DisableControlAction(0, 50, true) -- INPUT_AIM
    DisableControlAction(0, 99, true) -- INPUT_AIM

    while binoculars and not IsEntityDead(ped) and (GetVehiclePedIsIn(ped) == vehicle) and true do
        if IsControlJustPressed(0, 177) then -- Toggle binoculars
            PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)
            ClearPedTasks(PlayerPedId())
            binoculars = false
        elseif IsControlJustPressed(0, 18) then 
            if not cekilenEsgal then
                TriggerEvent('foto:client:foticek')
                Wait(2000)
                 cekilenEsgal = true
             else
                 QBCore.Functions.Notify('Photo Camera Will Burn Slow La!', 'error')
             end
        end

        local zoomvalue = (1.0/(70.0-5.0))*(fov-5.0)
        CheckInputRotation(cam, zoomvalue)

        HandleZoom(cam)
        HideHUDThisFrame()

        --DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255)
        Citizen.Wait(0)
    end

    binoculars = false
    ClearTimecycleModifier()
    fov = (70.0+5.0)*0.5
    RenderScriptCams(false, false, 0, 1, 0)
    --SetScaleformMovieAsNoLongerNeeded(scaleform)
    DestroyCam(cam, false)
    SetNightvision(false)
    SetSeethrough(false)
end)

function table.includes(table, element)
    for _, value in pairs(table) do
        if value == element then
            return true
        end
    end
    return false
end

function HideHUDThisFrame()
    HideHelpTextThisFrame()
    HideHudAndRadarThisFrame()
    HideHudComponentThisFrame(1) -- Wanted Stars
    HideHudComponentThisFrame(2) -- Weapon icon
    HideHudComponentThisFrame(3) -- Cash
    HideHudComponentThisFrame(4) -- MP CASH
    HideHudComponentThisFrame(6)
    HideHudComponentThisFrame(7)
    HideHudComponentThisFrame(8)
    HideHudComponentThisFrame(9)
    HideHudComponentThisFrame(13) -- Cash Change
    HideHudComponentThisFrame(11) -- Floating Help Text
    HideHudComponentThisFrame(12) -- more floating help text
    HideHudComponentThisFrame(15) -- Subtitle Text
    HideHudComponentThisFrame(18) -- Game Stream
    HideHudComponentThisFrame(19) -- weapon wheel
end

function CheckInputRotation(cam, zoomvalue)
    local rightAxisX = GetDisabledControlNormal(0, 220)
    local rightAxisY = GetDisabledControlNormal(0, 221)
    local rotation = GetCamRot(cam, 2)
    if rightAxisX ~= 0.0 or rightAxisY ~= 0.0 then
        new_z = rotation.z + rightAxisX*-1.0*(8.0)*(zoomvalue+0.1)
        new_x = math.max(math.min(20.0, rotation.x + rightAxisY*-1.0*(8.0)*(zoomvalue+0.1)), -89.5)
        SetCamRot(cam, new_x, 0.0, new_z, 2)
    end
end

function HandleZoom(cam)
    local lPed = PlayerPedId()
    if not IsPedSittingInAnyVehicle(lPed) then

        if IsControlJustPressed(0,241) then -- Scrollup
            fov = math.max(fov - 10.0, 5.0)
        end
        if IsControlJustPressed(0,242) then
            fov = math.min(fov + 10.0, 70.0) -- ScrollDown
        end
        local current_fov = GetCamFov(cam)
        if math.abs(fov-current_fov) < 0.1 then
            fov = current_fov
        end
        SetCamFov(cam, current_fov + (fov - current_fov)*0.05)
    else
        if IsControlJustPressed(0,17) then -- Scrollup
            fov = math.max(fov - 10.0, 5.0)
        end
        if IsControlJustPressed(0,16) then
            fov = math.min(fov + 10.0, 70.0) -- ScrollDown
        end
        local current_fov = GetCamFov(cam)
        if math.abs(fov-current_fov) < 0.1 then -- the difference is too small, just set the value directly to avoid unneeded updates to FOV of order 10^-5
            fov = current_fov
        end
        SetCamFov(cam, current_fov + (fov - current_fov)*0.05) -- Smoothing of camera zoom
    end
end

RegisterNetEvent('foto:client:fotocek')
AddEventHandler('foto:client:foticek', function()
    local url = exports['elixir-base']:screenShot()
    SendNUIMessage({ preview = url })
    TriggerServerEvent('foto:server:fotiekle', url)
    QBCore.Functions.Notify("Photo was taken. You can exit the camera screen with the right mouse button..", "primary")
end)

RegisterNetEvent('foto:client:kullanfoti')
AddEventHandler('foto:client:kullanfoti', function(aciklama)
    SendNUIMessage({ photo = aciklama })
    SetNuiFocus(true, true)
end)

RegisterNUICallback('closeZoomImage', function()
    SetNuiFocus(false, false)
end)

