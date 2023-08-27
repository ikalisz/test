local recoilWeapon = {
[`weapon_stungun`] = 0.0,
--Pistol
[`weapon_snspistol`] = 1.5,
[`weapon_vintagepistol`] = 1.30,
[`weapon_pistol`] = 1.15, 
[`weapon_combatpistol`] = 1.10,
[`weapon_pistol_mk2`] = 1.0, 
[`weapon_glock`] = 0.8, 
[`weapon_heavypistol`] = 0.6, 
[`weapon_machinepistol`] = 1.00,
[`weapon_appistol`] = 1.0,
[`weapon_pistol50`] = 2.6,

--SMG

    [`weapon_smg`] = 0.60, 
    [`weapon_minismg`] = 0.40, 
    [`weapon_smg`] = 0.85, 
    [`weapon_smg_mk2`] = 0.85, 
    [`weapon_microsmg`] = 0.40, 
    [`weapon_microsmg2`] = 0.70,
    [`weapon_microsmg3`] = 0.70,
    [`weapon_assaultsmg`] = 0.80,
    [`weapon_combatpdw`] = 0.60,
    
    
    
    --rifle
    [`weapon_compactrifle`] = 0.30,
    [`weapon_m4`] = 0.65,
    [`weapon_advancedrifle`] = 0.55,
    [`weapon_specialcarbine_mk2`] = 0.30,
    [`weapon_mk18b`] = 0.45, 
    [`weapon_carbinerifle`] = 0.45, 
    [`weapon_carbinerifle_mk2`] = 0.25, 
    [`weapon_assaultrifle`] = 0.45,
    [`weapon_assaultrifle_mk2`] = 0.25,
    [`weapon_specialcarbine`] = 0.70,
    [`weapon_bullpuprifle`] = 0.80,
    --SNİPER
    [`weapon_sniperrifle`] = 8.0, 
}


local carList = {
    `zentorno`,
    `jester`,
    `pagani`,
    `infernus`,
    `bullet`,
    `turismor`,
    `thrax`,
    `ninef`,
}

local disableAimCarList = {
    `bcat`,
    `stockade`,
    `policet`,
    `riot`
}

local addUnarmedDamage = 0
RegisterNetEvent('weaponry:set-unarmed-damage')
AddEventHandler('weaponry:set-unarmed-damage', function(tip, svy)
    if tip == "MP0_STAMINA" then
        addUnarmedDamage = svy/50
    end
end)

function lookingFront(Arac)
    local coordB = GetOffsetFromEntityInWorldCoords(playerPed, 22.0, 80.0, 0.0)
    local onScreen,_x,_y = World3dToScreen2d(coordB.x,coordB.y,coordB.z)
   	return onScreen
end

function lookingBehind()
	local coordB = GetOffsetFromEntityInWorldCoords(playerPed, 0.0, -40.0, 0.0)
    local onScreen,_x,_y = World3dToScreen2d(coordB.x,coordB.y,coordB.z)
   	return onScreen
end

Citizen.CreateThread(function()
    while true do
        if inVehicle and IsPlayerFreeAiming(playerId) then
            local carModel = GetEntityModel(veh)

            local driveByPassive = false
            for i=1, #carList do
                if carModel == carList[i] then
                    driveByPassive = true
                    break
                end
            end
            
            local disableAimCar = false
            if GetPedInVehicleSeat(veh, -1) == playerPed or GetPedInVehicleSeat(veh, 0) == playerPed then
                for i=1, #disableAimCarList do
                    if carModel == disableAimCarList[i] then
                        disableAimCar = true
                        break
                    end
                end
            end

            local lookBehind = lookingBehind()
            local lookFrontVal = DoesVehicleHaveDoor(veh, 4) == 1 and GetVehicleDoorAngleRatio(veh, 4) > 0 and not IsVehicleDoorDamaged(veh, 4) and lookingFront(veh) == 1
            local lookBehindVal = driveByPassive and lookBehind == 1
            if lookBehindVal or lookFrontVal or disableAimCar or (DoesVehicleHaveDoor(veh, 4) == 1 and GetVehicleDoorAngleRatio(veh, 5) > 0 and lookBehind == 1) then
                SetPlayerCanDoDriveBy(playerId, false)
            else
                SetPlayerCanDoDriveBy(playerId, true)
            end
           
        end
        Citizen.Wait(100)
    end
end)

local weaponRecoilFactor = 1
function RecoilFactor(type)
    if type == "normal" then
        weaponRecoilFactor = 1
    elseif type == "c" then
        weaponRecoilFactor = 0.75
    elseif type == "ctrl" then
        weaponRecoilFactor = 0.5
    end
end

Citizen.CreateThread(function()
    while true do 
        local time = 200
        if IsPedArmed(playerPed, 7) then
            time = 1

            if IsControlPressed(0, 137) or weaponRecoilFactor == 0.75 then
                DisablePlayerFiring(playerPed, true)
            end

            if IsPedShooting(playerPed) then      
                local _,wep = GetCurrentPedWeapon(playerPed)
                local weaponData = recoilWeapon[wep]
                if weaponData then
                    local MovementSpeed = math.ceil(GetEntitySpeed(playerPed))
                    if MovementSpeed > 69 then MovementSpeed = 69 end

                    if IsControlPressed(0, 137) then
                        inVehicle = true
                        MovementSpeed = 60
                    end

                    local recoil = (math.random(100,140+MovementSpeed)/100) * weaponData

                    local cameraDistance = #(GetGameplayCamCoord() - playerPedCoords)
                    if cameraDistance < 5.3 then
                        cameraDistance = 1.5
                    else
                        if cameraDistance < 8.0 then
                            cameraDistance = 4.0
                        else
                            cameraDistance = 7.0
                        end
                    end

                    local hf = math.random(10,40+MovementSpeed)/100
                    if inVehicle then
                        recoil = recoil + (recoil * cameraDistance)
                        hf = hf * 2.0 
                    end

                    recoil = recoil * weaponRecoilFactor

                    local rightleft = math.random(4)
                    if rightleft == 1 then
                        SetGameplayCamRelativeHeading(GetGameplayCamRelativeHeading() + hf)
                    elseif rightleft == 2 then
                        SetGameplayCamRelativeHeading(GetGameplayCamRelativeHeading() - hf)
                    end 

                    if GetFollowPedCamViewMode() == 4 then recoil = recoil - 0.1 end

                    SetGameplayCamRelativePitch(GetGameplayCamRelativePitch() + recoil, 0.8)
                end
            end
        else
            SetWeaponDamageModifier(`WEAPON_FLASHLIGHT`, 0.1)   
            SetWeaponDamageModifier(`WEAPON_UNARMED`, 0.10+addUnarmedDamage)
        end
        Citizen.Wait(time)
	end
end)