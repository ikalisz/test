local clientcooldown = GetGameTimer()
isdead = false
inInventory = false
PlayerData = {}

QBCore = nil
Citizen.CreateThread(function()
    while QBCore == nil do
        TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)
        Citizen.Wait(200)
    end
end)

AddEventHandler('tgiann:playerdead', function(dead) 
	isdead = dead
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    PlayerData = QBCore.Functions.GetPlayerData()
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate')
AddEventHandler('QBCore:Client:OnJobUpdate', function(job)
    PlayerData.job = job
end)

function IsAbleToSteal(targetSID, err)
	QBCore.Functions.TriggerCallback('esx_thief:getValue', function(result)
		local result = result
		if result.value then
			err(false)
		else
			err(true)
		end
	end, targetSID)
end

RegisterNetEvent('tgiann-thief:SteelMoney')
AddEventHandler('tgiann-thief:SteelMoney', function(targetId, money)
	local ped = PlayerPedId()
	if (IsPedOnFoot(ped) or PlayerData.job.name == "police") and not isdead then
		QBCore.Functions.TriggerCallback('elixir-base:xplayer-kullanici-bilgi', function(data) 
			if IsPedArmed(ped, 7) then
				IsAbleToSteal(targetId, function(err)	
					if not err or data.is_dead or PlayerData.job.name == "police" then
						FreezeEntityPosition(targetId, true)
						QBCore.Functions.Progressbar("yarali_ust_arama", "You Are Looking For The Top Of The Person", 5000, false, true, { -- p1: menu name, p2: yazı, p3: ölü iken kullan, p4:iptal edilebilir
							disableMovement = true,
							disableCarMovement = true,
							disableMouse = false,
							disableCombat = true,
						}, {
							animDict = "missexile3",
							anim = "ex03_dingy_search_case_base_michael",
							flags = 49,
						}, {}, {}, function() -- Done
							local input = exports['qb-input']:ShowInput({
								header = "On Player" ..money.. "$ Have Money",
								inputs = {
									{
										type = 'number',
										isRequired = true,
										name = 'amount',
										text = 'Enter the amount of money you want to steal'
									},
								},
							})
							if input ~= nil then 
								if tonumber(input.amount) > 0 then 
									if tonumber(input.amount) > money then return QBCore.Functions.Notify("The value you entered is more than the player's money") end 
									QBCore.Functions.Progressbar('name', 'You Take The Money...', 5000, false, true, { -- Name | Label | Time | useWhileDead | canCancel
										disableMovement = true,
										disableCarMovement = true,
										disableMouse = false,
										disableCombat = true,
									}, {
										animDict = "missexile3",
										anim = "ex03_dingy_search_case_base_michael",
										flags = 49,
									}, {}, {}, function() -- Play When Done
										TriggerServerEvent("tgiann-thief:server:stellMoney", targetId, tonumber(input.amount), QBCore.Key)
									end)
								end
							else	
							end	
						end, function() -- Cancel
						end)
					else
						QBCore.Functions.Notify("Player's Hands Are Not Up")
					end
				end)
			else
				QBCore.Functions.Notify("They Must Have A Gun!")
			end
		end, targetId)
		
	else
		QBCore.Functions.Notify("You cannot use this command while lying on the ground or dead.!")
	end
end)

Citizen.CreateThread(function()
	RegisterKeyMapping('+searchPlayer', 'Search Player', 'keyboard', 'g')
end)

RegisterCommand('+searchPlayer', function()
	if not exports["high_phone"]:phoneIsOpen() then 
		if not IsPedInAnyVehicle(PlayerPedId()) then
			if not isdead then
				local ped = PlayerPedId()
				local target, distance = QBCore.Functions.GetClosestPlayer()
				local target_id = GetPlayerServerId(target)
				local polisemesaj = math.random(1,3)

				-- Kelepçeli Adamın Üstünü Arama
				if GetGameTimer() > clientcooldown then
					if IsPedOnFoot(ped)   then
						clientcooldown = GetGameTimer() + 3000
						if target ~= -1 and distance <= 2.0 then
							QBCore.Functions.TriggerCallback('elixir-base:xplayer-kullanici-bilgi', function(data) 
								if PlayerData.job ~= nil and PlayerData.job.name ~= 'unemployed' and PlayerData.job.name == "police" then
									if data.is_dead == true then
										QBCore.Functions.Progressbar("yarali_ust_arama", "Searching for the Wounded", 15000, false, true, { -- p1: menu name, p2: yazı, p3: ölü iken kullan, p4:iptal edilebilir
											disableMovement = true,
											disableCarMovement = true,
											disableMouse = false,
											disableCombat = true,
										}, {
											animDict = "missexile3",
											anim = "ex03_dingy_search_case_base_michael",
											flags = 49,
										}, {}, {}, function() -- Done
											TriggerServerEvent("tgiann:ust-ara-bildirim-polis", target_id)
											QBCore.Functions.Notify('Looking For Someones Top!')
											TriggerServerEvent("inventory:server:OpenInventory", "otherplayer", target_id)
											TriggerServerEvent("tgiann-oyuncu-soygun:discord-log-polis", target_id, GetPlayerServerId(PlayerId()))
										end, function() -- Cancel
										end)

									else
										TriggerServerEvent("tgiann:ust-ara-bildirim-polis", target_id)
										QBCore.Functions.Notify('Looking For Someones Top!')
										TriggerServerEvent("inventory:server:OpenInventory", "otherplayer", target_id)
										TriggerServerEvent("tgiann-oyuncu-soygun:discord-log-polis", target_id, GetPlayerServerId(PlayerId()))
									end
									
								elseif IsPedArmed(ped, 7) and data.is_dead == false and (data.kelepce == "1" or data.pkelepce == "1") then	
									TriggerServerEvent("tgiann:ust-ara-bildirim", target_id)
									QBCore.Functions.Notify('Looking For Someones Top!')
									TriggerServerEvent("inventory:server:OpenInventory", "otherplayer", target_id)
									TriggerServerEvent("tgiann-oyuncu-soygun:discord-log", target_id, GetPlayerServerId(PlayerId()))
									if polisemesaj == 1 then
										bildirim()
									end 
							
								-- Elleri Havada Adamın Üstünü Arama
								elseif IsPedArmed(ped, 7) and data.is_dead == false then
									IsAbleToSteal(target_id, function(err)	
										if(not err)then
											inInventory = true
											TriggerServerEvent("tgiann:ust-ara-bildirim", target_id)
											QBCore.Functions.Notify('Looking For Someones Top!')
											TriggerServerEvent("inventory:server:OpenInventory", "otherplayer", target_id)
											TriggerServerEvent("tgiann-oyuncu-soygun:discord-log", target_id, GetPlayerServerId(PlayerId()))
											if polisemesaj == 1 then
												bildirim()
											end 
										else
											QBCore.Functions.Notify("Target's Hands Are Not Up")
										end
									end)

								-- Ölü Adamın Üstünü Arama
								elseif data.is_dead == true then
									TriggerServerEvent("tgiann:ust-ara-bildirim", target_id)
									TriggerServerEvent("tgiann-oyuncu-soygun:discord-log", target_id, GetPlayerServerId(PlayerId()))
									local playerPed = PlayerPedId()
									local playerCoords = GetEntityCoords(playerPed)

									local searchTime = 45000 
									if #(playerCoords - vector3(2448.037109375, 4983.23046875, 46.846790313721)) < 180 then --illegal ev1-2 kordinatları
										searchTime = 5000
									end

									if polisemesaj == 1 and searchTime == 45000 then
										Citizen.CreateThread(function()
											Citizen.Wait(30000)
											bildirim()
										end)
									end 

									QBCore.Functions.Progressbar("yarali_ust_arama", "Searching for the Wounded", searchTime, false, true, { -- p1: menu name, p2: yazı, p3: ölü iken kullan, p4:iptal edilebilir
										disableMovement = true,
										disableCarMovement = true,
										disableMouse = false,
										disableCombat = true,
									}, {
										animDict = "missexile3",
										anim = "ex03_dingy_search_case_base_michael",
										flags = 49,
									}, {}, {}, function() -- Done
										TriggerServerEvent("inventory:server:OpenInventory", "otherplayer", target_id)
									end, function() -- Cancel
									end)
								end
							end, target_id)	
						elseif distance < 20 and distance > 2.0 then
							QBCore.Functions.Notify("You are too far away for this action!", 'error')
						else
							QBCore.Functions.Notify("No players found recently", 'error')
						end
					else
						QBCore.Functions.Notify('No One Near', 'error')
					end
				else
					QBCore.Functions.Notify('So Seriously You Cant Use This Command!', 'error')
				end
			else
				QBCore.Functions.Notify('you cant do this right now!', 'error')
			end
		end
	else
		QBCore.Functions.Notify('You cannot search a player while your phone is on.', 'error')
	end
end, false)

-- Citizen.CreateThread(function()

--     while true do

--         Citizen.Wait(100)

--         local ped = PlayerPedId()

--         if IsPedOnFoot(ped) and not IsPedSwimming(ped) and (IsPedRunning(ped) or IsPedSprinting(ped)) and not IsPedClimbing(ped) and IsPedJumping(ped) and not IsPedRagdoll(ped) then

--             local chance_result = math.random()

--             if chance_result < 0.50 then

--                 Citizen.Wait(600)

--                 SetPedToRagdoll(ped, 5000, 1, 2)

--             else

--                 Citizen.Wait(2000)

--             end

--         end

--     end

-- end)

function bildirim()  
    local ped = PlayerPedId()
    local playerPos = GetEntityCoords(ped)
    local id = math.random(25, 99)
    
    data = {
        id = id,
        code = 10-40,
        description = "They're Robbing Someone",
        location = GetTheStreet(),
        coords = playerPos,
        sprite = 110
    }   
    TriggerServerEvent("jtDispatch:add-notification", data, "police")
end

function GetTheStreet()
	local ZoneNames = exports["jtDispatch"]:bolgeler()
    local x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
    local currentStreetHash, intersectStreetHash = GetStreetNameAtCoord(x, y, z, currentStreetHash, intersectStreetHash)
    currentStreetName = GetStreetNameFromHashKey(currentStreetHash)
    intersectStreetName = GetStreetNameFromHashKey(intersectStreetHash)
    zone = tostring(GetNameOfZone(x, y, z))
    playerStreetsLocation = ZoneNames[tostring(zone)]

    if not zone then
        zone = "UNKNOWN"
        ZoneNames['UNKNOWN'] = zone
    elseif not ZoneNames[tostring(zone)] then
        local undefinedZone = zone .. " " .. x .. " " .. y .. " " .. z
        ZoneNames[tostring(zone)] = "Unknown Region"
    end

    if (intersectStreetName ~= nil and intersectStreetName ~= "") or (currentStreetName ~= nil and currentStreetName ~= "") then
        playerStreetsLocation = currentStreetName
    else
        playerStreetsLocation = ZoneNames[tostring(zone)]
    end

	return playerStreetsLocation
end

function GetStreetAndZone()
    local playerPed = PlayerPedId()
    local coords = GetEntityCoords(playerPed)
    local currentStreetHash, intersectStreetHash = GetStreetNameAtCoord(coords.x, coords.y, coords.z)
    local currentStreetName = GetStreetNameFromHashKey(currentStreetHash)
    local area = GetLabelText(tostring(GetNameOfZone(coords.x, coords.y, coords.z)))
    local playerStreetsLocation = area
    if not zone then zone = "UNKNOWN" end
    if currentStreetName ~= nil and currentStreetName ~= "" then playerStreetsLocation = currentStreetName .. ", " ..area
    else playerStreetsLocation = area end
    return playerStreetsLocation
end