local QBCore = exports['qb-core']:GetCoreObject()

local empActive = false
local activeBlips, activeCarsBlips = {}, {}


RegisterNetEvent('tgiann-denizalti:server:emp')
AddEventHandler('tgiann-denizalti:server:emp', function(active)
	empActive = active
    if empActive then
        TriggerClientEvent("tgiann-emerhencyblips:forceClose", -1)
    end
end)

AddEventHandler("playerDropped", function(reason)
    local src = source
    removeBlip(src)
end)

RegisterNetEvent('tgiann-gps:gizli-gps-ekle')
AddEventHandler('tgiann-gps:gizli-gps-ekle', function()
	local src = source
	if empActive then 	
		TriggerClientEvent("QBCore:Notify", src, 'Failed to Open GPS', "error")
	else
		addBlip("Bilinmiyor", 39, src, 0.75, 4)
		TriggerClientEvent("QBCore:Notify", src, 'GPS Turned On')
		TriggerClientEvent("ra1derEmergencyBlipss:toggle", src, true, src.."-Bilinmiyor")
        Citizen.Wait(20000)
        TriggerEvent("tgiann-gps:acikgps-kapat", false, src)
		TriggerClientEvent("ra1derEmergencyBlipss:toggle", src, true, text, true)
	end
end)



RegisterNetEvent('tgiann-gps:polis-ekle')
AddEventHandler('tgiann-gps:polis-ekle', function(polisno, gpscolor)
	local src = source
	if empActive then 	
		TriggerClientEvent("QBCore:Notify", src, 'Failed to Open GPS', "error")
	else
		if polisno == nil then polisno = "LSPD" end
        local isim = getPlayerName(src)
        local text = '.'..polisno..' ['.. isim..']'
		addBlip(text, 38, src, 0.85, 1, gpscolor)
		TriggerClientEvent("QBCore:Notify", src, 'GPS Turned On')
        TriggerClientEvent("tgiann-polisbildirim:setGpsName", src, polisno)
		TriggerClientEvent("ra1derEmergencyBlipss:toggle", src, true, text, true, gpscolor)
	end
end)

RegisterNetEvent('tgiann-gps:ems-ekle')
AddEventHandler('tgiann-gps:ems-ekle', function(emsNo)
	local src = source
	if empActive then 	
		TriggerClientEvent("QBCore:Notify", src, 'Failed to Open GPS', "error")
    else
        if emsNo == nil then emsNo = "EMS" end
        local isim = getPlayerName(src, nil)
		addBlip('!'..emsNo..' ['..isim..']', 1, src, 0.7, 1)
        TriggerClientEvent("QBCore:Notify", src, 'GPS Turned On')
        TriggerClientEvent("ra1derEmergencyBlipss:toggle", src, true, text, false)
	end
end)

RegisterNetEvent('tgiann-gps:acikgps-kapat')
AddEventHandler('tgiann-gps:acikgps-kapat', function(duty, id)
	local src = source
	if id then src = id end
	if duty then 
		local xPlayer = QBCore.Functions.GetPlayer(src)
		if xPlayer.PlayerData.job.onduty and (xPlayer.PlayerData.job.name == "ambulance" or xPlayer.PlayerData.job.name == "police") then
			xPlayer.Functions.SetJobDuty(false)
			TriggerClientEvent('QBCore:Notify', src, "You Have Been Taken Out of Hours Because You Have Been Injured!", 'error', 15000)
		end
	else
        TriggerClientEvent("ra1derEmergencyBlipss:toggle", src, false)
        TriggerClientEvent("QBCore:Notify", src, 'GPS Turned Off', 'error')
		removeBlip(src)
	end
end)

RegisterNetEvent('ra1derEmergencyBlipss:carBlips')
AddEventHandler('ra1derEmergencyBlipss:carBlips', function(plate, number)
    if activeCarsBlips[plate] then
        activeCarsBlips[plate].number = number
    else
        activeCarsBlips[plate] = {
            text = "",
            number = number,
            players = {},
        }
    end
	TriggerClientEvent("ra1derEmergencyBlipss:updateAllData", -1, activeBlips, activeCarsBlips)
end)

