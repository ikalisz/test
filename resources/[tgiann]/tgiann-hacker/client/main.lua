local HackTimer = GetGameTimer()
local gpsTimer = GetGameTimer()
local yerHackSure = GetGameTimer() + (60000*60)
local PlayerData = {}
local menuOpen = false
local coreLoaded = false

QBCore = nil
Citizen.CreateThread(function()
    while QBCore == nil do
        TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)
        Citizen.Wait(200)
	end
	coreLoaded = true
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
	PlayerData = QBCore.Functions.GetPlayerData()
	yapilan_hack = QBCore.Functions.GetPlayerData().metadata["hackcount"]
	PlayerLoaded = true
end)

-- Meslek Update
RegisterNetEvent('QBCore:Client:OnJobUpdate')
AddEventHandler('QBCore:Client:OnJobUpdate', function(job)
    PlayerData.job = job
end)

local marker = vector3(2169.3732910156, 2925.8344726562, -81.075256347656)

Citizen.CreateThread(function()
	while true do
		time = 1000
		local playerPed = PlayerPedId()
		local playerCoord = GetEntityCoords(playerPed)
		local distance = #(playerCoord - marker)
		if distance < 20 and coreLoaded and yapilan_hack > 49 then
			time = 1
			DrawMarker(2, marker, 0, 0, 0, 0, 0, 0, 0.6, 0.6, 0.6, 255, 0, 0, 150, 0, 1, 0, 0)
			if distance < 5 then
				local text = ""
				if distance < 1 then
					text = "[E] "
					if IsControlJustPressed(0, 38) then
						TriggerServerEvent("tgiann-hacker:coin", QBCore.Key)
						Citizen.Wait(500)
					end
				end
				QBCore.Functions.DrawText3D(marker.x, marker.y, marker.z+0.4, text.."Sell ​​All Coins On You")
			end
		end

		for zone, data in pairs(Config.zones) do
			local distance = #(playerCoord - data.coords)
			if distance < 20.0 and coreLoaded then
				time = 1
				DrawMarker(data.type, data.coords.x, data.coords.y, data.coords.z - 0.2, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.5, 0.5, 0.5, data.color, 150, false, true, 2, false, false, false, false)
				if distance < 1.0 then
					QBCore.Functions.DrawText3D(data.coords.x, data.coords.y, data.coords.z+0.2, "[E] ".. data.text)
					if IsControlJustReleased(0, 38) then
						yapilan_hack = QBCore.Functions.GetPlayerData().metadata["hackcount"]
						if yapilan_hack > 49 then
							SetEntityCoords(playerPed, data.to)
						else
							QBCore.Functions.Notify("You Need To Work A Little More To Get In!", "error")
						end
						Citizen.Wait(1000)
					end
				end
			end
		end

		Citizen.Wait(time)
	end
end)

