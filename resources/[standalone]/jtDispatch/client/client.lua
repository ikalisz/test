isOpen = false
lastNotification = {}
block = false

local PlayerData = {}

Citizen.CreateThread(function() 
    while QBCore == nil do
        TriggerEvent("QBCore:GetObject", function(obj) QBCore = obj end)
        Citizen.Wait(200)
    end

	PlayerData = QBCore.Functions.GetPlayerData()
end)


RegisterNUICallback('close', function()
	SetNuiFocus(false, false)
	isOpen = false
end)

RegisterNUICallback('get-self', function()
	SendSelf()
end)

RegisterNUICallback("addActiveUnit", function(data)
	TriggerServerEvent("jtDispatch:add-active-units", data)
end)

RegisterNUICallback("removeActiveUnit", function(data)
	TriggerServerEvent("jtDispatch:remove-active-units", data)
end)

RegisterNetEvent("jtDispatch:block-shotfire")
AddEventHandler("jtDispatch:block-shotfire", function(data)
	block = data
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    PlayerData = QBCore.Functions.GetPlayerData()
	
	while PlayerData == nil do
		Citizen.Wait(5)
	end

	SendSelf()
end)

RegisterNetEvent("jtDispatch:add-active-units")
AddEventHandler("jtDispatch:add-active-units", function(data)
	SendNUIMessage({type = "update", content = "add-active-unit", data = data})
end)

RegisterNetEvent("jtDispatch:remove-active-units")
AddEventHandler("jtDispatch:remove-active-units", function(data)
	SendNUIMessage({type = "update", content = "remove-active-unit", data = data})
end)

RegisterNetEvent("QBCore:Client:OnJobUpdate")
AddEventHandler("QBCore:Client:OnJobUpdate", function(job)
    PlayerData.job = job
end)

function SendSelf()
	PlayerData = QBCore.Functions.GetPlayerData()

	data = {}
	data.name = PlayerData.charinfo.firstname .. " " .. PlayerData.charinfo.lastname
	data.citizenId = PlayerData.citizenid
	data.radioCode = PlayerData.metadata["radiocode"]
	data.job = PlayerData.job.label

	SendNUIMessage({type = "update", content = "self", data = data})
end

RegisterNUICallback('set-radio-code', function(data, cb)
	PlayerData.metadata["radiocode"] = data.radiocode
	QBCore.Functions.TriggerCallback('jtDispatch:set-radio-code', function(data)
		cb(data)
	end, data.radiocode)
end)

RegisterNUICallback('set-waypoint', function(data)
	SetNewWaypoint(tonumber(data.x), tonumber(data.y))
	QBCore.Functions.Notify('Incident Zone Marked', 'success', 4000)
end)

RegisterKeyMapping('+dispatch', 'Dispatch', 'keyboard', 'F6') 

RegisterCommand("+dispatch", function(source, args)
	if (isOpen == false) then
		if PlayerData == nil or PlayerData.job == nil or PlayerData.job.name == nil then
			PlayerData = QBCore.Functions.GetPlayerData()
		end
		while PlayerData == nil do
			Citizen.Wait(10)
		end
		if PlayerData.job.name ~= "police" and PlayerData.job.name ~= "ambulance" then
			return
		end
	end
    Toggle(not isOpen)
end)

RegisterCommand('code', function(source, args, raw)
	if args[1] == nil then return end

	if PlayerData == nil or PlayerData.job == nil or PlayerData.job.name == nil then
		PlayerData = QBCore.Functions.GetPlayerData()
	end

	while PlayerData == nil do
		Citizen.Wait(10)
	end

	if PlayerData.job.name ~= "police" then
		return
	end
	if args[1] == "99" or args[1] == "0" then
		TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 10,  "emergency", 0.8)
		TriggerServerEvent("InteractSound_SV:PlayOnAll", "emergency", 0.8)
		TriggerEvent('InteractSound_CL:PlayOnOne', 'emergency', 0.2)
	end

	local description = ""
	local code = Codes[tonumber(args[1])]

	local id = math.random(1, 9999)
	data = {
		id = id,
		code = args[1],
		sprite = 280,
	}

	if code == nil or code.description == nil then 
		data.description = "Officer asks for help"
	else
		data.description = PlayerData.charinfo.firstname.." "..PlayerData.charinfo.lastname.. code.description

		if code.coords == true then 
			local ped = PlayerPedId()
			local street = GetTheStreet()
			local playerPos = GetEntityCoords(ped)
			
			data.coords = playerPos
			data.location = street
		end
	end
	
	TriggerServerEvent("jtDispatch:add-notification", data, "police")
end)


