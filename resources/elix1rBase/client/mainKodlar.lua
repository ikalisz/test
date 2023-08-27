PlayerData = {}
QBCore = nil

playerId = PlayerId()
playerPed = PlayerPedId()
playerPedCoords = GetEntityCoords(playerPed)
inVehicle = IsPedInAnyVehicle(playerPed)
veh = GetVehiclePedIsIn(playerPed)
playerLoaded = false
eventOn = false

local blips = {
    {title="Hunting Products Sales", colour=21, id=141, scale=0.8 ,coords = vector3(1321.006, 4314.666, 38.146)},
        {title="Recycling Products", colour=69, id=365, scale=0.8 ,coords = vector3(960.9758, -1586.44, 30.367)},
        {title="Mine Sales", colour=5, id=205, scale=0.6 ,coords = vector3(270.2687, -3076.67, 5.7742)},
        {title="Wood Sales", colour=5, id=280, scale=0.6 ,coords =  vector3(854.33, -2113.3, 31.58)},
        {title="Wood Processing", colour=1, id=440, scale=0.6 ,coords =  vector3(-554.33, 5328.3, 73.58)},     
        {title="Businesses", colour=1, id=186, scale=0.7 ,coords = vector3(-70.9276, -801.079, 44.227)},
        {title="Grape Picking", colour=50, id=57, scale=0.5 ,coords = vector3(-1903.8, 2141.39, 119.72)},
        {title="Grape Boxing", colour=1, id=478, scale=0.6 ,coords = vector3(-1928.57, 2060.34, 140.84)},
        {title="Grape Sales", colour=0, id=277, scale=0.8 ,coords = vector3(1220.91, -3005.29, 5.87)},
        {title="Central bank", colour=43, id=500, scale=0.8 ,coords = vector3(246.94, 221.52, 106.28)},
    }
    
    Citizen.CreateThread(function()
      for _, info in pairs(blips) do
        info.blip = AddBlipForCoord(info.coords.x, info.coords.y, info.coords.z)
        SetBlipSprite(info.blip, info.id)
        SetBlipDisplay(info.blip, 4)
        SetBlipScale(info.blip, info.scale)
        SetBlipColour(info.blip, info.colour)
        SetBlipAsShortRange(info.blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(info.title)
        EndTextCommandSetBlipName(info.blip)
      end
    end)

local isDead = false
local lastMovementClipset = nil
local crouched = false
local FPSkullan = false

Citizen.CreateThread(function() 
    while QBCore == nil do
        TriggerEvent("QBCore:GetObject", function(obj) QBCore = obj end)    
        Citizen.Wait(200)
    end
end)


Citizen.CreateThread(function() 
    while true do
        playerId = PlayerId()
        playerPed = PlayerPedId()
        playerPedCoords = GetEntityCoords(playerPed)
        inVehicle = IsPedInAnyVehicle(playerPed)
        veh = GetVehiclePedIsIn(playerPed)
        Citizen.Wait(1000)
    end
end)



RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    PlayerData = QBCore.Functions.GetPlayerData()
end)



RegisterNetEvent("QBCore:Client:OnPlayerLoaded", function()
    local playerPed = PlayerPedId()
    if IsPedArmed(playerPed, 7) then 
        TriggerServerEvent("tgiann-hackkoruma:kick", "", "you go away :)) Looserr!")
    else
        return
    end
end)