function hackerActionMenu(tabletismi)
	local tablet = tabletismi
	yapilan_hack = QBCore.Functions.GetPlayerData().metadata["hackcount"]
	local elements = {}
	
	if tablet == "hackv1" then
		table.insert(elements, {label = "V1 Credit Card Hack", value = 'v1hack_menu'}) -- Kapıları Açma

		if yapilan_hack > 49 then
			table.insert(elements, {label = "Find Your Cryptocurrency Farm", value = 'kripto'})
			if yapilan_hack > 99 then
				table.insert(elements, {label = "Open Vehicle Door", value = 'carDoorHack'}) -- Kapıları Açma
				if yapilan_hack > 199 then
					table.insert(elements, {label = "Start Vehicle Engine", value = 'carEngineHack'}) -- Kapıları Açma
				end
			end
		end
	end

	if tablet == "hackv2" then
		if yapilan_hack > Config.pcHack then
			table.insert(elements, {label = 'V2 Terminal Hack', value = 'pc_hack'})
		else
			table.insert(elements, {label = 'V1 You Need To Master It More', value = 'kapat'})
		end
	end

	if tablet == "hackv3" then
		if yapilan_hack > Config.pcHack then
			table.insert(elements, {label = 'V3 Get a Man Out of Jail', value = 'hapis'})
			table.insert(elements, {label = 'V3 Locating', value = 'yer'})
			if yapilan_hack > 249 then
				table.insert(elements, {label = 'V3 GPS Infiltrate Your System!', value = 'gps'})
			end
		else
			table.insert(elements, {label = 'V1 You Need To Master It More', value = 'kapat'})
		end
	end

	QBCore.UI.Menu.CloseAll()
	QBCore.UI.Menu.Open('default', GetCurrentResourceName(), 'hacker', {
		title    = 'Hacker Menu',
		align    = 'top-left',
		elements = elements
	}, function(data, menu)
		QBCore.UI.Menu.CloseAll()
		if data.current.value == 'v1hack_menu' then
			if not zoneControl() then return end

			if GetVehiclePedIsIn(PlayerPedId()) ~= 0 then
				menuOpen = false
				QBCore.Functions.Notify('You Cant Hack In The Vehicle!', 'error')
				return
			end

			local elements = { {label = 'Kolay', value = 'kolay'} }
			if yapilan_hack > Config.V1OrtaGerekenSayi then
				table.insert(elements, {label = 'Orta', value = 'orta'})
			end
			if yapilan_hack > Config.V1ZorGerekenSayi then
				table.insert(elements, {label = 'Zor', value = 'zor'})	
			end

			QBCore.UI.Menu.Open('default', GetCurrentResourceName(), 'v1hack_menu', {
				title    = "Hack Menu",
				align    = 'top-left',
				elements = elements
			}, function(data, menu)
				menu.close()
				if data.current.value == 'kolay' and GetGameTimer() - HackTimer > Config.HackSure * 60000 then	
					HackTimer = GetGameTimer()
					hackProgBar("Credit card", 3, 30, mycbkolay)
				
				elseif data.current.value == 'orta' and GetGameTimer() - HackTimer > Config.HackSure * 60000 then	
					HackTimer = GetGameTimer()	
					hackProgBar("Credit card", 2, 25, mycborta)	
										
				elseif data.current.value == 'zor' and GetGameTimer() - HackTimer > Config.HackSure * 60000 then
					HackTimer = GetGameTimer()
					hackProgBar("Credit card", 2, 25, mycbzor)	

				-- V1 süre kontrol
				elseif data.current.value == 'kolay' and GetGameTimer() - HackTimer < Config.HackSure * 60000 then
					local hackTime = Config.HackSure * 60000 - (GetGameTimer() - HackTimer)
					QBCore.Functions.Notify("Try again in " ..math.floor(hackTime / 60000 + 1).. "minute.")
					menuOpen = false
				else
					menuOpen = false
					QBCore.Functions.Notify("Not enough time passed to hack again")
				end
			end, function(data, menu)
				menu.close()
				menuOpen = false
			end)	
		elseif data.current.value == "carDoorHack" then
			if GetVehiclePedIsIn(PlayerPedId()) ~= 0 then
				menuOpen = false
				QBCore.Functions.Notify('You Cant Do This In The Car!', 'error')
				return
			end

			local vehicle, mesafe = QBCore.Functions.GetClosestVehicle(playerCoords)
			if mesafe < 3 then
				if math.random(1,100) < 20 then
					bildirim()
				end
				TriggerEvent("dpemotes:play-anim", {"tablet2"})
				local finished2 = exports["tgiann-skillbar"]:taskBar(2000,math.random(8,12))
				if not finished2 then
					menuOpen = false
					TriggerEvent("dpemotes:play-anim", {"c"})
				else
					local finished3 = exports["tgiann-skillbar"]:taskBar(1000,math.random(8,11))
					if not finished3 then
						menuOpen = false
						TriggerEvent("dpemotes:play-anim", {"c"})
					else
						local finished4 = exports["tgiann-skillbar"]:taskBar(4200,math.random(10,18))
						if not finished4 then
							menuOpen = false
							TriggerEvent("dpemotes:play-anim", {"c"})
						else
							local finished5 = exports["tgiann-skillbar"]:taskBar(1400,math.random(10,16))
							if not finished5 then
								menuOpen = false
								TriggerEvent("dpemotes:play-anim", {"c"})
							else
								local Plate = QBCore.Shared.Trim(GetVehicleNumberPlateText(vehicle))
								TriggerServerEvent("tgiann-arackilit:lock-car-server", 1, Plate)
								SetVehicleDoorsLocked(vehicle, 1)
								QBCore.Functions.Notify('Door Successfully Opened')
								menuOpen = false
								TriggerEvent("dpemotes:play-anim", {"c"})
							end
						end
					end
				end

			else
				QBCore.Functions.Notify('No Vehicles Nearby!', "error")
			end
		elseif data.current.value == "carEngineHack" then
			local vehicle, mesafe = QBCore.Functions.GetClosestVehicle(playerCoords)
			if mesafe < 3 then
				TriggerEvent("dpemotes:play-anim", {"tablet2"})
				local finished = exports["tgiann-skillbar"]:taskBar(25000,math.random(5,8))
				if not finished then
					menuOpen = false
					TriggerEvent("dpemotes:play-anim", {"c"})
				else
					duzKontakSes = true
					local finished2 = exports["tgiann-skillbar"]:taskBar(6500,math.random(5,12))
					if not finished2 then
						menuOpen = false
						TriggerEvent("dpemotes:play-anim", {"c"})
					else
						local finished3 = exports["tgiann-skillbar"]:taskBar(4000, math.random(10,14))
						if not finished3 then
							menuOpen = false
							TriggerEvent("dpemotes:play-anim", {"c"})
						else
							TriggerEvent("x-hotwire:give-keys", vehicle, QBCore.Shared.Trim(GetVehicleNumberPlateText(vehicle)))
							TriggerEvent("dpemotes:play-anim", {"c"})
							menuOpen = false
						end
					end
				end
			else
				QBCore.Functions.Notify('No Vehicles Nearby!', "error")
			end
		elseif data.current.value == 'pc_hack' then		-- PC Hack
			if not zoneControl() then return end
			menuOpen = false
			pcHack()
		elseif data.current.value == "hapis" then
			menuOpen = false
			TriggerEvent("esx-qalle-jail:player-un-jail")
		elseif data.current.value == "yer" then
			menuOpen = false
			TriggerEvent("tgiann-hacker:yer-bul")
		elseif data.current.value == "gps" then
			if not zoneControl() then return end
			menuOpen = false
			if GetGameTimer() - gpsTimer < Config.HackSure * 60000 then
				local hackTime = Config.HackSure * 60000 - (GetGameTimer() - gpsTimer)
				QBCore.Functions.Notify(""..math.floor(hackTime / 60000 + 1).. " dakika sonra tekrar dene.")
			else
				HackTimer = GetGameTimer()	
				TriggerEvent("utk_fingerprint:Start", 1, 3, 1, function(outcome, reason) -- level, can, süre
					if outcome == true then 
						QBCore.Functions.Notify("Hack Successful 10 Seconds After You Can See All Active GPS!")
						Citizen.Wait(10000)
						TriggerServerEvent("tgiann-gps:gizli-gps-ekle")
					elseif outcome == false then
						QBCore.Functions.Notify("Hack Failed", "error")
					end
				end)
			end
		elseif data.current.value == "kripto" then
			menuOpen = false
			if yerHackSure > GetGameTimer() then
				yerHackSure = GetGameTimer() + (60000*60)
				TriggerEvent("utk_fingerprint:Start", 4, 1, 1, function(outcome, reason) -- level, can, süre
					if outcome == true then 
						SetNewWaypoint(-2222.6262207031,  304.15417480469)
						QBCore.Functions.Notify("Location Marked on GPS", "success")
					elseif outcome == false then
						QBCore.Functions.Notify("Hack Failed", "error")
					end
				end)
			else
				QBCore.Functions.Notify("Try Again After 1 Hour", "error")
			end
		end

	end, function(data, menu)
		menu.close()
		menuOpen = false
	end)

