local isSentenced = false
local communityServiceFinished = false
local actionsRemaining = 0
local availableActions = {}
local disable_actions = false
local islemdeyim = false

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
	TriggerEvent("esx_communityservice:inCommunityService", PlayerData.metadata.communityservice)
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload')
AddEventHandler('QBCore:Client:OnPlayerUnload', function()
    PlayerData = {}
end)

function FillActionTable(last_action)
	while #availableActions < 5 do
		local service_does_not_exist = true

		local random_selection = Config.ServiceLocations[math.random(1,#Config.ServiceLocations)]

		for i = 1, #availableActions do
			if random_selection.coords.x == availableActions[i].coords.x and random_selection.coords.y == availableActions[i].coords.y and random_selection.coords.z == availableActions[i].coords.z then
				service_does_not_exist = false
			end
		end

		if last_action ~= nil and random_selection.coords.x == last_action.coords.x and random_selection.coords.y == last_action.coords.y and random_selection.coords.z == last_action.coords.z then
			service_does_not_exist = false
		end

		if service_does_not_exist then
			table.insert(availableActions, random_selection)
		end
	end
end

RegisterNetEvent('esx_communityservice:inCommunityService')
AddEventHandler('esx_communityservice:inCommunityService', function(actions_remaining)
	if isSentenced or actions_remaining == 0 then
		return
	end
	actionsRemaining = tonumber(actions_remaining)

	FillActionTable()
    SendNUIMessage({type = 'open', text = QBCore.Shared.Round(actionsRemaining)..' public duty left..'})

	SetEntityCoords(PlayerPedId(), Config.ServiceLocation)
	isSentenced = true
	communityServiceFinished = false

	while actionsRemaining > 0 and not communityServiceFinished do
		local playerPed = PlayerPedId()
		local mesafe = #(GetEntityCoords(playerPed) - Config.ServiceLocation)
		if mesafe > 45 then
			if IsPedInAnyVehicle(playerPed, false) then
				ClearPedTasksImmediately(playerPed)
			end
			SetEntityCoords(playerPed, Config.ServiceLocation)
			TriggerServerEvent('esx_communityservice:extendService')
			actionsRemaining = actionsRemaining + Config.ServiceExtensionOnEscape
			SendNUIMessage({type = 'update', text = QBCore.Shared.Round(actionsRemaining)..' public duty left.'})
			QBCore.Functions.Notify("You were forcibly brought back and sentenced to 5 additional penalties for trying to evade public punishment")
		end
		Citizen.Wait(20000)
	end

	TriggerServerEvent('esx_communityservice:finishCommunityService', QBCore.Key)

	isSentenced = false
end)

RegisterNetEvent('esx_communityservice:finishCommunityService')
AddEventHandler('esx_communityservice:finishCommunityService', function(source)
	communityServiceFinished = true
	isSentenced = false
	SendNUIMessage({type = "close"})

	actionsRemaining = 0
end)

RegisterNetEvent("comServUI:set", function(text, bool)
	if bool == "araba" then 
		SendNUIMessage({type = 'open', text = text})
	else
		if bool then
			SendNUIMessage({type = 'update', text = text})
		else
			SendNUIMessage({type = "close"})
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		local time = 3000
		if actionsRemaining > 0 and isSentenced and not islemdeyim then
			time = 1
			DrawAvailableActions()
			DisableViolentActions()

			local pCoords = GetEntityCoords(PlayerPedId())

			for i = 1, #availableActions do
				local distance = GetDistanceBetweenCoords(pCoords, availableActions[i].coords, true)

				if distance < 1 then
					QBCore.Functions.DrawText3D(pCoords.x,pCoords.y,pCoords.z, "[~g~E~w~] - Clean")

					if(IsControlJustReleased(1, 38))then
						tmp_action = availableActions[i]
						islemdeyim = true

						TriggerServerEvent('esx_communityservice:completeService', QBCore.Key)

						if (tmp_action.type == "temizleme") then
							QBCore.Functions.Progressbar("yer", "You're Cleaning the Floor..", 10000, false, true, { -- p1: menu name, p2: yazı, p3: ölü iken kullan, p4:iptal edilebilir
								disableMovement = true,
								disableCarMovement = false,
								disableMouse = false,
								disableCombat = false,
							}, {
								animDict = 'amb@world_human_janitor@male@idle_a',
								anim = 'idle_a',
								flags = 0,
							}, { -- prop1
								model = "prop_tool_broom",
								bone = 28422,
								coords = { x = -0.005, y = 0.0, z = 0.0 },
								rotation = { x = 360.0, y = 360.0, z = 0.0 }, 
							}, {}, function() -- Done
								RemoveAction(tmp_action)
								FillActionTable(tmp_action)
								actionsRemaining = actionsRemaining - 1
								TriggerServerEvent('esx_communityservice:completeService', QBCore.Key)
                                if actionsRemaining > 0 then
                                    SendNUIMessage({type = 'update', text = QBCore.Shared.Round(actionsRemaining)..' public duty left.'})
								elseif actionsRemaining == 0 then
									QBCore.Functions.Notify("You have completed your public sentence")
									SendNUIMessage({type = "close"})
								end
								islemdeyim = false
							end, function() -- Cancel
								islemdeyim = false
							end)
						end

						if (tmp_action.type == "bahçe") then
							QBCore.Functions.Progressbar("yabani", "You're clearing weeds..", 8500, false, true, { -- p1: menu name, p2: yazı, p3: ölü iken kullan, p4:iptal edilebilir
								disableMovement = true,
								disableCarMovement = false,
								disableMouse = false,
								disableCombat = false,
							}, {
								animDict = 'anim@amb@clubhouse@tutorial@bkr_tut_ig3@',
								anim = 'machinic_loop_mechandplayer',
							}, {}, {}, function() -- Done
								RemoveAction(tmp_action)
								FillActionTable(tmp_action)
								actionsRemaining = actionsRemaining - 1
								TriggerServerEvent('esx_communityservice:completeService', QBCore.Key)
                                if actionsRemaining > 0 then
                                    SendNUIMessage({type = 'update', text = QBCore.Shared.Round(actionsRemaining)..'public duty left'})
								elseif actionsRemaining == 0 then
									QBCore.Functions.Notify("You have completed your public sentence")
									SendNUIMessage({type = "close"})
								end
								islemdeyim = false
							end, function() -- Cancel
								islemdeyim = false
							end)
						end
					end
				end
			end
		end
		Citizen.Wait(time)
	end
end)

function RemoveAction(action)
	local action_pos = -1

	for i=1, #availableActions do
		if action.coords.x == availableActions[i].coords.x and action.coords.y == availableActions[i].coords.y and action.coords.z == availableActions[i].coords.z then
			action_pos = i
		end
	end

	if action_pos ~= -1 then
		table.remove(availableActions, action_pos)
	end
end

function DrawAvailableActions()
	for i = 1, #availableActions do
		DrawMarker(21, availableActions[i].coords, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 50, 50, 204, 100, false, true, 2, true, false, false, false)
	end
end

function DisableViolentActions()
	local playerPed = PlayerPedId()
	RemoveAllPedWeapons(playerPed, true)

	DisableControlAction(2, 37, true) -- disable weapon wheel (Tab)
	DisablePlayerFiring(playerPed,true) -- Disables firing all together if they somehow bypass inzone Mouse Disable
    DisableControlAction(0, 106, true) -- Disable in-game mouse controls
    DisableControlAction(0, 140, true)
	DisableControlAction(0, 141, true)
	DisableControlAction(0, 142, true)

	if IsDisabledControlJustPressed(2, 37) then --if Tab is pressed, send error message
		SetCurrentPedWeapon(playerPed,`WEAPON_UNARMED`,true) -- if tab is pressed it will set them to unarmed (this is to cover the vehicle glitch until I sort that all out)
	end

	if IsDisabledControlJustPressed(0, 106) then --if LeftClick is pressed, send error message
		SetCurrentPedWeapon(playerPed,`WEAPON_UNARMED`,true) -- If they click it will set them to unarmed
	end
end