RegisterNetEvent('ra1derEmergencyBlipss:updatePlayerGps')
AddEventHandler('ra1derEmergencyBlipss:updatePlayerGps', function(updateCarBlip, plate, open, blipType, blipScale)
    local src = source
    if updateCarBlip then
        if open then
            if activeBlips[tostring(src)] then
                local xPlayer = QBCore.Functions.GetPlayer(src)
                activeCarsBlips[plate].players[tostring(src)] = xPlayer.PlayerData.charinfo.firstname.. " " ..xPlayer.PlayerData.charinfo.lastname
                activeBlips[tostring(src)].carBlip = true
                activeBlips[tostring(src)].carPlate = plate
            end	
        else
            activeCarsBlips[plate].players[tostring(src)] = nil
            if activeBlips[tostring(src)] then
                activeBlips[tostring(src)].carBlip = false
                activeBlips[tostring(src)].carPlate = ""
            end
        end
        updateCarText(plate)
        TriggerClientEvent('QBCore:Notify', src, "GPS Updated!", "primary", 2000)
    end

    if activeBlips[tostring(src)] then
        activeBlips[tostring(src)].blipType = blipType
    end

    if activeBlips[tostring(src)] then
        activeBlips[tostring(src)].blipScale = blipScale
    end
    
    TriggerClientEvent("ra1derEmergencyBlipss:updateAllData", -1, activeBlips, activeCarsBlips)
end)

RegisterNetEvent('EmergencyBlips:black-market-open')
AddEventHandler('EmergencyBlips:black-market-open', function()
    addBlip('!Buying Illegal Items ['..source..']', 0, source, 0.75, 4)
end)

RegisterNetEvent('EmergencyBlips:black-market-close')
AddEventHandler('EmergencyBlips:black-market-close', function()
    removeBlip(source)
end)

function getPlayerName(src)
    local xPlayer = QBCore.Functions.GetPlayer(src)
	return xPlayer.PlayerData.charinfo.firstname.. " " ..xPlayer.PlayerData.charinfo.lastname
end

function addBlip(text, color, src, scale, type, gpscolor)
    if activeBlips[tostring(src)] then removeBlip(src) end
    if gpscolor ~= nil then 
        if gpscolor == "pd" then -- police
        elseif gpscolor == "sd" then 
            color = 5  -- sheriff
        elseif gpscolor == "sp" then 
            color = 3 -- state
        elseif gpscolor == "pr" then 
            color = 52  -- park ranger
        end
    end
    activeBlips[tostring(src)] = {
        blipText = text,
        blipColor = color,
        carBlip = false,
        carPlate = "",
        blipScale = scale,
        blipType = type
    }
    TriggerClientEvent("ra1derEmergencyBlipss:updateAllData", -1, activeBlips, activeCarsBlips)
end

function removeBlip(src)
	if activeBlips[tostring(src)] then
        activeBlips[tostring(src)] = nil
        for plate, data in pairs(activeCarsBlips) do
            for pSrc, players in pairs(data.players) do
                if pSrc == tostring(src) then
                    activeCarsBlips[plate].players[tostring(src)] = nil
                    updateCarText(plate)
                    break
                end
            end
        end
        TriggerClientEvent("ra1derEmergencyBlipss:removePlayerGps", -1, src, activeBlips, activeCarsBlips)
	end
end

function updateCarText(plate)
    local first = true
    if next(activeCarsBlips[plate].players) then
        for x,playerName in pairs(activeCarsBlips[plate].players) do
            if first then
                first = false
                text = "."..activeCarsBlips[plate].number.." ["..playerName
            else
                text = text .. ","..playerName
            end
        end
        text = text.."]"
    else
        text = ""
    end
    activeCarsBlips[plate].text = text
end

QBCore.Functions.CreateUseableItem("gps", function(source)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)  
    if Player.PlayerData.job.name == "police" or Player.PlayerData.job.name == "ambulance" then 
        TriggerClientEvent("ra1derEmergencyBlips:gpsac", source)

    else
        TriggerClientEvent("QBCore:Notify", src, "You are not police or EMS.!")
    end
end)

QBCore.Commands.Add("closegps", "Turn off GPS", {}, false, function(source, args)
    TriggerClientEvent("ra1derEmergencyBlips:kapat", source)
end)