end

function pcHack()
	local playerPed = PlayerPedId()
	local PlayerKordinat  = GetEntityCoords(playerPed)

	QBCore.Functions.TriggerCallback('elixir-base:hack-kontrol', function(sure)
		if sure > 28800 or sure == 0 then
			TriggerEvent("tgiann-fallouthacker:hack-menu-ac")
			TriggerServerEvent("tgiann-hacker:pc-hack-guncelle")
		else
			QBCore.Functions.Notify("You need to wait for ".. QBCore.Shared.Round(((28800 - sure) / 60) / 60) .." hours before you can do this operation.")
		end
	end)
end

RegisterNetEvent('tgiann-hacker:police-alert')
AddEventHandler('tgiann-hacker:police-alert', function(name)
	bildirim31(name)
end)

-- Polis Bildirim
function PolisBildirim(hangi)
	if hangi == nil then hangi = "bilinmiyor" end
	if math.random(1,100) < 95 then
		local ped = PlayerPedId()
		local playerPos = GetEntityCoords(ped)
		local id = math.random(25, 99)
		
		data = {
			id = id,
			code = 10-40,
			description = "Hack (".. hangi .. ") Notice No: ".. tostring(GetPlayerServerId(PlayerId())),
			location = GetTheStreet(),
			coords = playerPos,
			sprite = 225
		}   
		TriggerServerEvent("jtDispatch:add-notification", data, "police")
		-- TriggerEvent("Tgiann-PolisBildirim:BildirimGonder", "Hack (".. hangi .. ") İhbar No: ".. tostring(GetPlayerServerId(PlayerId())), false)
	end
	Citizen.Wait(math.random(10000, 20000))
	local a = 0
	repeat
		a = a + 1
		Citizen.Wait(math.random(10000, 20000))
		local ped = PlayerPedId()
		local playerPos = GetEntityCoords(ped)
		local id = math.random(25, 99)
		
		data = {
			id = id,
			code = 10-40,
			description = "Hack (".. hangi .. ") Notice No: ".. tostring(GetPlayerServerId(PlayerId())),
			location = GetTheStreet(),
			coords = playerPos,
			sprite = 225
		}   
		TriggerServerEvent("jtDispatch:add-notification", data, "police")
		-- TriggerEvent("Tgiann-PolisBildirim:BildirimGonder", "Hack (".. hangi .. ") İhbar No: ".. tostring(GetPlayerServerId(PlayerId())), false)
	until a == 6
