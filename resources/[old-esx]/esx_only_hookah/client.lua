local shisha = {4037417364}
local shishaHasStarted = false
local distX, distY, distZ = 0, 0, 0
local buyad = false
local sessionStarted = false
local endCallback = false
local coreLoaded = false

local objeCoords = {
	{coords = vector3(-626.798, 232.3572, 81.881), spawn = false},

}

QBCore = nil
Citizen.CreateThread(function()
    while QBCore == nil do
        TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)
        Citizen.Wait(200)
	end
	coreLoaded = true
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1500)
		local playerPed = PlayerPedId()
		local playerCoords = GetEntityCoords(playerPed)
		for i=1, #objeCoords do
			if #(playerCoords - objeCoords[i].coords) < 50 then
				if not objeCoords[i].spawn then
					objeCoords[i].spawn = true
					TriggerEvent("only_hooka:spawn", objeCoords[i].coords)
				end
			else
				if objeCoords[i].spawn then
					objeCoords[i].spawn = false
					TriggerEvent("only_hooka:delete", objeCoords[i].coords)
				end
			end
		end
	end
end)

AddEventHandler('onResourceStop', function(resourceName)
	if (GetCurrentResourceName() == resourceName) then
		for i=1, #objeCoords do
			if objeCoords[i].spawn then
				objeCoords[i].spawn = true
				TriggerEvent("only_hooka:delete", objeCoords[i].coords)
			end
		end
	end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

		local ped = PlayerPedId()
		local pos = GetEntityCoords(ped)
		if coreLoaded then
			local closestShisha = GetClosestObjectOfType(pos.x, pos.y, pos.z, 1.0, 4037417364, false, false, false)
			local shishaPos = GetEntityCoords(closestShisha)
			local dist = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, shishaPos.x, shishaPos.y, shishaPos.z, true)

			if dist < 3.5 then
				local loc = vector3(shishaPos.x, shishaPos.y, shishaPos.z)
				
				if not buyad then
					QBCore.Functions.DrawText3D(shishaPos.x, shishaPos.y, shishaPos.z, "[~y~E~w~] Start Smoking Hookah (20$)")
				end

				-- Start Session
				if not sessionStarted then
					if IsControlJustReleased(0, 38) then
						buyad = true
						sessionStarted = true
						endCallback = true
						ShishaFunctions()
						TriggerEvent("shisha:anim")
						FreezeEntityPosition(ped, true)

						local playerPed  = PlayerPedId()
						local coords     = GetEntityCoords(playerPed)
						local boneIndex  = GetPedBoneIndex(playerPed, 12844)
						local boneIndex2 = GetPedBoneIndex(playerPed, 24818)

						QBCore.Functions.SpawnObject('v_corp_lngestoolfd', {
							x = coords.x+0.5,
							y = coords.y+0.1,
							z = coords.z+0.4
						}, function(schlauch)
							AttachEntityToEntity(schlauch, playerPed, boneIndex2, -0.43, 0.68, 0.18, 0.0, 90.0, 90.0, true, true, false, true, 1, true)
							hookaschlauch = schlauch
							helmet = true
						end)
						
						TriggerServerEvent("shisha:pay")
						
						while sessionStarted do
							QBCore.Functions.DrawText3D(shishaPos.x, shishaPos.y, shishaPos.z+0.3, "~b~\"H\" - ~w~Inhale Hookah Smoke!")
							QBCore.Functions.DrawText3D(loc.x, loc.y, loc.z, "~b~\"F\" ~w~Stop Smoking Hookah!")
							DisableControlAction(0, 32, true) -- W
							DisableControlAction(0, 34, true) -- A
							DisableControlAction(0, 31, true) -- S
							DisableControlAction(0, 30, true) -- D
							DisableControlAction(0, 232, true) -- W
							Citizen.Wait(0)
						end

					end
				end
			else
				Citizen.Wait(1000)
			end
		end
    end
end)

local lastPressH = GetGameTimer()
function ShishaFunctions()
	Citizen.CreateThread(function()
		while sessionStarted do
			local ped = PlayerPedId()
			if IsControlJustPressed(0, 74) then -- Normal: H
				if GetGameTimer() > lastPressH then
					lastPressH = GetGameTimer() + 5000
					TriggerServerEvent("eff_smokes", GetEntityCoords(ped))
				else
					QBCore.Functions.Notify("Wait for a while.", "error")
				end
			end
			
			if IsControlJustReleased(0, 23) then -- Normal: F
				if endCallback == true then
					sessionStarted = false
					buyad = false
					QBCore.Functions.DeleteObject(hookaschlauch)
					FreezeEntityPosition(ped, false)
					ClearPedTasks(ped)
					endCallback = false
				end
			end
			Citizen.Wait(0)
		end
	end)
end

AddEventHandler("shisha:anim", function(source)
	local ped = PlayerPedId()
	local ad = "anim@heists@humane_labs@finale@keycards"
	local anim = "ped_a_enter_loop"
	while (not HasAnimDictLoaded(ad)) do
		RequestAnimDict(ad)
		Wait(1)
	end
	TaskPlayAnim(ped, ad, anim, 8.00, -8.00, -1, (2 + 16 + 32), 0.00, 0, 0, 0)
end)

RegisterNetEvent("c_eff_smokes")
AddEventHandler("c_eff_smokes", function(coords)
	if #(coords - GetEntityCoords(PlayerPedId())) < 150 then
		SetPtfxAssetNextCall("core")
		local Smoke = StartParticleFxLoopedAtCoord("exp_grd_bzgas_smoke", coords.x,coords.y, coords.z+0.5, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
		SetParticleFxLoopedAlpha(Smoke, 1.0)
		SetParticleFxLoopedColour(Smoke, 255.0, 255.0, 255.0, 0)
		Citizen.Wait(4000)
		StopParticleFxLooped(Smoke, 0)
	end
end)

RegisterNetEvent("only_hooka:delete")
AddEventHandler("only_hooka:delete", function(coords)
	local closestShisha = GetClosestObjectOfType(coords.x, coords.y, coords.z, 1.0, 4037417364, false, false, false)
	QBCore.Functions.DeleteObject(closestShisha)
end)

RegisterNetEvent("only_hooka:spawn")
AddEventHandler("only_hooka:spawn", function(coords)
	QBCore.Functions.SpawnObject('prop_bong_01', {
		x = coords.x,
		y = coords.y,
		z = coords.z-0.8
	})
end)