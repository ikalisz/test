local fov_max = 70.0
local fov_min = 5.0 -- max zoom level (smaller fov is more zoom)
local zoomspeed = 10.0 -- camera zoom speed
local speed_lr = 8.0 -- speed by which the camera pans left-right
local speed_ud = 8.0 -- speed by which the camera pans up-down
local binoculars = false
local fov = (fov_max+fov_min)*0.5
local storeBinoclarKey = 177
local kullanilanZirh = false

QBCore = nil
Citizen.CreateThread(function()
    while QBCore == nil do
        TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)
        Citizen.Wait(200)
    end
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    PlayerData = QBCore.Functions.GetPlayerData()
end)

RegisterNetEvent('armor')
AddEventHandler('armor', function()
    if not kullanilanZirh then
        local ped = PlayerPedId()
        if GetPedArmour(ped) == 100 then
            QBCore.Functions.Notify('Armorun is already full!')
            return
        end

        TriggerServerEvent("delete-item", 'armor')
        QBCore.Functions.Progressbar("armorX"," Steel vest is being worn...", 15000, false, true, { -- p1: menu name, p2: yazı, p3: ölü iken kullan, p4:iptal edilebilir
            disableMovement = false,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        }, {
            animDict = "missmic4",
            anim = "michael_tux_fidget",
            flags = 49,
        }, {}, {}, function() -- Done
            SetPedArmour(ped, 100)
            QBCore.Functions.Notify('You wear heavy steel vests.')
            kullanilanZirh = true
        end, function() -- Cancel
            TriggerServerEvent("give-item", 'armor', QBCore.Key)
        end)

    else
        QBCore.Functions.Notify('You cant wear so many armor')
    end
end)



Citizen.CreateThread(function ()
	while true do
	    Citizen.Wait(1)
        if kullanilanZirh then
            Citizen.Wait(60000) -- 10 dakika
			kullanilanZirh = false
		end 
	end
end)

RegisterNetEvent('binoculars')
AddEventHandler('binoculars', function() 
    local ped = PlayerPedId()
    binoculars = true
    if not ( IsPedSittingInAnyVehicle( ped ) ) then
        Citizen.CreateThread(function()
            TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_BINOCULARS", 0, 1)
            PlayAmbientSpeech1(PlayerPedId(), "GENERIC_CURSE_MED", "SPEECH_PARAMS_FORCE")
        end)
    end

    Wait(2000)

    SetTimecycleModifier("default")

    SetTimecycleModifierStrength(0.3)

    local scaleform = RequestScaleformMovie("BINOCULARS")

    while not HasScaleformMovieLoaded(scaleform) do
        Citizen.Wait(0)
    end

    local vehicle = GetVehiclePedIsIn(ped)
    local cam = CreateCam("DEFAULT_SCRIPTED_FLY_CAMERA", true)

    AttachCamToEntity(cam, ped, 0.0,0.0,1.0, true)
    SetCamRot(cam, 0.0,0.0,GetEntityHeading(ped))
    SetCamFov(cam, fov)
    RenderScriptCams(true, false, 0, 1, 0)
    PushScaleformMovieFunction(scaleform, "SET_CAM_LOGO")
    PushScaleformMovieFunctionParameterInt(0) -- 0 for nothing, 1 for LSPD logo
    PopScaleformMovieFunctionVoid()
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
        if IsControlJustPressed(0, storeBinoclarKey) then -- Toggle binoculars
            PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)
            ClearPedTasks(PlayerPedId())
            binoculars = false
        end

        local zoomvalue = (1.0/(fov_max-fov_min))*(fov-fov_min)
        CheckInputRotation(cam, zoomvalue)

        HandleZoom(cam)
        HideHUDThisFrame()

        DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255)
        Citizen.Wait(0)
    end

    binoculars = false
    ClearTimecycleModifier()
    fov = (fov_max+fov_min)*0.5
    RenderScriptCams(false, false, 0, 1, 0)
    SetScaleformMovieAsNoLongerNeeded(scaleform)
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
        new_z = rotation.z + rightAxisX*-1.0*(speed_ud)*(zoomvalue+0.1)
        new_x = math.max(math.min(20.0, rotation.x + rightAxisY*-1.0*(speed_lr)*(zoomvalue+0.1)), -89.5)
        SetCamRot(cam, new_x, 0.0, new_z, 2)
    end
end

function HandleZoom(cam)
    local lPed = PlayerPedId()
    if not IsPedSittingInAnyVehicle(lPed) then

        if IsControlJustPressed(0,241) then -- Scrollup
            fov = math.max(fov - zoomspeed, fov_min)
        end
        if IsControlJustPressed(0,242) then
            fov = math.min(fov + zoomspeed, fov_max) -- ScrollDown
        end
        local current_fov = GetCamFov(cam)
        if math.abs(fov-current_fov) < 0.1 then
            fov = current_fov
        end
        SetCamFov(cam, current_fov + (fov - current_fov)*0.05)
    else
        if IsControlJustPressed(0,17) then -- Scrollup
            fov = math.max(fov - zoomspeed, fov_min)
        end
        if IsControlJustPressed(0,16) then
            fov = math.min(fov + zoomspeed, fov_max) -- ScrollDown
        end
        local current_fov = GetCamFov(cam)
        if math.abs(fov-current_fov) < 0.1 then -- the difference is too small, just set the value directly to avoid unneeded updates to FOV of order 10^-5
            fov = current_fov
        end
        SetCamFov(cam, current_fov + (fov - current_fov)*0.05) -- Smoothing of camera zoom
    end
end

CreateThread(function()-- https://docs.fivem.net/natives/?_0x6806C51AD12B83B8
    while true do
		HideHudComponentThisFrame(1) -- 1 : WANTED_STARS
		HideHudComponentThisFrame(2) -- 2 : WEAPON_ICON
		HideHudComponentThisFrame(3) -- 3 : CASH
		HideHudComponentThisFrame(4) -- 4 : MP_CASH
		-- HideHudComponentThisFrame(5)			-- 5 : MP_MESSAGE
		-- HideHudComponentThisFrame(6)			-- 6 : VEHICLE_NAME
		HideHudComponentThisFrame(7) -- 7 : AREA_NAME
		-- HideHudComponentThisFrame(8)			-- 8 : VEHICLE_CLASS
		HideHudComponentThisFrame(9) -- 9 : STREET_NAME
		-- HideHudComponentThisFrame(10)		-- 10 : HELP_TEXT
		-- HideHudComponentThisFrame(11)		-- 11 : FLOATING_HELP_TEXT_1
		-- HideHudComponentThisFrame(12)		-- 12 : FLOATING_HELP_TEXT_2
		HideHudComponentThisFrame(13) -- 13 : CASH_CHANGE
		HideHudComponentThisFrame(14) -- 14 : RETICLE
		-- HideHudComponentThisFrame(15)		-- 15 : SUBTITLE_TEXT
		-- HideHudComponentThisFrame(16)		-- 16 : RADIO_STATIONS
		HideHudComponentThisFrame(17) -- 17 : SAVING_GAME
		-- HideHudComponentThisFrame(18)		-- 18 : GAME_STREAM
		HideHudComponentThisFrame(19) -- 19 : WEAPON_WHEEL
		HideHudComponentThisFrame(20) -- 20 : WEAPON_WHEEL_STATS
		HideHudComponentThisFrame(21) -- 21 : HUD_COMPONENTS
		HideHudComponentThisFrame(22) -- 22 : HUD_WEAPONS
		DisableControlAction(1, 37)
		DisplayAmmoThisFrame(true)

		Wait(4)
    end
end)