end

function hackProgBar(hangi, t1, t2, hack)
	local time = 15000
	TriggerEvent("dpemotes:play-anim", {"tablet2"})
	local ped = PlayerPedId()
    local playerPos = GetEntityCoords(ped)
    local id = math.random(25, 99)
    
    data = {
        id = id,
        code = 10-40,
        description = hangi.. " being hacked",
        location = GetTheStreet(),
        coords = playerPos,
        sprite = 126
    }   
    TriggerServerEvent("jtDispatch:add-notification", data, "police")
	QBCore.Functions.Progressbar("ozel_name", "Connecting to the Network", time, false, false, { -- p1: menu name, p2: yazı, p3: ölü iken kullan, p4:iptal edilebilir
		disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
	}, {}, {}, {}, function() -- Done
		TriggerEvent("mhacking:show")
		TriggerEvent("mhacking:start", t1, t2, hack)
	end, function() -- Cancel
		menuOpen = false
	end)
	Citizen.Wait(time)
end

function mycbkolay(success, timeremaining)
	TriggerEvent('mhacking:hide')
	if success then	
		TriggerServerEvent('tgiann-hacker:hackparasi', 500, QBCore.Key)
		QBCore.Functions.Notify('Congratulations! You can try again after 30 minutes.')	
		TriggerServerEvent('tgiann-hacker:hacksayiekle')
    else
		QBCore.Functions.Notify('you failed!')
    end
	TriggerEvent("dpemotes:play-anim", {"c"})
	menuOpen = false
end

function mycborta(success, timeremaining)
	TriggerEvent('mhacking:hide')
	if success then		
		TriggerServerEvent('tgiann-hacker:hackparasi', 1500, QBCore.Key)
		QBCore.Functions.Notify('Congratulations! You can try again after 30 minutes.')
		TriggerServerEvent('tgiann-hacker:hacksayiekle')
    else
		QBCore.Functions.Notify('you failed!')
    end
	TriggerEvent("dpemotes:play-anim", {"c"})
	menuOpen = false
