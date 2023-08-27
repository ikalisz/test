local QBCore = exports['qb-core']:GetCoreObject()
local PlayerData, playerCoordsData, blips, activeBlips, carBlips = {}, {}, {}, {}, {}
local activeGps, activeCarBlip, policeBlip = false, false, false
local lastGpsText = ""



RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    PlayerData = QBCore.Functions.GetPlayerData()
end)

RegisterNetEvent("tgiann-infinity:update")
AddEventHandler("tgiann-infinity:update", function(data)
	playerCoordsData = data
end)

AddEventHandler('tgiann:playerdead', function(dead)
	if activeGps and dead then 
		TriggerServerEvent("tgiann-gps:acikgps-kapat", true)
	end
end)

RegisterNetEvent('tgiann-emerhencyblips:forceClose')
AddEventHandler('tgiann-emerhencyblips:forceClose', function()
	if activeGps then 
		TriggerServerEvent("tgiann-gps:acikgps-kapat", false)
	end
end)

RegisterNetEvent('ra1derEmergencyBlipss:updateAllData')
AddEventHandler('ra1derEmergencyBlipss:updateAllData', function(pData, cData)
	blips = pData
	carBlips = cData
end)

RegisterNetEvent('ra1derEmergencyBlipss:removePlayerGps')
AddEventHandler('ra1derEmergencyBlipss:removePlayerGps', function(src, pData, cData)
	blips = pData
	carBlips = cData
	Citizen.Wait(500)
	RemoveBlip(activeBlips[tostring(src)])
end)

RegisterNetEvent('ra1derEmergencyBlipss:toggle')
AddEventHandler('ra1derEmergencyBlipss:toggle', function(active, data, policeBlipData)
	policeBlip = policeBlipData
	lastGpsText = data
	activeGps = active
	if not activeGps then
		SetBlipDisplay(GetMainPlayerBlipId(), 4)
		for src, blipData in pairs(activeBlips) do
			RemoveBlip(blipData)
		end
		activeBlips = {}
	else
		SetBlipDisplay(GetMainPlayerBlipId(), 1)
	end
end)

RegisterNetEvent('tgiann-closest-police')
AddEventHandler('tgiann-closest-police', function(cb) 
	local closestPolice = 0
	local policeCount = 0
	for src, info in pairs(blips) do
		if info.blipColor == 29 then
			policeCount = policeCount + 1
			local playerIndex = GetPlayerFromServerId(src)
			if playerIndex ~= -1 then
				if #(GetEntityCoords(GetPlayerPed(playerIndex)) - GetEntityCoords(PlayerPedId())) < 250 then
					closestPolice = closestPolice + 1
				end
			end
		end
	end
	cb({closestPolice = closestPolice, policeCount = policeCount}) 
end)

Citizen.CreateThread(function()
	while true do
		if activeGps then
			local allBlips = exports["tgiann-infinity"]:GetPlayerCoordsData()
			for src, info in pairs(blips) do
				local playerBlips = allBlips[src]
				if playerBlips then
					if DoesBlipExist(activeBlips[src]) then
						SetBlipCoords(activeBlips[src], playerBlips.x, playerBlips.y, playerBlips.z)
						if GetBlipSprite(activeBlips[src]) ~= info.blipType then
							SetBlipSprite(activeBlips[src], info.blipType or 2)
						end
						SetBlipColour(activeBlips[src], info.blipColor)
						SetBlipScale(activeBlips[src], info.blipScale)
						ShowHeadingIndicatorOnBlip(activeBlips[src], true) -- Player Blip indicator
						SetBlipRotation(activeBlips[src], math.ceil(playerBlips.w)) -- update rotation
						BeginTextCommandSetBlipName("STRING")
						if info.carBlip then
							AddTextComponentString(carBlips[info.carPlate].text)
						else
							AddTextComponentString(info.blipText)
						end
						EndTextCommandSetBlipName(activeBlips[src])
					else
						if info.blipText ~= "Bilinmiyor" then
							local blip = AddBlipForCoord(playerBlips.x, playerBlips.y, playerBlips.z)
							SetBlipSprite(blip, info.blipType or 2)
							SetBlipColour(blip, info.blipColor)
							SetBlipAsShortRange(blip, true)
							SetBlipScale(blip, info.blipScale)
							ShowHeadingIndicatorOnBlip(activeBlips[src], true) -- Player Blip indicator
							SetBlipRotation(activeBlips[src], math.ceil(playerBlips.w)) -- update rotation
							SetBlipDisplay(blip, 4)
							SetBlipShowCone(blip, true)
							BeginTextCommandSetBlipName("STRING")
							AddTextComponentString(info.blipText)
							EndTextCommandSetBlipName(blip)
							activeBlips[tostring(src)] = blip
						end
					end
				end

			end
		end
		Citizen.Wait(100)
	end
end)