RegisterNetEvent('QBCore:Player:SetPlayerData')
AddEventHandler('QBCore:Player:SetPlayerData', function(data)
	PlayerData = data
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate')
AddEventHandler('QBCore:Client:OnJobUpdate', function(job)
    PlayerData.job = job
end)

-- çift kamera açısı
CreateThread(function() 
    local setpov = false
    local time = 3000
    while true do
        DisableControlAction(0, 0, true) -- Controlkey "V"
        local PlayerPed = PlayerPedId()
        local VehicleCurrentCamViewMode = GetFollowVehicleCamViewMode(PlayerPed) -- src https://runtime.fivem.net/doc/natives/?_0xAC253D7842768F48
            if IsPedInAnyVehicle(PlayerPed) then -- When in Vehicle
                time = 3000
                if not setpov and IsDisabledControlJustPressed(0, 0) then
                    time = 10
                    setpov = true
                    SetFollowVehicleCamViewMode(4) -- First Person View
                elseif setpov and IsDisabledControlJustPressed(0, 0) then
                    time = 10
                    setpov = false
                    SetFollowVehicleCamViewMode(0) -- Third Person View Close
                end
            elseif not IsPedInAnyVehicle(PlayerPed2) then -- When on foot
                time = 10
                local CurrentCamViewMode = GetFollowPedCamViewMode(PlayerPed)
            if not setpov and IsDisabledControlJustPressed(0, 0) then
                setpov = true
                SetFollowPedCamViewMode(4)
            elseif setpov and IsDisabledControlJustPressed(0, 0) then
                time = 10
                setpov = false
                SetFollowPedCamViewMode(0)
            end
        end
        Wait(time)
    end
end)

-- Ateş ederken fpp geçirme

-- 1. şahıs
local shot = false
local check = false
local check2 = false
local count = 0

CreateThread(function()
    local time = 2500
    while true do
        if IsPlayerFreeAiming(PlayerId()) then
            time = 1000
            if GetFollowPedCamViewMode() == 4 and check == false then
                time = 100
                check = false
            else
                time = 1
                SetFollowVehicleCamViewMode(4)
                check = true
            end
        else
            if check == true then
                time = 1
                SetFollowVehicleCamViewMode(1)
                check = false
            end
        end
        Wait(time)
    end
end)

CreateThread(function()
    local time = 3000
    while true do
        if IsPedShooting(PlayerPedId()) and shot == false and GetFollowPedCamViewMode() ~= 4 then
            time = 1
            check2 = true
            shot = true
            SetFollowVehicleCamViewMode(4)
        end
        if IsPedShooting(PlayerPedId()) and shot == true and GetFollowPedCamViewMode() == 4 then
            time = 1
            count = 0
        end
        if not IsPedShooting(PlayerPedId()) and shot == true then
            time = 1
            count = count + 1
        end
        if not IsPedShooting(PlayerPedId()) and shot == true then
            if not IsPedShooting(PlayerPedId()) and shot == true and count > 20 then
                if check2 == true then
                    time = 20
                    check2 = false
                    shot = false
                    SetFollowVehicleCamViewMode(1)
                end
            end
        end
        Wait(time)
    end
end)

-- roll Prevention
CreateThread(function()
    while true do
        if (not IsPedInAnyVehicle(PlayerPedId(),false)) then
            Wait(10)
            if IsPlayerFreeAiming(PlayerPedId()) then
                DisableControlAction(0, 22, 1)
            else
                Wait(200)
            end
        else
            Wait(700)
        end
    end
end)

--NPC Polis Telsiz Sesi ve Trenleri Kapatır
CreateThread(function()
    CancelCurrentPoliceReport()
    DistantCopCarSirens(false)
    SwitchTrainTrack(0, true)   
    SwitchTrainTrack(3, true)   
    SetRandomTrains(1)
    
    -- Yerden silah alma kapatma
    local pickupList = {"PICKUP_AMMO_BULLET_MP","PICKUP_AMMO_FIREWORK","PICKUP_AMMO_FLAREGUN","PICKUP_AMMO_GRENADELAUNCHER","PICKUP_AMMO_GRENADELAUNCHER_MP","PICKUP_AMMO_HOMINGLAUNCHER","PICKUP_AMMO_MG","PICKUP_AMMO_MINIGUN","PICKUP_AMMO_MISSILE_MP","PICKUP_AMMO_PISTOL","PICKUP_AMMO_RIFLE","PICKUP_AMMO_RPG","PICKUP_AMMO_SHOTGUN","PICKUP_AMMO_SMG","PICKUP_AMMO_SNIPER","PICKUP_ARMOUR_STANDARD","PICKUP_CAMERA","PICKUP_CUSTOM_SCRIPT","PICKUP_GANG_ATTACK_MONEY","PICKUP_HEALTH_SNACK","PICKUP_HEALTH_STANDARD","PICKUP_MONEY_CASE","PICKUP_MONEY_DEP_BAG","PICKUP_MONEY_MED_BAG","PICKUP_MONEY_PAPER_BAG","PICKUP_MONEY_PURSE","PICKUP_MONEY_SECURITY_CASE","PICKUP_MONEY_VARIABLE","PICKUP_MONEY_WALLET","PICKUP_PARACHUTE","PICKUP_PORTABLE_CRATE_FIXED_INCAR","PICKUP_PORTABLE_CRATE_UNFIXED","PICKUP_PORTABLE_CRATE_UNFIXED_INCAR","PICKUP_PORTABLE_CRATE_UNFIXED_INCAR_SMALL","PICKUP_PORTABLE_CRATE_UNFIXED_LOW_GLOW","PICKUP_PORTABLE_DLC_VEHICLE_PACKAGE","PICKUP_PORTABLE_PACKAGE","PICKUP_SUBMARINE","PICKUP_VEHICLE_ARMOUR_STANDARD","PICKUP_VEHICLE_CUSTOM_SCRIPT","PICKUP_VEHICLE_CUSTOM_SCRIPT_LOW_GLOW","PICKUP_VEHICLE_HEALTH_STANDARD","PICKUP_VEHICLE_HEALTH_STANDARD_LOW_GLOW","PICKUP_VEHICLE_MONEY_VARIABLE","PICKUP_VEHICLE_WEAPON_APPISTOL","PICKUP_VEHICLE_WEAPON_ASSAULTSMG","PICKUP_VEHICLE_WEAPON_COMBATPISTOL","PICKUP_VEHICLE_WEAPON_GRENADE","PICKUP_VEHICLE_WEAPON_MICROSMG","PICKUP_VEHICLE_WEAPON_MOLOTOV","PICKUP_VEHICLE_WEAPON_PISTOL","PICKUP_VEHICLE_WEAPON_PISTOL50","PICKUP_VEHICLE_WEAPON_SAWNOFF","PICKUP_VEHICLE_WEAPON_SMG","PICKUP_VEHICLE_WEAPON_SMOKEGRENADE","PICKUP_VEHICLE_WEAPON_STICKYBOMB","PICKUP_WEAPON_ADVANCEDRIFLE","PICKUP_WEAPON_APPISTOL","PICKUP_WEAPON_ASSAULTRIFLE","PICKUP_WEAPON_ASSAULTSHOTGUN","PICKUP_WEAPON_ASSAULTSMG","PICKUP_WEAPON_AUTOSHOTGUN","PICKUP_WEAPON_BAT","PICKUP_WEAPON_BATTLEAXE","PICKUP_WEAPON_BOTTLE","PICKUP_WEAPON_BULLPUPRIFLE","PICKUP_WEAPON_BULLPUPSHOTGUN","PICKUP_WEAPON_CARBINERIFLE","PICKUP_WEAPON_COMBATMG","PICKUP_WEAPON_COMBATPDW","PICKUP_WEAPON_COMBATPISTOL","PICKUP_WEAPON_COMPACTLAUNCHER","PICKUP_WEAPON_COMPACTRIFLE","PICKUP_WEAPON_CROWBAR","PICKUP_WEAPON_DAGGER","PICKUP_WEAPON_DBSHOTGUN","PICKUP_WEAPON_FIREWORK","PICKUP_WEAPON_FLAREGUN","PICKUP_WEAPON_FLASHLIGHT","PICKUP_WEAPON_GRENADE","PICKUP_WEAPON_GRENADELAUNCHER","PICKUP_WEAPON_GUSENBERG","PICKUP_WEAPON_GOLFCLUB","PICKUP_WEAPON_HAMMER","PICKUP_WEAPON_HATCHET","PICKUP_WEAPON_HEAVYPISTOL","PICKUP_WEAPON_HEAVYSHOTGUN","PICKUP_WEAPON_HEAVYSNIPER","PICKUP_WEAPON_HOMINGLAUNCHER","PICKUP_WEAPON_KNIFE","PICKUP_WEAPON_KNUCKLE","PICKUP_WEAPON_MACHETE","PICKUP_WEAPON_MACHINEPISTOL","PICKUP_WEAPON_MARKSMANPISTOL","PICKUP_WEAPON_MARKSMANRIFLE","PICKUP_WEAPON_MG","PICKUP_WEAPON_MICROSMG","PICKUP_WEAPON_MINIGUN","PICKUP_WEAPON_MINISMG","PICKUP_WEAPON_MOLOTOV","PICKUP_WEAPON_MUSKET","PICKUP_WEAPON_NIGHTSTICK","PICKUP_WEAPON_PETROLCAN","PICKUP_WEAPON_PIPEBOMB","PICKUP_WEAPON_PISTOL","PICKUP_WEAPON_PISTOL50","PICKUP_WEAPON_POOLCUE","PICKUP_WEAPON_PROXMINE","PICKUP_WEAPON_PUMPSHOTGUN","PICKUP_WEAPON_RAILGUN","PICKUP_WEAPON_REVOLVER","PICKUP_WEAPON_RPG","PICKUP_WEAPON_SAWNOFFSHOTGUN","PICKUP_WEAPON_SMG","PICKUP_WEAPON_SMOKEGRENADE","PICKUP_WEAPON_SNIPERRIFLE","PICKUP_WEAPON_SNSPISTOL","PICKUP_WEAPON_SPECIALCARBINE","PICKUP_WEAPON_STICKYBOMB","PICKUP_WEAPON_STUNGUN","PICKUP_WEAPON_SWITCHBLADE","PICKUP_WEAPON_VINTAGEPISTOL","PICKUP_WEAPON_WRENCH", "PICKUP_WEAPON_RAYCARBINE"}
    for a = 1, #pickupList do
        N_0x616093ec6b139dd9(PlayerId(), GetHashKey(pickupList[a]), false)
    end
end)

-- Oto aim fix
CreateThread(function()
    while true do
        local time = 3500
        if IsPedArmed(playerPed, 4) then
            time = 1
            SetPlayerLockonRangeOverride(playerId, 2.0)
        end
        Wait(time)
    end
end)

-- dipçik engel
CreateThread(function()
    while true do
        local time = 2500
        local ped = GetPlayerPed( -1 )
        local weapon = GetSelectedPedWeapon(ped)
     
        if IsPedArmed(ped, 6) then
            time = 1
            DisableControlAction(1, 140, true)
            DisableControlAction(1, 141, true)
            DisableControlAction(1, 142, true)
        end
     
     
        if weapon == GetHashKey("WEAPON_FIREEXTINGUISHER") then  
            time = 1
            if IsPedShooting(ped) then
                time = 1
                SetPedInfiniteAmmo(ped, true, GetHashKey("WEAPON_FIREEXTINGUISHER"))
            end
        end
        Wait(time)
    end
end)

-- -- NPC Saldırganlık Kaldırma
-- local SaldirganNPC = {
--     "DEALER",
--     "HATES_PLAYER",
--     "NO_RELATIONSHIP",
--     "SPECIAL",
--     "MISSION2",
--     "MISSION3",
--     "MISSION4",
--     "MISSION5",
-- } 

-- Map Zoom, Disable all dispatches
Citizen.CreateThread(function()
    StartAudioScene("CHARACTER_CHANGE_IN_SKY_SCENE"); 
    SetAudioFlag("PoliceScannerDisabled",true);
    SetCreateRandomCops(0) -- disable random cops walking/driving around
    SetCreateRandomCopsNotOnScenarios(false) -- stop random cops (not in a scenario) from spawning
    SetCreateRandomCopsOnScenarios(false) -- stop random cops (in a scenario) from spawning

    SetMapZoomDataLevel(0, 0.96, 0.9, 0.08, 0.0, 0.0) -- Level 0
    SetMapZoomDataLevel(1, 1.6, 0.9, 0.08, 0.0, 0.0) -- Level 1
    SetMapZoomDataLevel(2, 8.6, 0.9, 0.08, 0.0, 0.0) -- Level 2
    SetMapZoomDataLevel(3, 12.3, 0.9, 0.08, 0.0, 0.0) -- Level 3
    SetMapZoomDataLevel(4, 24.3, 0.9, 0.08, 0.0, 0.0) -- Level 4
    SetMapZoomDataLevel(5, 55.0, 0.0, 0.1, 2.0, 1.0) -- ZOOM_LEVEL_GOLF_COURSE
    SetMapZoomDataLevel(6, 450.0, 0.0, 0.1, 1.0, 1.0) -- ZOOM_LEVEL_INTERIOR
    SetMapZoomDataLevel(7, 4.5, 0.0, 0.0, 0.0, 0.0) -- ZOOM_LEVEL_GALLERY
    SetMapZoomDataLevel(8, 11.0, 0.0, 0.0, 2.0, 3.0) -- ZOOM_LEVEL_GALLERY_MAXIMIZE
    SetPlayerWantedLevel(PlayerId(), 0, false)
    SetPlayerWantedLevelNow(PlayerId(), false)
    SetPlayerWantedLevelNoDrop(PlayerId(), 0, false)

    for dispatchService=1, 15 do
        EnableDispatchService(dispatchService, false)
        Citizen.Wait(1)
    end
    
end)


local ctrlStage = 0
local isHolding = false
local isFlying = false
local incrouch = true
local Triggered1 = false
local Triggered2 = false
local Triggered3 = false
local lastButtonPressTime = GetGameTimer()

Citizen.CreateThread(function()
    while true do
        if lastButtonPressTime > GetGameTimer() then
            DisableControlAction(1, 36, true)
        end

        if ctrlStage == 3 then
            if IsControlJustPressed(2,23) then -- F
                ctrlStage = 0
                resetWalkingPed()
                SetPedStealthMovement(playerPed,0,0)
                RecoilFactor("normal")         
            else
                if not Triggered3 then
                    ClearPedTasks(playerPed)
                    Triggered1 = false  
                    Triggered2 = false
                    Triggered3 = true
                    RequestWalking("move_ped_crouched")
                    SetPedMovementClipset(playerPed, "move_ped_crouched",1.0)    
                    SetPedWeaponMovementClipset(playerPed, "move_ped_crouched",1.0)
                    SetPedStrafeClipset(playerPed, "move_ped_crouched_strafing",1.0)
                else
                    if IsDisabledControlJustPressed(1,26) then -- C
                        if lastButtonPressTime < GetGameTimer() then
                            lastButtonPressTime = GetGameTimer() + 500
                            ctrlStage = 0
                            resetWalkingPed()
                            Citizen.Wait(100)  
                            ClearPedTasks(playerPed)
                            RecoilFactor("normal")
                            Citizen.Wait(500)
                            Triggered3 = false
                        end
                    else
                        if GetEntitySpeed(playerPed) > 1.0 and not incrouch then
                            incrouch = true
                            SetPedWeaponMovementClipset(playerPed, "move_ped_crouched",1.0)
                            SetPedStrafeClipset(playerPed, "move_ped_crouched_strafing",1.0)
                        elseif incrouch and GetEntitySpeed(playerPed) < 1.0 and (GetFollowPedCamViewMode() == 4 or GetFollowVehicleCamViewMode() == 4) then
                            incrouch = false
                            ResetPedWeaponMovementClipset(playerPed)
                            ResetPedStrafeClipset(playerPed)
                        end     
                    end         
                end
            end
        end

        -- 26: C
        if IsDisabledControlJustPressed(1,26) and not isFlying and not isHolding and not IsPedSittingInAnyVehicle(playerPed) and not isDead and not exports["high_phone"]:phoneIsOpen() then -- and not (handCuffed or handCuffedWalking or imdead == 1) 
            if lastButtonPressTime < GetGameTimer() then
                lastButtonPressTime = GetGameTimer() + 500
                ctrlStage = 3
                if GetPedStealthMovement(playerPed) then
                    SetPedStealthMovement(playerPed,0,"")
                end             
                RecoilFactor("c")
            end
        end

        if IsControlPressed(1,36) and GetPedStealthMovement(playerPed) and not exports["high_phone"]:phoneIsOpen() then --CTRL
            if lastButtonPressTime < GetGameTimer() then
                lastButtonPressTime = GetGameTimer() + 500
                RecoilFactor("ctrl")
                if ctrlStage == 3 then
                    ctrlStage = 0
                    resetWalkingPed()
                    Citizen.Wait(100)  
                    ClearPedTasks(playerPed)
                    Citizen.Wait(500)
                    Triggered3 = false
                end
            end
        elseif IsControlPressed(1,36) and not GetPedStealthMovement(playerPed) and not exports["high_phone"]:phoneIsOpen() then
            if lastButtonPressTime < GetGameTimer() then
                lastButtonPressTime = GetGameTimer() + 500
                RecoilFactor("normal")
            end
        end

        -- 22: space
        if IsPedJacking(playerPed) or IsPedInMeleeCombat(playerPed) or IsControlJustReleased(1,22) or IsPedRagdoll(playerPed) or IsPedSittingInAnyVehicle(playerPed) or isDead then -- or handCuffed or handCuffedWalking or imdead == 1
            if ctrlStage ~= 0 and not exports["high_phone"]:phoneIsOpen() then
               -- ClearPedTasks(playerPed)
                ctrlStage = 0
                SetPedStealthMovement(playerPed,0,0)
                resetWalkingPed()
                RecoilFactor("normal")
                Triggered1 = false  
                Triggered2 = false
                Triggered3 = false
            end
        end

        -- Sol tık yumruk
        if GetPedStealthMovement(playerPed) then
            if IsControlPressed(0, 330) or IsControlPressed(0, 331) then --
                local _,wep = GetCurrentPedWeapon(playerPed)
                if wep == `WEAPON_UNARMED` then
                    ClearPedTasks(playerPed)
                    ctrlStage = 0
                    SetPedStealthMovement(playerPed,0,0)
                    resetWalkingPed()
                    RecoilFactor("normal")
                    Triggered1 = false  
                    Triggered2 = false
                    Triggered3 = false
                end    
            end  
        end

        Citizen.Wait(1)

        if IsPedSittingInAnyVehicle(playerPed) then
            Citizen.Wait(1000)
        end
    end
end)

function resetWalkingPed()
    if lastMovementClipset == nil then
        if IsPedMale(playerPed) then
            lastMovementClipset = "MOVE_P_M_ONE"
        else
            lastMovementClipset = "move_f@multiplayer"
        end
    end
    ResetPedWeaponMovementClipset(playerPed)
    ResetPedStrafeClipset(playerPed)
    RequestWalking(lastMovementClipset)
    ResetPedMovementClipset(playerPed, 0.0)
    SetPedMovementClipset(playerPed, lastMovementClipset, 0.5)
    RemoveAnimSet(lastMovementClipset)  
end

function RequestWalking(ad)
    RequestAnimSet(ad)
    while (not HasAnimSetLoaded(ad)) do 
        Citizen.Wait(100)
    end 
end 

RegisterNetEvent('elixir-base:setlastMovementClipset')
AddEventHandler('elixir-base:setlastMovementClipset', function(data)
    lastMovementClipset = data
end)

--hud şeyleri falan tab basında envanter falan filan işte amk
local aiming = false
CreateThread(function()
    while true do
        Wait(5)
        if not IsControlPressed(0, 330) or not IsControlPressed(0, 331) then
            DisablePlayerFiring(playerPed, true)
            DisableControlAction(0, 142, true)
        end

        if IsPedArmed(playerPed, 6) then
            DisableControlAction(1, 140, true)
            DisableControlAction(1, 141, true)
            DisableControlAction(1, 142, true)
        elseif not IsControlPressed(0, 330) or not IsControlPressed(0, 331) then
            DisableControlAction(1, 140, true)
        end

        DisableControlAction(0, 26, true) -- look behind

        if IsHudComponentActive(1) then 
            HideHudComponentThisFrame(1)
        end

        if IsHudComponentActive(6) then 
            HideHudComponentThisFrame(6)
        end

        if IsHudComponentActive(7) then 
            HideHudComponentThisFrame(7)
        end

        if IsHudComponentActive(9) then 
            HideHudComponentThisFrame(9)
        end

        if IsHudComponentActive(0) and not inVehicle then 
            HideHudComponentThisFrame(0)
        end

        -- Radar
        DisablePlayerVehicleRewards(playerId)
		if inVehicle then
			SetRadarZoom(1100)
        end

        DisableControlAction(0, 37, true)
        DisableControlAction(0, 157, true)
        DisableControlAction(0, 158, true)
        DisableControlAction(0, 160, true)
        DisableControlAction(0, 164, true)
        DisableControlAction(0, 165, true)
        HudWeaponWheelIgnoreSelection()

    end
end)



-- Zar At
RegisterCommand('roll', function(source, args, rawCommand)
    local zar1 = 1
    if args[1] ~= nil and tonumber(args[1]) then
        zar1 = tonumber(args[1])
    end

    local zar2 = 6
    if args[2] ~= nil and tonumber(args[2]) then
        zar2 = tonumber(args[2])
    end

    if zar1 < zar2 then
        local number = math.random(zar1,zar2)
        QBCore.Shared.RequestAnimDict('anim@mp_player_intcelebrationmale@wank', function() -- animasyon oynatma
            TaskPlayAnim(PlayerPedId(), 'anim@mp_player_intcelebrationmale@wank', 'wank', 8.0, 1.0, -1, 49, 0, 0, 0, 0)
        end)
        Citizen.Wait(1500)
        ClearPedTasks(PlayerPedId())
        -- TriggerServerEvent('3dme:display', zar1 .. '/' .. zar2 .. ' Arası Zar Attı: ' .. number, QBCore.Key, "name", "self")
        TriggerServerEvent('3dme:display', zar1 .. " / " ..zar2 .. " Roll the Dice Between " ..number.. " ", QBCore.Key, "me", "self")
    end
end)



RegisterCommand('rps', function(source)
    local tkm = {
        "Rock",
        "Paper",
        "Scissor"
    }
    local tkmdeger = math.random(1, #tkm)
        QBCore.Shared.RequestAnimDict('anim@mp_player_intcelebrationmale@wank', function() -- animasyon oynatma
            TaskPlayAnim(PlayerPedId(), 'anim@mp_player_intcelebrationmale@wank', 'wank', 8.0, 1.0, -1, 49, 0, 0, 0, 0)
        end)
        Citizen.Wait(1500)
        ClearPedTasks(PlayerPedId())
        TriggerServerEvent('3dme:display', "Rock Paper Scissors Played " ..tkm[tkmdeger].. "", QBCore.Key, "me", "self")
end)






local koltukdegistirengel = true

Citizen.CreateThread(function()
	while true do
        local time = 2500
        local PlayerPed = PlayerPedId(-1)
        local Arac = GetVehiclePedIsIn(PlayerPed, false)
		if IsPedInAnyVehicle(PlayerPed, false) and koltukdegistirengel then
            time = 100
    		if GetPedInVehicleSeat(Arac, 0) == PlayerPed then
                time = 1
				if GetIsTaskActive(PlayerPed, 165) then
                    time = 5
					SetPedIntoVehicle(PlayerPed, Arac, 0)
				end
			end
		end
        Citizen.Wait(time)
	end
end)



function round(value, numDecimalPlaces)
    return tonumber(string.format("%." .. (numDecimalPlaces or 0) .. "f", value))
end

RegisterCommand("seat", function(source, args)
    local PlayerPed = GetPlayerPed(-1)
    local Arac = GetVehiclePedIsIn(PlayerPed, false)
    
    if args[1] == nil then
        Koltuk = -1
    else
        Koltuk = round(tonumber(args[1]-2))
    end
    if IsPedInAnyVehicle(PlayerPed, false) then
        if IsVehicleSeatFree(Arac, Koltuk) then 
            if not exports["high_phone"]:phoneIsOpen() then
            QBCore.Functions.Progressbar("oyuncu_iyilestir", "Changing Seat", math.random(1200, 1900), false, true, { -- p1: menu name, p2: yazı, p3: ölü iken kullan, p4:iptal edilebilir
			disableMovement = true,
			disableCarMovement = true,
			disableMouse = false,
			disableCombat = true,
		}, {
		}, {}, {}, function() -- Done
            SetPedIntoVehicle(PlayerPed, Arac, Koltuk)
            QBCore.Functions.Notify("You Changed Seat")
        end)
    else
        QBCore.Functions.Notify("You cannot change seats while the phone is on.")
    end
        else
            QBCore.Functions.Notify("Seats Full")
        end
    end
end)




local aiming = false

local viewChanged = false

local lastViewMode = 0

local qTime = 0

Citizen.CreateThread(function()
    while true do
        local time = 1000
        if IsPedInAnyVehicle(playerPed) then
            time = 10
            local aiming = IsPlayerFreeAiming(playerId)
            DisableControlAction(0, 68, true)
            local pressedQ = IsControlPressed(0, 85)
            if pressedQ or qTime ~= 0 then
                time = 1
                DisableControlAction(0, 25, true)
                if pressedQ then
                    qTime = 10
                else
                    qTime = qTime - 1
                end
            end
            if not aiming then
                time = 1
                DisableControlAction(0, 68, true)
                DisableControlAction(0, 69, true)
                DisableControlAction(0, 70, true)
                DisableControlAction(0, 92, true)
                DisableControlAction(0, 91, true)
                DisableControlAction(0, 347, true)
            end
            if aiming and GetFollowVehicleCamZoomLevel() ~= 4  then
                time = 1
                viewChanged = true
                lastViewMode = GetFollowVehicleCamZoomLevel()
                SetFollowVehicleCamZoomLevel(4)
            elseif viewChanged and not aiming then
                time = 1
                SetFollowVehicleCamZoomLevel(lastViewMode)
                viewChanged = false
            end
        end
        Citizen.Wait(time)
    end
end)


-- RegisterKeyMapping('+holster', 'Polisler için eli holstera götürme', 'keyboard', 'k')
-- RegisterCommand('+holster', function()
--     if PlayerData.job.name = job then
--         PlayerData.job = job = job
--         if PlayerData.job.name == "police" then
--             local player = PlayerPedId()
--             if IsEntityPlayingAnim(player, "move_m@intimidation@cop@unarmed", "idle", 3) then
--                 ClearPedSecondaryTask(player)
--             else
--                 if not IsPedInAnyVehicle(player) and not IsPedInAnyHeli(player) then
--                     RequestAnimDict("move_m@intimidation@cop@unarmed")
--                     TaskPlayAnim(player, "move_m@intimidation@cop@unarmed", "idle", 2.0, 2.5, -1, 49, 0, 0, 0, 0 )
--                 end
--             end
--         end
--     end
-- end)

-- Citizen.CreateThread(function()
--     while true do
--         Citizen.Wait(0)
--         RemoveAllPickupsOfType(0xDF711959) -- carbine rifle
--         RemoveAllPickupsOfType(0xF9AFB48F) -- pistol
--         RemoveAllPickupsOfType(0xA9355DCD) -- pumpshotgun

--         -- Gang NPC'leri
--         RemoveAllPickupsOfType(0xEA91B807) -- WEAPON_PISTOL
--         RemoveAllPickupsOfType(0x6B577ED1) -- WEAPON_MACHINEPISTOL
--         RemoveAllPickupsOfType(0xEEA44CAE) -- WEAPON_MINISMG
--         RemoveAllPickupsOfType(0xB0769393) -- WEAPON_SNSPISTOL
--         RemoveAllPickupsOfType(0x6E4E65C2)
--         RemoveAllPickupsOfType(0x741C684A)
--         RemoveAllPickupsOfType(0x68605A36)
--         RemoveAllPickupsOfType(0x6C5B941A)
--         RemoveAllPickupsOfType(0xD3A39366)
--         RemoveAllPickupsOfType(0xCC8B3905)
--         RemoveAllPickupsOfType(0xA54AE7B7)
--         RemoveAllPickupsOfType(0xA717F898)
--         RemoveAllPickupsOfType(0x84D676D4)
--         RemoveAllPickupsOfType(0x65A7D8E9)
--         RemoveAllPickupsOfType(0x2C804FE3)
--         RemoveAllPickupsOfType(0x098D79EF)
--         RemoveAllPickupsOfType(0x4316CC09)
--         RemoveAllPickupsOfType(0xB86AEE5B)
--         RemoveAllPickupsOfType(0xCC7CCD1B)
--         RemoveAllPickupsOfType(0x2E071B5A)
--         RemoveAllPickupsOfType(0xA5B8CAA9)
--         RemoveAllPickupsOfType(0x65948212)
--         RemoveAllPickupsOfType(0xE7CF07CC)
--         RemoveAllPickupsOfType(0x1CD2CF66)
--         RemoveAllPickupsOfType(0x6773257D)
--         RemoveAllPickupsOfType(0x20796A82)
--         RemoveAllPickupsOfType(0x116FC4E6)
--         RemoveAllPickupsOfType(0xE4BD2FC6)
--         RemoveAllPickupsOfType(0xDE58E0B3)
--         RemoveAllPickupsOfType(0x77F3F2DD)
--         RemoveAllPickupsOfType(0xC02CF125)
--         RemoveAllPickupsOfType(0x881AB0A8)
--         RemoveAllPickupsOfType(0x84837FD7)
--         RemoveAllPickupsOfType(0xF25A01B9)
--         RemoveAllPickupsOfType(0x815D66E8)
--         RemoveAllPickupsOfType(0xFA51ABF5)
--         RemoveAllPickupsOfType(0xC5B72713)
--         RemoveAllPickupsOfType(0x5307A4EC)
--         RemoveAllPickupsOfType(0x9CF13918)
--         RemoveAllPickupsOfType(0x0968339D)
--         RemoveAllPickupsOfType(0xBFEE6C3B)
--         RemoveAllPickupsOfType(0xEBF89D5F)
--         RemoveAllPickupsOfType(0x22B15640)
--         RemoveAllPickupsOfType(0x763F7121)
--         RemoveAllPickupsOfType(0xF92F486C)
--         RemoveAllPickupsOfType(0x602941D0)
--         RemoveAllPickupsOfType(0x31EA45C9)
--         RemoveAllPickupsOfType(0xBED46EC5)
--         RemoveAllPickupsOfType(0x079284A9)
--         RemoveAllPickupsOfType(0xE175C698)
--         RemoveAllPickupsOfType(0x624F7213)
--         RemoveAllPickupsOfType(0xC01EB678)
--         RemoveAllPickupsOfType(0x5C517D97)
--         RemoveAllPickupsOfType(0xBD4DE242)
--         RemoveAllPickupsOfType(0xE013E01C)
--         RemoveAllPickupsOfType(0x789576E2)
--         RemoveAllPickupsOfType(0xFD9CAEDE)
--         RemoveAllPickupsOfType(0x8ADDEC75)
        
--         DisablePlayerVehicleRewards(PlayerId())
--     end
-- end)


-- Citizen.CreateThread(function()
--     while true do
--         N_0x4757f00bc6323cfe(GetHashKey("WEAPON_UNARMED"), 0.2)
--         Wait(0)
--        N_0x4757f00bc6323cfe(GetHashKey("WEAPON_NIGHTSTICK"), 0.085) 
--        Wait(0)
--        N_0x4757f00bc6323cfe(GetHashKey("WEAPON_SWITCHBLADE"), 0.4) 
--        Wait(0)
--        N_0x4757f00bc6323cfe(GetHashKey("WEAPON_KNIFE"), 0.4) 
--        Wait(0)
--        N_0x4757f00bc6323cfe(GetHashKey("WEAPON_KNUCKLE"), 0.45) 
--        Wait(0)
--        N_0x4757f00bc6323cfe(GetHashKey("WEAPON_MACHETE"), 0.4) 
--        Wait(0)
--    end
-- end)

-- Combat Mode Kapatma

Citizen.CreateThread( function()
    while true do
        local time = 3000
        local ped = PlayerPedId(-1)
        if not GetPedConfigFlag(ped,78,1) then
            time = 1
            SetPedUsingActionMode(PlayerPedId(-1), false, -1, 0)
        end
        Citizen.Wait(time)
    end
end) 



Citizen.CreateThread(function()
    AddTextEntryByHash("subwrx", 'Subaru')
    AddTextEntryByHash('dilettante2', 'Sürüş Testi Aracı')
    AddTextEntryByHash('npolvette', 'Police Corvette')
    AddTextEntryByHash('npolstang', 'Police Mustang')
    AddTextEntryByHash('npolchal', 'Police Challenger')
    AddTextEntryByHash('panamera17turbo', 'Porsche Panamera')
    AddTextEntryByHash('m6f13', 'BMW M6')
    AddTextEntryByHash('bmws', 'BMW s1000RR')
    AddTextEntryByHash('911turbos', 'Porsche 911T')
    AddTextEntryByHash('vantage', 'Aston Martin Vantage')
    AddTextEntryByHash('viper', 'Dodge Viper')
    AddTextEntryByHash('rmodgt63', 'Mercedes AMG GT63s')
    AddTextEntryByHash('amggt', 'AMG GT')
    AddTextEntryByHash('c7', 'Chevrolet CorvetteC7')
    AddTextEntryByHash('i8', 'BMW i8')
    AddTextEntryByHash('tuscani', 'Hyundai Tuscani')
    AddTextEntryByHash('npolvic', 'Police Victoria')
    AddTextEntryByHash('rs5', 'Audi RS5')
    AddTextEntryByHash('rrst', 'Range Rover Vogue')
    AddTextEntryByHash('sgt500', 'Mustang GT500')
    AddTextEntryByHash('bmci', 'BMW M5')
    AddTextEntryByHash('69charger', 'Dodge Charger69')
    AddTextEntryByHash('mb300sl', 'Mercedes-Benz 300SL')
    AddTextEntryByHash('16challenger', 'Dodge Challenger16')
    AddTextEntryByHash('audirs6tk', 'Audi RS6')
    AddTextEntryByHash('s500w222', 'Mercedes S500')
    AddTextEntryByHash('a8audi', 'Audi A8')
    AddTextEntryByHash('evo9', 'Mitshubishi Lancer EVO9')
    AddTextEntryByHash('2013rs7', 'Audi RS7')
    AddTextEntryByHash('subwrx', 'Subaru WRX')
    AddTextEntryByHash('m3e30', 'BMW M3')
    AddTextEntryByHash('honcrx91', 'Honda CRX91')
    AddTextEntryByHash('civic', 'Honda Civic99')
    AddTextEntryByHash('a45amg', 'Mercedes AMG A45')
    AddTextEntryByHash('africat', 'Honda CRF1000L')
    AddTextEntryByHash('bmwe65', 'BMW E65')
    AddTextEntryByHash('16charger', 'Dodge Charger16')
    AddTextEntryByHash('amarok', 'VolksWagen Amarok')
    AddTextEntryByHash('nspeedo', 'Vapid Speedo')
    AddTextEntryByHash('yfiat595ssb', 'Fiat Abarth 595')
    AddTextEntryByHash('g_xlcr', 'Harley XLCR')
    AddTextEntryByHash('gpz1100', 'Kawasaki GP Z1100')
    AddTextEntryByHash('z1000a1', 'Kawasaki Z1000 A1')
    AddTextEntryByHash('g_900mhr', 'Ducati 900 MHR')
    AddTextEntryByHash('g_900ss', 'Ducati 900 SS')
    AddTextEntryByHash('f100', 'Ford F100')
    AddTextEntryByHash('f150', 'Ford Raptor 12')
    AddTextEntryByHash('fatboy', 'Harley Vintage')
    AddTextEntryByHash('yfiat595ssa', 'Fiat 500')
    AddTextEntryByHash('mk1rabbit', 'Golf MK1')
    AddTextEntryByHash('911rwb', 'Porsche 911RWB')
    AddTextEntryByHash('c7', 'Corvette C7')
    AddTextEntryByHash('mustang19', '19 Mustang Boss')
    AddTextEntryByHash('er34', 'R34 Skyline')
    AddTextEntryByHash('rapide', 'Aston Martin Rapide')
    AddTextEntryByHash('granlb', 'Maserati GranTurismo')
    AddTextEntryByHash('focusrs', 'Ford FocusRS')
    AddTextEntryByHash('fugitive3', 'Fugitive Custom')
    AddTextEntryByHash('nc1', 'NSX')
    AddTextEntryByHash('civicek9rb', 'Type-R')
    AddTextEntryByHash('ast', 'Aston Martin Vanquish')
    AddTextEntryByHash('ninefjd', 'Ninef JD')
    AddTextEntryByHash('pentrogpr2', 'Pentro GPR2')
    AddTextEntryByHash('crocotogt', 'Porsche Cayenne')
    AddTextEntryByHash('sentigpr', 'Sentinel Custom')
    AddTextEntryByHash('fk8', 'Honda Civic')
    AddTextEntryByHash('rs5r', 'Audi RS5')
    AddTextEntryByHash('urus', 'Lamborghini Urus')
    AddTextEntryByHash('bdragon', 'Bentley GT')
    AddTextEntryByHash('gtrc', 'Mercedes GT')
    AddTextEntryByHash('m4', 'BMW M4')
    AddTextEntryByHash('m235', 'BMW M2')
    AddTextEntryByHash('z32', 'Fairlady')
    AddTextEntryByHash('komodofr', 'Komodo Custom')
    AddTextEntryByHash('beetle74', 'Volkswagen Beetle 74')
    AddTextEntryByHash('aoka', 'Lada Oka')
    AddTextEntryByHash('fz50', 'FZ 50')
    AddTextEntryByHash('ak99', 'Lada Samara')
    AddTextEntryByHash('eclipse', 'Eclipse')
    AddTextEntryByHash('skyline', 'Skyline')
    AddTextEntryByHash('370z', 'Nissan 370Z')
    AddTextEntryByHash('tampa3', 'Drift Tampa')
    AddTextEntryByHash('yosemite6str', 'Drift Yosemite')
    AddTextEntryByHash('demon', 'Dodge Challenger')
    AddTextEntryByHash('gtx', 'Plymouth GTX 71')
    AddTextEntryByHash('kart', 'Si-Kart')
    AddTextEntryByHash('r820', 'Audi R8')
    AddTextEntryByHash('nh2r', 'Kawasaki Ninja H2R')
    AddTextEntryByHash('mgt', 'Ford Mustang GT15')
    AddTextEntryByHash('gtr', 'Nissan GTR 17')
    AddTextEntryByHash('lp700r', 'Lamborghini Aventador 13')
    AddTextEntryByHash('720s', 'McLaren 720s 17')
    AddTextEntryByHash('18performante', 'Lamborghini Huracan')
    AddTextEntryByHash('gt17', 'Ford GT 17')
    AddTextEntryByHash('14charger', 'Polis Charger')
    AddTextEntryByHash('11cvpi', 'Polis Crown Victoria')
    AddTextEntryByHash('2015polstang', 'HSU Mustang GT')
    AddTextEntryByHash('emsroamer', 'EMS SUV')
    AddTextEntryByHash('emsnspeedo', 'EMS Ambulans')
    AddTextEntryByHash('polp1', 'HSU McLaren P1')
    AddTextEntryByHash('pol718', 'HSU Porsche 718')
    AddTextEntryByHash('polchar', 'Police Charger')
    AddTextEntryByHash('polraptor', 'Police Raptor')
    AddTextEntryByHash('poltah', 'Police Tahoe')
    AddTextEntryByHash('poltaurus', 'Police Taurus')
    AddTextEntryByHash('polvic', 'Police Victoria')
    AddTextEntryByHash('polvic2', 'Police Victoria V2')
    AddTextEntryByHash('polnspeedo', 'Police Transporter')
    AddTextEntryByHash('mclarenpd', 'HSU McLaren V2')
    AddTextEntryByHash('chargerpol', 'HSU Police Charger')
    AddTextEntryByHash('polgs350', 'HSU Police Lexus')
    AddTextEntryByHash('ucballer', 'Sivil Baller')
    AddTextEntryByHash('ucbanshee', 'Sivil Banshee')
    AddTextEntryByHash('ucbuffalo', 'Sivil Buffalo')
    AddTextEntryByHash('uccomet', 'Sivil Comet')
    AddTextEntryByHash('uccoquette', 'Sivil Coquette')
    AddTextEntryByHash('ucprimo', 'Sivil Primo')
    AddTextEntryByHash('ucrancher', 'Sivil Rancher')
    AddTextEntryByHash('ucwashington', 'Sivil Washington')
    AddTextEntryByHash('polschafter3', 'Sivil Schafter')
end)



 --yeni base'ler

--  Citizen.CreateThread(function()
--     while true do
--       Citizen.Wait(1)
--       HideHudComponentThisFrame(3) -- Cash
--       HideHudComponentThisFrame(4) -- MP Cash
--       HideHudComponentThisFrame(6) -- Vehicle Name
--       HideHudComponentThisFrame(7) -- Area Name
--       HideHudComponentThisFrame(9) -- Street Name
--       HideHudComponentThisFrame(13) -- Cash Change
--       StartAudioScene("CHARACTER_CHANGE_IN_SKY_SCENE"); -- mekan/ortam sesleri kapatma
--       SetAudioFlag("PoliceScannerDisabled",true); 
--     end
-- end)

local FireRate = {

    [`weapon_pistol`] = 0.375, 
    [`weapon_pistol_mk2`] = 0.38, 
    [`weapon_heavypistol`] = 0.42, 
    [`weapon_combatpistol`] = 0.38,
    [`weapon_snspistol`] = 0.375,
    [`weapon_vintagepistol`] = 0.42,
    [`weapon_machinepistol`] = 0.12,
    [`weapon_appistol`] = 0.11,
}


-- Citizen.CreateThread(function()
-- 	while true do
-- 		Citizen.Wait(5)
-- 		local ped = PlayerPedId()
-- 		local playerPos = GetEntityCoords(ped)
--         local ananizisiktim = GetWeaponTimeBetweenShots(GetSelectedPedWeapon(PlayerPedId()))
-- 		if IsPedShooting(ped) then
-- 			local _,wep = GetCurrentPedWeapon(ped)
--                 local weaponData = FireRate[wep]
-- 				if weaponData then
-- 					if weaponData < ananizisiktim then
-- 					QBCore.Functions.Notify('Fire Rate Düzenlemesi yapan 3.Parti yazılım kullanmayınız.!', 5000)
--                     Wait(500)
--                     QBCore.Functions.Notify('Fire Rate Düzenlemesi yapan 3.Parti yazılım kullanmayınız.!', 5000)
--                     Wait(500)
--                     QBCore.Functions.Notify('Fire Rate Düzenlemesi yapan 3.Parti yazılım kullanmayınız.!', 5000)
--                     Wait(500)
--                     QBCore.Functions.Notify('Fire Rate Düzenlemesi yapan 3.Parti yazılım kullanmayınız.!', 5000)
--                     Wait(500)
--                     QBCore.Functions.Notify('Fire Rate Düzenlemesi yapan 3.Parti yazılım kullanmayınız.!', 5000)
--                     Wait(500)
-- 					-- TriggerEvent('m3:inventoryhud:client:removeCurrentWeapon')
-- 					end
-- 				end
-- 			end
-- 		end
-- 	end)

    local Vehicles = {
        {label = 'Polis Victoria', spawnName = 'polvic'},
        {label = 'Mazda FN RX7', spawnName = 'fnfrx7'},
        {label = 'Subaru WRX', spawnName = 'subwrx'}
    
    }
    
    Citizen.CreateThread(function()
        for num,vehicle in ipairs(Vehicles) do
            AddTextEntryByHash(GetHashKey(vehicle.spawnName), vehicle.label)
        end
    end)
  

--anti bunny
    -- Citizen.CreateThread(function()
    --     while true do
    --         local time = 1000
    --         local ped = PlayerPedId()
    --         if IsPedOnFoot(ped) and not IsPedSwimming(ped) and (IsPedRunning(ped) or IsPedSprinting(ped)) and not IsPedClimbing(ped) and IsPedJumping(ped) and not IsPedRagdoll(ped) then
    --             local chance_result = math.random()
    --             if chance_result < 0.50 then
    --                 Citizen.Wait(600)     
    --                 SetPedToRagdoll(ped, 5000, 1, 3) -- kaç zıplamada yere düşmesini istiyorsanız ayarlıyabilirsiniz.
    --             else
    --                 Citizen.Wait(2000)
    --             end
    --                 Citizen.Wait(100)
    --         end
    --     end
    -- end)

    --Kayma
-- local Kayabilir = {
--     ["1"] = true,
--     ["3"] = true,
--     ["4"] = true,
--     ["12"] = true,
--     ["13"] = true,
--     ["68"] = true,
--     ["181"] = true,
-- }
-- CreateThread(function()
--     while true do Wait(1000)
--         print("sa")
--         local arac = GetVehiclePedIsIn(PlayerPedId(),false)
--         if arac ~= 0 and GetIsVehicleEngineRunning(arac) and GetEntitySpeed(arac) * 3.6 > 30.0 then
--             local material_id = GetVehicleWheelSurfaceMaterial(arac, 1)
--             local wheel_type = GetVehicleWheelType(arac)
    
--             if wheel_type == 4 then
--                 QBCore.Functions.Notify("4 offroad")
--                 if Kayabilir[tostring(material_id)] ~= true then
--                     QBCore.Functions.Notify("4 offroad")
--                     SetVehicleGravityAmount(arac, 11.8000001907349)
--                 end
--             elseif wheel_type ~= 6 then
--                 QBCore.Functions.Notify("6 bisiklet")
--                 if Kayabilir[tostring(material_id)] then
--                     SetVehicleGravityAmount(arac, 9.8000001907349)
--                 else
--                     if IsEntityInAir(arac) then
--                         QBCore.Functions.Notify("havadayım")
--                         SetVehicleGravityAmount(arac, 9.8000001907349)
--                     else
--                         SetVehicleGravityAmount(arac, 5.8000001907349)
--                         QBCore.Functions.Notify("değilim")
--                     end
--                 end
--             end
--         end
--     end
-- end)
-- Citizen.CreateThread(function()
--     while true do Wait(1000)
--         print("sa")
--         local vehicle = GetVehiclePedIsIn(PlayerPedId(),false)
--         if DoesEntityExist(vehicle) then
--             print("sa2")
--             local wheel_type = GetVehicleWheelType(vehicle)
--             if wheel_type ~= 3 and wheel_type ~= 4 and wheel_type ~= 6 then -- If have Off-road/Suv's/Motorcycles wheel grip its equa
--                 local material_id = GetVehicleWheelSurfaceMaterial(vehicle, 1)
--                 if material_id == 4 or material_id == 1 or material_id == 3 then -- All road (sandy/los santos/paleto bay)
--                     offRoad = 0
--                     SetVehicleGravityAmount(vehicle, 5.8000001907349) -- On road
--                     QBCore.Functions.Notify("4.")
--                 else
--                     offRoad = offRoad + 1
--                     if offRoad > 4 then
--                         SetVehicleGravityAmount(vehicle, 1.8000001907349) -- Off road
--                         QBCore.Functions.Notify("bu offroad.")
--                     end
--                 end
--             end
--         end
--     end
-- end)


--Cayo Perico Ada
local requestedIpl = {"h4_islandairstrip", "h4_islandairstrip_props", "h4_islandx_mansion", "h4_islandx_mansion_props", "h4_islandx_props", "h4_islandxdock", "h4_islandxdock_props", "h4_islandxdock_props_2", "h4_islandxtower", "h4_islandx_maindock", "h4_islandx_maindock_props", "h4_islandx_maindock_props_2", "h4_IslandX_Mansion_Vault", "h4_islandairstrip_propsb", "h4_beach", "h4_beach_props", "h4_beach_bar_props", "h4_islandx_barrack_props", "h4_islandx_checkpoint", "h4_islandx_checkpoint_props", "h4_islandx_Mansion_Office", "h4_islandx_Mansion_LockUp_01", "h4_islandx_Mansion_LockUp_02", "h4_islandx_Mansion_LockUp_03", "h4_islandairstrip_hangar_props", "h4_IslandX_Mansion_B", "h4_islandairstrip_doorsclosed", "h4_Underwater_Gate_Closed", "h4_mansion_gate_closed", "h4_aa_guns", "h4_IslandX_Mansion_GuardFence", "h4_IslandX_Mansion_Entrance_Fence", "h4_IslandX_Mansion_B_Side_Fence", "h4_IslandX_Mansion_Lights", "h4_islandxcanal_props", "h4_beach_props_party", "h4_islandX_Terrain_props_06_a", "h4_islandX_Terrain_props_06_b", "h4_islandX_Terrain_props_06_c", "h4_islandX_Terrain_props_05_a", "h4_islandX_Terrain_props_05_b", "h4_islandX_Terrain_props_05_c", "h4_islandX_Terrain_props_05_d", "h4_islandX_Terrain_props_05_e", "h4_islandX_Terrain_props_05_f", "H4_islandx_terrain_01", "H4_islandx_terrain_02", "H4_islandx_terrain_03", "H4_islandx_terrain_04", "H4_islandx_terrain_05", "H4_islandx_terrain_06", "h4_ne_ipl_00", "h4_ne_ipl_01", "h4_ne_ipl_02", "h4_ne_ipl_03", "h4_ne_ipl_04", "h4_ne_ipl_05", "h4_ne_ipl_06", "h4_ne_ipl_07", "h4_ne_ipl_08", "h4_ne_ipl_09", "h4_nw_ipl_00", "h4_nw_ipl_01", "h4_nw_ipl_02", "h4_nw_ipl_03", "h4_nw_ipl_04", "h4_nw_ipl_05", "h4_nw_ipl_06", "h4_nw_ipl_07", "h4_nw_ipl_08", "h4_nw_ipl_09", "h4_se_ipl_00", "h4_se_ipl_01", "h4_se_ipl_02", "h4_se_ipl_03", "h4_se_ipl_04", "h4_se_ipl_05", "h4_se_ipl_06", "h4_se_ipl_07", "h4_se_ipl_08", "h4_se_ipl_09", "h4_sw_ipl_00", "h4_sw_ipl_01", "h4_sw_ipl_02", "h4_sw_ipl_03", "h4_sw_ipl_04", "h4_sw_ipl_05", "h4_sw_ipl_06", "h4_sw_ipl_07", "h4_sw_ipl_08", "h4_sw_ipl_09", "h4_islandx_mansion", "h4_islandxtower_veg", "h4_islandx_sea_mines", "h4_islandx", "h4_islandx_barrack_hatch", "h4_islandxdock_water_hatch", "h4_beach_party"}

CreateThread(function()
	for i = #requestedIpl, 1, -1 do
		RequestIpl(requestedIpl[i])
		requestedIpl[i] = nil
	end
	requestedIpl = nil
end)

CreateThread(function()
	while true do
		SetRadarAsExteriorThisFrame()
		SetRadarAsInteriorThisFrame(`h4_fake_islandx`, vec(4700.0, -5145.0), 0, 0)
		Wait(1)
	end
end)

CreateThread(function()
	Wait(2500)
	local islandLoaded = false
	local islandCoords = vector3(4840.571, -5174.425, 2.0)
	SetDeepOceanScaler(0.0)
	while true do
		local pCoords = GetEntityCoords(PlayerPedId())
		if #(pCoords - islandCoords) < 2000.0 then
			if not islandLoaded then
				islandLoaded = true
				Citizen.InvokeNative(0xF74B1FFA4A15FBEA, 1)
			end
		else
			if islandLoaded then
				islandLoaded = false
				Citizen.InvokeNative(0xF74B1FFA4A15FBEA, 0)
			end
		end
		Wait(5000)
	end
end)
-- Kadın karakterlerinin canının 175 olması
CreateThread(function()
    while true do
        Wait(2000)
        if GetEntityMaxHealth(PlayerPedId()) ~= 200 then
            SetEntityMaxHealth(PlayerPedId(), 200)
            SetEntityHealth(PlayerPedId(), 200)
        end
        if IsPedInAnyVehicle(PlayerPedId(), false) then 
            SetPedConfigFlag(PlayerPedId(), 35, false)
        end
    end
end)

CreateThread(function()
  AddTextEntry('FE_THDR_GTAO', '~r~ Elixir v1.5 ~w~ ~b~ ElixirFW ~w~')
end)

-- --eğilme çölelme c tusu eğilme ctrl c
-- local crouched = false
-- Citizen.CreateThread( function()
--     while true do 
--         Citizen.Wait( 1000 )

--         local ped = GetPlayerPed( -1 )

--         if ( DoesEntityExist( ped ) and not IsEntityDead( ped ) ) then 
--             DisableControlAction( 0, 253, true ) -- INPUT_DUCK  

--             if ( not IsPauseMenuActive() ) then 
--                 if ( IsDisabledControlJustPressed( 0, 253 ) ) then 
--                     RequestAnimSet( "move_ped_crouched" )

--                     while ( not HasAnimSetLoaded( "move_ped_crouched" ) ) do 
--                         Citizen.Wait( 1000 )
--                     end 

--                     if ( crouched == true ) then 
--                         ResetPedMovementClipset( ped, 1 )
--                         crouched = false 
--                     elseif ( crouched == false ) then
--                         SetPedMovementClipset( ped, "move_ped_crouched", 1 )
--                         crouched = true 
--                     end 
--                 end
--             end 
--         end 
--     end
-- end )



-- frene basınca arka 4lü yanma
local brakeLightSpeedThresh = 0.25
-- Main thread
CreateThread(function()
    local time = 2500
	while true do
        -- Loop forever and update every frame
        
        -- Get player and vehicle player is in
        local player = GetPlayerPed(-1)
        local vehicle = GetVehiclePedIsIn(player, false)
        
        if IsPedInAnyVehicle(PlayerPed) then -- When in Vehicle
            time = 1000
            if (vehicle ~= nil) and (GetEntitySpeed(vehicle) <= brakeLightSpeedThresh) then
                time = 100
                -- Set brake lights
                SetVehicleBrakeLights(vehicle, true)
            end
        end
        Wait(time)
	end
end)


Citizen.CreateThread(function()
    TriggerEvent('chat:addSuggestion', '/skin', 'Give a Player a Skin Menu', {
      {name="id", help="ID"},
    })
    TriggerEvent('chat:addSuggestion', '/gsr', 'Give a Player a GSR Test', {
        {name="id", help="ID"},
      })
      TriggerEvent('chat:addSuggestion', '/seat', 'Change Seat', {
        {name="Number", help="Which Seat Will You Take?"},
      })
    TriggerEvent('chat:addSuggestion', '/roll', 'Roll the Dice', {})
    TriggerEvent('chat:addSuggestion', '/rps', 'Rock Paper Scissor', {})
    TriggerEvent('chat:addSuggestion', '/announcement', 'Send Announcement Message', {})
    TriggerEvent('chat:addSuggestion', '/hud', 'Hud Menu', {})
    TriggerEvent('chat:addSuggestion', '/transferveh', 'You transfer your current vehicle to a nearby player.', {})
    TriggerEvent('chat:addSuggestion', '/refresh', "You renew your skin and existing props are deleted", {})
    TriggerEvent('chat:addSuggestion', '/hair', 'You Wear Hairpins (If you type it again, your hair will return to its original state)', {})
    TriggerEvent('chat:addSuggestion', '/cruise', 'It fixes the speed of the vehicle to the value you write.', {})
    TriggerEvent('chat:addSuggestion', '/uifix', 'If the blue text in the middle left of the screen is bugged, it will be deleted..', {})
    TriggerEvent('chat:addSuggestion', '/motelfix', 'If you are stuck in the motel room, you can exit using the command.', {})
    TriggerEvent('chat:addSuggestion', '/chairfix', 'A command you can use if youre bugged in the chair', {})
    TriggerEvent('chat:addSuggestion', '/twitter', 'Finishes the cleaning job', {})
    TriggerEvent('chat:addSuggestion', '/combatlog', 'If you use this command when a player leaves the game, the players information will appear.', {})
    TriggerEvent('chat:addSuggestion', '/taxi', 'Opens taxi transactions while in a taxi vehicle', {})
    TriggerEvent('chat:addSuggestion', '/raid', 'Cops can break into homes that can be robbed.', {})
    TriggerEvent('chat:addSuggestion', '/id', "You can check your ID.", {})
    TriggerEvent('chat:addSuggestion', '/splakasök', 'If the police write this command to the vehicle with the fake plate, they will remove the fake plate.', {})
    TriggerEvent('chat:addSuggestion', '/badgefix', 'A command you can use if a cop has shown you a badge and its stuck on your screen', {})
    TriggerEvent('chat:addSuggestion', '/skill', 'Shows/disables your current skill status', {})
    TriggerEvent('chat:addSuggestion', '/bodycamfix', 'You can use it if the camera is bugged while watching the player..', {})
    TriggerEvent('chat:addSuggestion', '/code', 'Code 0 | Code 1 | Code 2 | Code 50 | Code 99 | Includes codes.', {})
    TriggerEvent('chat:addSuggestion', '/jailmenu', 'Cops open prison menu', {})
    TriggerEvent('chat:addSuggestion', '/dance', '1 - 3000 If you enter a number between, she dances that number, if you do not enter a number, You chooses a random dance among 3000 dances.', {})
    TriggerEvent('chat:addSuggestion', '/galleryfix', 'If you are stuck in the gallery you can use this command', {})
    TriggerEvent('chat:addSuggestion', '/boat', 'EMS players can land boats in sea areas with this command', {})
    TriggerEvent('chat:addSuggestion', '/pboat', 'Police players can take out boats in sea areas with this command', {})
    TriggerEvent('chat:addSuggestion', '/hospitalfix', 'If you are stuck on the train track at the side of the hospital, you can teleport to the hospital using this command..', {})
    TriggerEvent('chat:addSuggestion', '/prison', 'Reads LSPD Rights', {})
    TriggerEvent('chat:addSuggestion', '/objects', 'Object Menu', {})
    TriggerEvent('chat:addSuggestion', '/fix', 'Repairs vehicle in department garage.', {})
    TriggerEvent('chat:addSuggestion', '/emstablet', 'EMS Tablet', {})
    TriggerEvent('chat:addSuggestion', '/move', 'You carry a player', {})
    TriggerEvent('chat:addSuggestion', '/corner', 'You Keep a Corner', {})
    TriggerEvent('chat:addSuggestion', '/köşetutiptal', 'Cancels cornering', {})
    TriggerEvent('chat:addSuggestion', '/f3fix', 'Fix Radial Menu', {})
    TriggerEvent('chat:addSuggestion', '/armor', 'Removes and puts on the armor accessory', {})
    TriggerEvent('chat:addSuggestion', '/shoe', 'Takes off and puts on shoe accessories', {})
    TriggerEvent('chat:addSuggestion', '/pants', 'Takes off and puts on the trousers accessory', {})
    TriggerEvent('chat:addSuggestion', '/bag', 'Takes off and puts on the bag accessory', {})
    TriggerEvent('chat:addSuggestion', '/tshirt', 'Takes off and puts on the t-shirt accessory', {})
    TriggerEvent('chat:addSuggestion', '/glasses', 'Takes off and puts on glasses accessories', {})
    TriggerEvent('chat:addSuggestion', '/glove', 'Takes off and puts on the glove accessory', {})
    TriggerEvent('chat:addSuggestion', '/mask', 'Takes off and puts on the mask accessory', {})
    TriggerEvent('chat:addSuggestion', '/hat', 'He takes off his hat accessory and puts it on', {})
  end)