end

function mycbzor(success, timeremaining)
	TriggerEvent('mhacking:hide')		
	if success then		
		TriggerServerEvent('tgiann-hacker:hackparasi', 2500, QBCore.Key)
		QBCore.Functions.Notify('Congratulations! You can try again after 30 minutes.')
		TriggerServerEvent('tgiann-hacker:hacksayiekle')
    else	
		QBCore.Functions.Notify('you failed!')		
    end
	TriggerEvent("dpemotes:play-anim", {"c"})
	menuOpen = false
end

RegisterNetEvent('tgiann-hacker:open-tablet')
AddEventHandler('tgiann-hacker:open-tablet', function(HangiTablet)
	QBCore.Functions.TriggerCallback('elixir-base:polis-sayi', function(AktifPolis)
		if AktifPolis >= Config.PolisSayisi then -- Config.PolisSayisi
			if not menuOpen then
				menuOpen = true
				hackerActionMenu(HangiTablet)
				TriggerEvent("tgiann-hacker:distance-control", GetEntityCoords(PlayerPedId()))
			else
				QBCore.Functions.Notify('You Are Already Hacking!', "error")
			end
		else
			QBCore.Functions.Notify('There Arent Enough Police in the City for Hacking')
		end
	end)
end)

function zoneControl()
	local playerPed = PlayerPedId()
	local playerCoords = GetEntityCoords(playerPed)
	if #(playerCoords - vector3(-200.97, -703.0, 34.01)) < 1200 then
		if GetRoomKeyFromEntity(playerPed) == 0 then
			return true
		else
			menuOpen = false
			QBCore.Functions.Notify('You Cant Hack Here!', 'error')
		end
	else
		menuOpen = false
		QBCore.Functions.Notify('You Cant Hack Away From The City Center!', "error")
	end
	return false
end

RegisterNetEvent('tgiann-hacker:yer-bul')
AddEventHandler('tgiann-hacker:yer-bul', function()
	QBCore.UI.Menu.Open('dialog', GetCurrentResourceName(), 'tel_no_menu', {
		title = "Phone Number"
	}, function(data2, menu2)
		menu2.close()
		local telno = data2.value
		if telno == nil then
			QBCore.Functions.Notify("Phone Number Must Consist of Numbers")
		else
			QBCore.Functions.TriggerCallback('tgiann-hacker:numara-kontrol', function(data)
				if data ~= false then
					BulunanNumara = {}
					local player = GetPlayerFromServerId(tonumber(data.PlayerData.source))
					local ped = GetPlayerPed(player)
					TriggerServerEvent("tgiann-hacker:tabletsil", "hackv2")
					table.insert(BulunanNumara, ped)
					TriggerEvent('mtracker:settargets', BulunanNumara)
					TriggerEvent('mtracker:start')
				end
			end, telno)										
		end
		
	end, function(data2, menu2)
		menu2.close()
	end)
end)

RegisterNetEvent("tgiann-hacker:distance-control")
AddEventHandler("tgiann-hacker:distance-control", function(oldCoords)
	while menuOpen do
		Citizen.Wait(100)
		if #(oldCoords - GetEntityCoords(PlayerPedId())) > 15 then
			menuOpen = false
			QBCore.UI.Menu.CloseAll()
			QBCore.Functions.Notify('You Cant Hack While On The Move!', "error")
			TriggerEvent("tgiann-fallouthacker:hack-menu-kapat")
		end
	end
end)

-- FINDING A MAN BY PHONE NUMBER
targetsEntitys = {}
mTrackerRunning = false
timer = 0

AddEventHandler('mtracker:start', function()
	mTrackerRunning = true
	nuiMsg = {}
	nuiMsg.run = mTrackerRunning
	nuiMsg.show = mTrackerRunning
	SendNUIMessage(nuiMsg)
end)

