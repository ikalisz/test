local QBCore = exports['qb-core']:GetCoreObject()
local hit, coords

local function RotationToDirection(rotation)
    local adjustedRotation = { 
		x = (math.pi / 180) * rotation.x, 
		y = (math.pi / 180) * rotation.y, 
		z = (math.pi / 180) * rotation.z 
	}
	local direction = {
		x = -math.sin(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)), 
		y = math.cos(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)), 
		z = math.sin(adjustedRotation.x)
	}
	return direction
end

local function GetAimingHit(distance)
	local cameraRotation = GetGameplayCamRot()
	local cameraCoord = GetGameplayCamCoord()
	local currentWeapon = GetCurrentPedWeaponEntityIndex(PlayerPedId())
	local coordsWeapon = GetEntityCoords(currentWeapon)

	local direction = RotationToDirection(cameraRotation)
	local destination = {
		x = cameraCoord.x + direction.x * distance, 
		y = cameraCoord.y + direction.y * distance, 
		z = cameraCoord.z + direction.z * distance
	}
	local _, hit, coords, _, _ = GetShapeTestResult(StartShapeTestRay(coordsWeapon.x, coordsWeapon.y, coordsWeapon.z, destination.x, destination.y, destination.z, 1, 0, 4))

    return hit, coords
end

-- HaveHitSomething Update
Citizen.CreateThread(function()
	while true do
		local ped = PlayerPedId()

		if IsPedArmed(ped, 4) then
			hit, coords = GetAimingHit(Config.HitDistance)
		else
			hit, coords = nil, nil
		end
		Citizen.Wait(Config.HitCheck)
	end
end)

-- X Drawing
Citizen.CreateThread(function()
	while true do
		local ped = PlayerPedId()
		if GetFollowPedCamViewMode() ~= 4 and IsPlayerFreeAiming(PlayerId()) then
			if coords ~= vector3(0.0, 0.0, 0.0) and coords ~= nil then
				DisablePlayerFiring(128, true)
				DrawText3Ds(coords.x, coords.y, coords.z, "❌", Config.Size)
			else
				Citizen.Wait(500)
			end
		end
		Citizen.Wait(1)
	end
end)

function DrawText3Ds(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    SetTextScale(0.25, 0.25)
    SetTextFont(0)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 2500
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 0, 0, 0, 75)
end
