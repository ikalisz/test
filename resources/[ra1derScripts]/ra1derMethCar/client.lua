local QBCore = exports['qb-core']:GetCoreObject()

local started = false
local progress = 0
local pause = false
local quality = 0

RegisterNetEvent('ra1derMethCar:stop')
AddEventHandler('ra1derMethCar:stop', function()
	LastVehicle = QBCore.Functions.GetClosestVehicle()
	started = false
	progress = 0
	QBCore.Functions.Notify("Meth cooking stopped.", "error")
	FreezeEntityPosition(LastVehicle, false)
end)

RegisterNetEvent('ra1derMethCar:notify')
AddEventHandler('ra1derMethCar:notify', function(message)
	QBCore.Functions.Notify(message)
end)

RegisterNetEvent('ra1derMethCar:startprod')
AddEventHandler('ra1derMethCar:startprod', function()
	CurrentVehicle = GetVehiclePedIsUsing(PlayerPedId(-1))
	started = true
	pause = false
	FreezeEntityPosition(CurrentVehicle, true)
	QBCore.Functions.Notify("Meth cooking process started", "success")
end)

RegisterNetEvent('ra1derMethCar:smoke')
AddEventHandler('ra1derMethCar:smoke', function(posx, posy, posz, bool)
	if bool == 'a' then
		if not HasNamedPtfxAssetLoaded("core") then
			RequestNamedPtfxAsset("core")
			while not HasNamedPtfxAssetLoaded("core") do
				Citizen.Wait(1)
			end
		end
		SetPtfxAssetNextCall("core")
		local smoke = StartParticleFxLoopedAtCoord("exp_grd_bzgas_smoke", posx, posy, posz + 1.6, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
		SetParticleFxLoopedAlpha(smoke, 0.9)
		Citizen.Wait(60000)
		StopParticleFxLooped(smoke, 0)
	else
		StopParticleFxLooped(smoke, 0)
	end
end)

-------------------------------------------------------EVENTS NEGATIVE
RegisterNetEvent('ra1derMethCar:boom', function()
	playerPed = (PlayerPedId())
	local pos = GetEntityCoords((PlayerPedId()))
	pause = false
	Citizen.Wait(500)
	started = false
	Citizen.Wait(500)
	CurrentVehicle = GetVehiclePedIsUsing(PlayerPedId(-1))
	TriggerServerEvent('ra1derMethCar:blow', pos.x, pos.y, pos.z)
	TriggerEvent('ra1derMethCar:stop')
end)

RegisterNetEvent('ra1derMethCar:blowup')
AddEventHandler('ra1derMethCar:blowup', function(posx, posy, posz)
	AddExplosion(posx, posy, posz + 2, 15, 20.0, true, false, 1.0, true)
	if not HasNamedPtfxAssetLoaded("core") then
		RequestNamedPtfxAsset("core")
		while not HasNamedPtfxAssetLoaded("core") do
			Citizen.Wait(1)
		end
	end
	SetPtfxAssetNextCall("core")
	local fire = StartParticleFxLoopedAtCoord("ent_ray_heli_aprtmnt_l_fire", posx, posy, posz-0.8 , 0.0, 0.0, 0.0, 0.8, false, false, false, false)
	Citizen.Wait(6000)
	StopParticleFxLooped(fire, 0)	
end)

RegisterNetEvent('ra1derMethCar:drugged')
AddEventHandler('ra1derMethCar:drugged', function()
	local pos = GetEntityCoords((PlayerPedId()))
	SetTimecycleModifier("drug_drive_blend01")
	SetPedMotionBlur((PlayerPedId()), true)
	SetPedMovementClipset((PlayerPedId()), "MOVE_M@DRUNK@SLIGHTLYDRUNK", true)
	SetPedIsDrunk((PlayerPedId()), true)
	quality = quality - 3
	pause = false
	Citizen.Wait(90000)
	ClearTimecycleModifier()
	TriggerServerEvent('ra1derMethCar:make', pos.x,pos.y,pos.z)
end)

RegisterNetEvent('ra1derMethCar:q-1police', function(data)
	local pos = GetEntityCoords((PlayerPedId()))
	QBCore.Functions.Notify(data.message, "error")
	quality = quality - 1
	pause = false
	TriggerServerEvent('police:server:policeAlert', 'Person reports stange smell!')
	TriggerServerEvent('ra1derMethCar:make', pos.x,pos.y,pos.z)
end)

RegisterNetEvent('ra1derMethCar:q-1', function(data)
	local pos = GetEntityCoords((PlayerPedId()))
	QBCore.Functions.Notify(data.message, "error")
	quality = quality - 1
	pause = false
	TriggerServerEvent('ra1derMethCar:make', pos.x,pos.y,pos.z)
end)

RegisterNetEvent('ra1derMethCar:q-3', function(data)
	local pos = GetEntityCoords((PlayerPedId()))
	QBCore.Functions.Notify(data.message, "error")
	quality = quality - 3
	pause = false
	TriggerServerEvent('ra1derMethCar:make', pos.x,pos.y,pos.z)
end)

RegisterNetEvent('ra1derMethCar:q-5', function(data)
	local pos = GetEntityCoords((PlayerPedId()))
	QBCore.Functions.Notify(data.message, "error")
	quality = quality - 5
	pause = false
	TriggerServerEvent('ra1derMethCar:make', pos.x,pos.y,pos.z)
end)

-------------------------------------------------------EVENTS POSITIVE
RegisterNetEvent('ra1derMethCar:q2', function(data)
	local pos = GetEntityCoords((PlayerPedId()))
	QBCore.Functions.Notify(data.message, "success")
	quality = quality + 2
	pause = false
	TriggerServerEvent('ra1derMethCar:make', pos.x,pos.y,pos.z)
end)

RegisterNetEvent('ra1derMethCar:q3', function(data)
	local pos = GetEntityCoords((PlayerPedId()))
	QBCore.Functions.Notify(data.message, "success")
	quality = quality + 3
	pause = false
	TriggerServerEvent('ra1derMethCar:make', pos.x,pos.y,pos.z)
end)

RegisterNetEvent('ra1derMethCar:q5', function(data)
	local pos = GetEntityCoords((PlayerPedId()))
	QBCore.Functions.Notify(data.message, "success")
	quality = quality + 5
	pause = false
	TriggerServerEvent('ra1derMethCar:make', pos.x,pos.y,pos.z)
end)

RegisterNetEvent('ra1derMethCar:gasmask', function(data)
	local pos = GetEntityCoords((PlayerPedId()))
	QBCore.Functions.Notify(data.message, "success")
	SetPedPropIndex(playerPed, 1, 26, 7, true)
	quality = quality + 2
	pause = false
	TriggerServerEvent('ra1derMethCar:make', pos.x,pos.y,pos.z)
end)

RegisterNetEvent('ra1derMethCar:cook', function()
	playerPed = (PlayerPedId())
	local pos = GetEntityCoords(playerPed)
	local CurrentVehicle = QBCore.Functions.GetClosestVehicle()
	if pos.y >= 2000 then
		if IsVehicleSeatFree(CurrentVehicle, 3) and IsVehicleSeatFree(CurrentVehicle, -1) and IsVehicleSeatFree(CurrentVehicle, 0) and IsVehicleSeatFree(CurrentVehicle, 1)and IsVehicleSeatFree(CurrentVehicle, 2) then
			TaskWarpPedIntoVehicle(PlayerPedId(), CurrentVehicle, 3)
			SetVehicleDoorOpen(CurrentVehicle, 2)
			Wait(300)
			TriggerServerEvent('ra1derMethCar:start')
			TriggerServerEvent('ra1derMethCar:make', pos.x,pos.y,pos.z)
			Wait(1000)
			quality = 0
		else
			QBCore.Functions.Notify("Someone in fuck? :D", "error")
		end
	else
		QBCore.Functions.Notify("You're too close to the city, try cooking far away.", "error")
	end
end)

---------EVENTS------------------------------------------------------

RegisterNetEvent('ra1derMethCar:proses', function()
	--
	--   EVENT 1
	--
	if progress > 9 and progress < 11 then
		pause = true
		exports['qb-menu']:openMenu({
			{
				header = "Gas tank is leaking, what will you do now?",
				icon = "fas fa-info",
				txt = "Choose your answer, your progress: " .. progress .. "%",
				isMenuHeader = true,
			},
			{
				header = "Try to cover it with tape",
				icon = "fas fa-circle",
				params = {
					event = "ra1derMethCar:q-3",
					args = {
						message = "Looks like it's fixed, I guess?!"
					}
				}
			},
			{
				header = "Never mind",
				icon = "fas fa-circle",
				params = {
					event = "ra1derMethCar:boom"
				}
			},
			{
				header = "Refresh the tank",
				icon = "fas fa-circle",
				params = {
					event = "ra1derMethCar:q5",
					args = {
						message = "I think that was the best idea!!!"
					}
				}
			},
		})
	end
	--
	--   EVENT 2
	if progress > 19 and progress < 21 then
		pause = true
		exports['qb-menu']:openMenu({
			{
				header = "You spilled some acetone on the floor, what are you going to do now?",
				icon = "fas fa-info",
				txt = "Choose your answer, your progress: " .. progress .. "%",
				isMenuHeader = true,
			},
			{
				header = "Open the window",
				icon = "fas fa-circle",
				params = {
					event = "ra1derMethCar:q-1police",
					args = {
						message = "The smell has spread out, someone can understand..."
					}
				}
			},
			{
				header = "Keep breathing",
				icon = "fas fa-circle",
				params = {
					event = "ra1derMethCar:drugged"
				}
			},
			{
				header = "Wear gas mask",
				icon = "fas fa-circle",
				params = {
					event = "ra1derMethCar:gasmask",
					args = {
						message = "Good idea!"
					}
				}
			},
		})
	end
	--
	--   EVENT 3
	--
	if progress > 29 and progress < 31 then
		pause = true
		exports['qb-menu']:openMenu({
			{
				header = "Meth concentration is starting to drop, what are you going to do?",
				icon = "fas fa-info",
				txt = "Choose your answer, your progress: " .. progress .. "%",
				isMenuHeader = true,
			},
			{
				header = "Increase the temperature",
				icon = "fas fa-circle",
				params = {
					event = "ra1derMethCar:q5",
					args = {
						message = "Increasing the temperature balanced it out perfectly!"
					}
				}
			},
			{
				header = "increase pressure",
				icon = "fas fa-circle",
				params = {
					event = "ra1derMethCar:q-3",
					args = {
						message = "The pressure started to fluctuate"
					}
				}
			},
			{
				header = "Reduce pressure",
				icon = "fas fa-circle",
				params = {
					event = "ra1derMethCar:q-5",
					args = {
						message = "Oh that was a bad idea..."
					}
				}
			},
		})
	end
	--
	--   EVENT 4
	--
	if progress > 39 and progress < 41 then
		pause = true
		exports['qb-menu']:openMenu({
			{
				header = "You accidentally added too much acetone, what will you do?",
				icon = "fas fa-info",
				txt = "Choose your answer, your progress: " .. progress .. "%",
				isMenuHeader = true,
			},
			{
				header = "Do nothing",
				icon = "fas fa-circle",
				params = {
					event = "ra1derMethCar:q-5",
					args = {
						message = "Meth is starting to smell like pure acetone"
					}
				}
			},
			{
				header = "Try to pipe it",
				icon = "fas fa-circle",
				params = {
					event = "ra1derMethCar:drugged"
				}
			},
			{
				header = "Add methylamine to stabilize",
				icon = "fas fa-circle",
				params = {
					event = "ra1derMethCar:q5",
					args = {
						message = "Wisely..."
					}
				}
			},
		})
	end
	--
	--   EVENT 5
	--
	if progress > 49 and progress < 51 then
		pause = true
		exports['qb-menu']:openMenu({
			{
				header = "Blue pigments are starting to form, what are you going to do?",
				icon = "fas fa-info",
				txt = "Blue pigments are starting to form, what are you going to do? : " .. progress .. "%",
				isMenuHeader = true,
			},
			{
				header = "Add it to the mix!",
				icon = "fas fa-circle",
				params = {
					event = "ra1derMethCar:q5",
					args = {
						message = "Clever, people will love it!"
					}
				}
			},
			{
				header = "Dispose",
				icon = "fas fa-circle",
				params = {
					event = "ra1derMethCar:q-1",
					args = {
						message = "You don't seem very creative...."
					}
				}
			},
		})
	end
	--
	--   EVENT 6
	--
	if progress > 59 and progress < 61 then
		pause = true
		exports['qb-menu']:openMenu({
			{
				header = "The filter is dirty, what will you do now??",
				icon = "fas fa-info",
				txt = "Choose your answer, your progress: " .. progress .. "%",
				isMenuHeader = true,
			},
			{
				header = "Clean with air compressor",
				icon = "fas fa-circle",
				params = {
					event = "ra1derMethCar:q-5",
					args = {
						message = "You messed up the product!"
					}
				}
			},
			{
				header = "Refresh filter",
				icon = "fas fa-circle",
				params = {
					event = "ra1derMethCar:q5",
					args = {
						message = "it was the best decision"
					}
				}
			},
			{
				header = "Clean with brush",
				icon = "fas fa-circle",
				params = {
					event = "ra1derMethCar:q-1",
					args = {
						message = "It worked but not enough..."
					}
				}
			},
		})
	end
	--
	--   EVENT 7
	--
	if progress > 69 and progress < 71 then
		pause = true
		exports['qb-menu']:openMenu({
			{
				header = "You spilled some acetone on the floor, what are you going to do now? ?",
				icon = "fas fa-info",
				txt = "Choose your answer, your progress: " .. progress .. "%",
				isMenuHeader = true,
			},
			{
				header = "keep breathing",
				icon = "fas fa-circle",
				params = {
					event = "ra1derMethCar:drugged"
				}
			},
			{
				header = "wear gas mask",
				icon = "fas fa-circle",
				params = {
					event = "ra1derMethCar:gasmask",
					args = {
						message = "Good choice"
					}
				}
			},
			{
				header = "Good choice",
				icon = "fas fa-circle",
				params = {
					event = "ra1derMethCar:q-1police",
					args = {
						message = "The smell must have gone to the people around..."
					}
				}
			},
		})
	end
	--
	--   EVENT 8
	--
	if progress > 79 and progress < 81 then
		pause = true
		exports['qb-menu']:openMenu({
			{
				header = "Gas tank is leaking, what will you do?",
				icon = "fas fa-info",
				txt = "Choose your answer, your progress: " .. progress .. "%",
				isMenuHeader = true,
			},
			{
				header = "Nevermind",
				icon = "fas fa-circle",
				params = {
					event = "ra1derMethCar:boom"
				}
			},
			{
				header = "Fix it with tape",
				icon = "fas fa-circle",
				params = {
					event = "ra1derMethCar:q-3",
					args = {
						message = "That should have worked, I guess?!"
					}
				}
			},
			{
				header = "change tank",
				icon = "fas fa-circle",
				params = {
					event = "ra1derMethCar:q5",
					args = {
						message = "it was the best idea!"
					}
				}
			},
		})
	end
	--
	--   EVENT 9
	--
	if progress > 89 and progress < 91 then
		pause = true
		exports['qb-menu']:openMenu({
			{
				header = "You have too many toilets, what will you do?",
				icon = "fas fa-info",
				txt = "Choose your answer, your progress: " .. progress .. "%",
				isMenuHeader = true,
			},
			{
				header = "Sabret ve tuvaletini tut",
				icon = "fas fa-circle",
				params = {
					event = "ra1derMethCar:q5",
					args = {
						message = "Good job!"
					}
				}
			},
			{
				header = "Go outside and go to the toilet",
				icon = "fas fa-circle",
				params = {
					event = "ra1derMethCar:q-1police",
					args = {
						message = "Someone noticed you doing questionable things"
					}
				}
			},
			{
				header = "Let it go",
				icon = "fas fa-circle",
				params = {
					event = "ra1derMethCar:q-5",
					args = {
						message = "Ah, that's not good. Everything smells like shit"
					}
				}
			},
		})
	end
	--
	--   DONE
	--	
	if progress > 99 and progress < 101 then
		pause = true
		exports['qb-menu']:openMenu({
			{
				header = "Cooking Complete",
				icon = "fas fa-info",
				txt = "" .. progress .. "%",
				isMenuHeader = true,
			},
			{
				header = "Bag Meths",
				icon = "fas fa-shopping-bag",
				params = {
					event = "ra1derMethCar:done",
					args = {
						message = ""
					}
				}
			}
		})
	end
end)

RegisterNetEvent('ra1derMethCar:done', function()
	quality = quality + 3
	started = false
	TriggerEvent('ra1derMethCar:stop')
	QBCore.Functions.Progressbar('name', 'Meths Are Packed', 500 * quality, false, false, { -- Name | Label | Time | useWhileDead | canCancel
		disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
	}, {
		animDict = 'anim@gangops@facility@servers@',
		anim = 'hotwire',
		flags = 16,
	}, {}, {}, function() -- Play When Done
		TriggerServerEvent('ra1derMethCar:finish', quality)
		SetPedPropIndex(playerPed, 1, 0, 0, true)
		--Stuff goes here
	end, function() -- Play When Cancel
		--Stuff goes here
	end)
end)

-----THREADS------------------------------------------------------------------------------

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(300)
		if started == true then
			if pause == false and IsPedInAnyVehicle(playerPed) then
				Citizen.Wait(350)
				progress = progress +  1
				quality = quality + 1
				QBCore.Functions.Notify('Meth Production : ' .. progress .. '%')
				TriggerEvent('ra1derMethCar:proses')
				Citizen.Wait(2000)
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		if IsPedInAnyVehicle((PlayerPedId())) then
		else
			if started then
				playerPed = (PlayerPedId())
				CurrentVehicle = GetVehiclePedIsUsing(PlayerPedId(-1))
				pause = true
				started = false
				TriggerEvent('ra1derMethCar:stop')
				SetPedPropIndex(playerPed, 1, 0, 0, true)
				FreezeEntityPosition(CurrentVehicle, false)
			end
		end
	end
end)