AddEventHandler('mtracker:stop', function()
	mTrackerRunning = false
	nuiMsg = {}
	nuiMsg.run = mTrackerRunning
	nuiMsg.show = mTrackerRunning
	SendNUIMessage(nuiMsg)
end)

AddEventHandler('mtracker:settargets', function(targets)
	targetsEntitys = targets
	polartargets = transformTargets()
	nuiMsg = {}
	nuiMsg.settargets = polartargets
	SendNUIMessage(nuiMsg)
end)

AddEventHandler('mtracker:updatetargets', function()
	polartargets = transformTargets()
	nuiMsg = {}
	nuiMsg.updatetargets = polartargets
	SendNUIMessage(nuiMsg)
end)

AddEventHandler('mtracker:removealltargets', function()
	nuiMsg = {}
	nuiMsg.removealltargets = true
	SendNUIMessage(nuiMsg)
end)

function isrunning()
  return mTrackerRunning
end

function atan2(x, y)
	local res = 0
	if x > 0 then
		res = math.atan(y/x)
	elseif x < 0 and y > 0 then
		res = math.atan(y/x) + math.pi
	elseif x < 0 and y < 0 then
		res = math.atan(y/x) - math.pi
	elseif x == 0 and y > 0 then
		res = 0.5 * math.pi
	elseif x == 0 and y < 0 then
		res = -0.5 * math.pi
	elseif y == 0 and x > 0 then
		res = math.pi
	end
	return res
end

function radToDeg(f)
	res = 180.0/math.pi * f
	if res >= 360 then
		res = res - 360.0
	end
	return res
end

function calculateRelativePolarCoordinates(playerPos, targetPos)
	local v = {x = targetPos.x - playerPos.x, y = targetPos.y - playerPos.y}
	local phi = radToDeg(atan2(v.y, v.x)) + GetEntityHeading(PlayerPedId())
	if phi > 360.0 then phi = phi - 360.0 end
	if phi < 0.0 then phi = phi + 360.0 end
	local r = scalingFunction( math.sqrt( v.x*v.x + v.y*v.y ) )
	return {['r'] = r, ['phi'] = phi}
end

function transformTargets()
  if not IsEntityDead(PlayerPedId()) then
    local t = {}
    local v = GetEntityCoords(PlayerPedId(), true)
    for _,ent in pairs(targetsEntitys) do
      if not IsEntityDead(ent) then
        table.insert(t, calculateRelativePolarCoordinates(v, GetEntityCoords(ent, true)))
      end
    end
    return t
  else
    TriggerEvent("mtracker:stop")
  end
end

function setTimer()
	timer = GetGameTimer()
end

function getTimer()
  return GetGameTimer() - timer
end

function scalingFunction(r)
	res = 0
	if mtracker_ScalingType == "LOG" then
		if r > 0 then
		res = mtracker_MaxRings * math.log(r)/math.log(mtracker_MaxDistance)
		else
		res = 0
		end
	elseif mtracker_ScalingType == "SQRT" then
		res = mtracker_MaxRings * math.sqrt(r/mtracker_MaxDistance)
	elseif mtracker_ScalingType == "LIN" then
		res = mtracker_MaxRings * r/mtracker_MaxDistance
	end
	return res
end

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    if mTrackerRunning then
      if getTimer() > 15 then
        TriggerEvent('mtracker:updatetargets')
        setTimer()
      end
      if IsControlJustPressed(1, mtracker_StoppingKey) then
        TriggerEvent("mtracker:stop")
      end
    end
  end
end)


function bildirim()  
    local ped = PlayerPedId()
    local playerPos = GetEntityCoords(ped)
    local id = math.random(25, 99)
    
    data = {
        id = id,
        code = 10-40,
        description = "Vehicle Theft",
        location = GetTheStreet(),
        coords = playerPos,
        sprite = 225
    }   
    TriggerServerEvent("jtDispatch:add-notification", data, "police")
end


function bildirim31()  
    local ped = PlayerPedId()
    local playerPos = GetEntityCoords(ped)
    local id = math.random(25, 99)
    
    data = {
        id = id,
        code = 10-40,
        description = name,
        location = GetTheStreet(),
        coords = playerPos,
        sprite = 225
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