RegisterNetEvent("jtDispatch:send-notification")
AddEventHandler("jtDispatch:send-notification", function(data) 
	if data.code == "KOD 99" then
		TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 20,  "kod99", 0.2)
	elseif data.code == "KOD 0" then
		TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 10,  "emergency", 0.8)
	elseif data.code == "KOD 66" then
		TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 10,  "emergency", 0.8)
	end
	SendNotification(data)
end)

RegisterNetEvent("jtDispatch:refresh")
AddEventHandler("jtDispatch:refresh", function(data)
	SendNUIMessage({type = "update", contents = "notifications", data = data})
end)


function Toggle(val)
	if val then
		QBCore.Functions.TriggerCallback('jtDispatch:get-dispatchs', function(data)
			user = {}
			user.name = PlayerData.charinfo.firstname .. " " .. PlayerData.charinfo.lastname
			user.citizenId = PlayerData.citizenid
			user.radioCode = PlayerData.metadata["radiocode"] or "NO"
			user.job = PlayerData.job.label
			SendNUIMessage({type = "open", data = data, user = user})
		end)
		SetNuiFocus(true, true)
	else
		SendNUIMessage({type = "close"})
		SetNuiFocus(false, false)
	end

	isOpen = val
end

function SendNotification(data)
	lastNotification = data
	SendNUIMessage({type = "notification", data = data})

	Citizen.Wait(5000)
	lastNotification.focused = true
end

CreateThread(function()
	while true do
		Wait(10)
		if not block then
			local ped = PlayerPedId()
			local playerPos = GetEntityCoords(ped)
			if IsPedShooting(ped) and PlayerData.job.name ~= "police" then
				if GetSelectedPedWeapon(ped) ~= 911657153 and GetSelectedPedWeapon(ped) ~= 101631238 and GetSelectedPedWeapon(ped) ~= GetHashKey("WEAPON_SNOWBALL") then
				
				local street = GetTheStreet()
				local weapon = WeaponNames[tostring(GetSelectedPedWeapon(ped))]
				local id = math.random(1, 9999)

				data = {
					id = id,
					code = 1,
					description = "Gunshots were heard",
					location = street,
					coords = playerPos,
					sprite = 433
				}

				TriggerServerEvent("jtDispatch:add-notification", data, "police")
				Wait(20000)
				end
			end
		end
	end
end)
 
RegisterNetEvent("jtDispatchAddBlip")
AddEventHandler("jtDispatchAddBlip", function(x, y, icon, alertName)
	local alpha = 200
    local blip = AddBlipForCoord(x, y, 5.0)
	SetBlipSprite(blip, icon)
    SetBlipDisplay(blip, 2)
    SetBlipScale(blip, 1.1)
    SetBlipColour(blip, 75)
    SetBlipAsShortRange(blip, false)
    SetBlipAlpha(blip, alpha)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(alertName)
    EndTextCommandSetBlipName(blip)

    while alpha ~= 0 do
        Citizen.Wait(60 * 6)
        alpha = alpha - 1
        SetBlipAlpha(blip, alpha)

        if alpha == 0 then
            RemoveBlip(blip)
            break
        end
    end
end)


function GetTheStreet()
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
        ZoneNames[tostring(zone)] = "Unknown Territory"
    end

    if (intersectStreetName ~= nil and intersectStreetName ~= "") or (currentStreetName ~= nil and currentStreetName ~= "") then
        playerStreetsLocation = currentStreetName
    else
        playerStreetsLocation = ZoneNames[tostring(zone)]
    end

	return playerStreetsLocation
end

-- Citizen.CreateThread(function()
-- 	while true do
-- 		Citizen.Wait(5)

-- 		if IsControlJustPressed(0, 19) and lastNotification.id ~= nil and (lastNotification.focused == nil or lastNotification.focues == false) and lastNotification.coords ~= nil then
-- 			lastNotification.focused = true
-- 			SetNewWaypoint(lastNotification.coords.x, lastNotification.coords.y)
-- 		end
-- 	end
-- end)

RegisterKeyMapping('+dispatch_waypoint', 'Dispatch Waypoint', 'keyboard', 'E') 

RegisterCommand("+dispatch_waypoint", function(source, args)
	PlayerData = QBCore.Functions.GetPlayerData()
	while PlayerData == nil or PlayerData.job == nil or PlayerData.job.name == nil do
		Citizen.Wait(10)
		PlayerData = QBCore.Functions.GetPlayerData()
	end
	if PlayerData.job.name ~= "police" and PlayerData.job.name ~= "ambulance" then
		return
	end
	if lastNotification.id ~= nil and (lastNotification.focused == nil or lastNotification.focues == false) and lastNotification.coords ~= nil then
		lastNotification.focused = true
		SetNewWaypoint(lastNotification.coords.x, lastNotification.coords.y)
		QBCore.Functions.Notify('Incident Area Marked', 'success', 4000)
	end
end)