local lastPlate = ""
local serverDataUpdated = false
local lastBlipType = 1
Citizen.CreateThread(function()
	while true do
		if activeGps and policeBlip then
			local playerPed = PlayerPedId()
			blipType = IsVehicleSirenOn(vehicle) and 1 or GetVehicleClass(vehicle) == 15 and 64 or 1
			if IsPedInAnyVehicle(PlayerPedId()) then
				if not QBCore.Functions.GetPlayerData().metadata["isdead"] then 
					blipScale = 0.85
					local updatedBlip = false
					local vehicle = GetVehiclePedIsIn(PlayerPedId())
					blipType = IsVehicleSirenOn(vehicle) and 1 or GetVehicleClass(vehicle) == 15 and 64 or 1
					TriggerServerEvent("ra1derEmergencyBlipss:updatePlayerGps", false, 1, true, blipType, blipScale)
					if not activeCarBlip then
						lastPlate = QBCore.Shared.Trim(GetVehicleNumberPlateText(vehicle))
						for carPlate, data in pairs(carBlips) do
							if lastPlate == carPlate then
								activeCarBlip = true
								updatedBlip = true
								TriggerServerEvent("ra1derEmergencyBlipss:updatePlayerGps", false, 1, true, blipType, blipScale)
							end
						end
					end

					if (not updatedBlip and not serverDataUpdated) or lastBlipType ~= blipType then
						serverDataUpdated = true
						blipScale = 0.85
						TriggerServerEvent("ra1derEmergencyBlipss:updatePlayerGps", false, 1, true, blipType, blipScale)
					end
					lastBlipType = blipType
				else
					blipType = 274
					blipScale = 1.0
					TriggerServerEvent("ra1derEmergencyBlipss:updatePlayerGps", false, 1, true, blipType, blipScale)
				end
			else
				if not QBCore.Functions.GetPlayerData().metadata["isdead"] then 
					blipScale = 0.5
					TriggerServerEvent("ra1derEmergencyBlipss:updatePlayerGps", false, 1, true, blipType, blipScale)
				else
					blipType = 274
					blipScale = 1.0
					TriggerServerEvent("ra1derEmergencyBlipss:updatePlayerGps", false, 1, true, blipType, blipScale)
				end
			end
		end
		Citizen.Wait(1000)
	end
end)


RegisterNetEvent("ra1derEmergencyBlips:gpsac")
AddEventHandler("ra1derEmergencyBlips:gpsac", function()
	local PlayerData = QBCore.Functions.GetPlayerData()
	QBCore.Functions.TriggerCallback('elixir-base:item-kontrol', function(qtty)
		if qtty > 0 then
			if PlayerData.job ~= nil and PlayerData.job.name ~= 'unemployed' then 
                local keyboard = exports['qb-input']:ShowInput({
                    header = "Choose Your GPS Number and Department",
                    submitText = "Approve",
                    inputs = {
                        {
                            type = 'number',
                            isRequired = true,
                            text = "Enter GPS Number",
                            name = 'input',
                        },
						{
							text = "Select Department", -- text you want to be displayed as a input header
							name = "someselect", -- name of the input should be unique otherwise it might override
							type = "select", -- type of the input - Select is useful for 3+ amount of "or" options e.g; someselect = none OR other OR other2 OR other3...etc
							options = { -- Select drop down options, the first option will by default be selected
							{ value = "pd", text = "PD" }, -- Options MUST include a value and a text option
							{ value = "sd", text = "BCSO"}, -- Options MUST include a value and a text option
							{ value = "sp", text = "SASP" }, -- Options MUST include a value and a text option
							{ value = "pr", text = "SAPR" }, -- Options MUST include a value and a text option
							}
                    	}
					}
                })
                local gpscolor = keyboard.someselect
                if gpscolor == nil then gpscolor = "pd" end 
                local number = keyboard.input
                if PlayerData.job.name == "police" then
                    TriggerServerEvent('tgiann-gps:polis-ekle', number, tostring(gpscolor))
                else
                    TriggerServerEvent('tgiann-gps:ems-ekle', number)
                end
			else
				QBCore.Functions.Notify('You Are Not a Police', "error")
			end
		else
			QBCore.Functions.Notify('No GPS On!')	
		end
	end, "gps")
end)


RegisterNetEvent("ra1derEmergencyBlips:kapat")
AddEventHandler("ra1derEmergencyBlips:kapat", function()
	QBCore.Functions.TriggerCallback('elixir-base:item-kontrol', function(qtty)
		if qtty > 0 then
			TriggerServerEvent('tgiann-gps:acikgps-kapat', false)
		else
			QBCore.Functions.Notify('No GPS On!')	
		end
	end, 'gps')	
end)

