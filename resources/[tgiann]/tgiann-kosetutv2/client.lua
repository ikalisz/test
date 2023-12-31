QBCore = nil
Citizen.CreateThread(function()
    while QBCore == nil do
        TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)
        Citizen.Wait(200)
    end
end)  

local satilanNpcler = {}
local rastgeleEsya, rastgeleEsyaAdi, rastgeleEsyaFiyati, miktar, npc, bolgeKordinat, bolgeAdi = nil, nil, nil, nil, nil, nil, nil
local koseTut, npcBulundu, npcAra, startCd, illegalPerm = false, false, false, false, false

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    firstLogin()
end)

function firstLogin()
    local PlayerData = QBCore.Functions.GetPlayerData()
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


local function polisbildirim()
local ped = PlayerPedId()
local playerPos = GetEntityCoords(ped)
local id = math.random(1, 9999)

    data = {
        id = id,
        code = 10-78,
        description = "Illegal Goods Sale on the Corner",
        location = GetTheStreet(),
        coords = playerPos,
        sprite = 47
    }
    TriggerServerEvent("jtDispatch:add-notification", data, "police")
end



RegisterCommand("finishcorner", function(source, args)
	if koseTut then
		startCd = true
		koseTutDurum(false)
		npcBulundu = false
		npcAra = false
		Citizen.Wait(300000)
		startCd = false
		QBCore.Functions.Notify("Cornering finished")
	end
end)

-- Test Blibi
local test = false
Citizen.CreateThread(function()
	if test then
		for kodadi, bolge in pairs(Config.bolge) do
			local kordinat = bolge.kordinat
			local blips = AddBlipForCoord(kordinat)
			SetBlipSprite(blips, 434)
			SetBlipColour(blips, 37)
			SetBlipScale(blips, 2.0)
			SetBlipAsShortRange(blips, true)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString("?")
			EndTextCommandSetBlipName(blips)   
		end
	end
end)


function isNight()
	local hour = GetClockHours()
	if hour > 21 or hour < 8 then
		return true
	end
end



local lastTime = 0
RegisterCommand("corner", function(source, args)
	if not startCd then
		QBCore.Functions.TriggerCallback('elixir-base:polis-sayi', function(AktifPolis)
			if AktifPolis >= 2 then
		if lastTime == 0 or GetGameTimer() > lastTime then
			lastTime = GetGameTimer() + 60000
					if isNight() then
						local playerPed = PlayerPedId()
						if not IsPedInAnyVehicle(playerPed) and not koseTut then
							
							miktar = 1
						if args[1] and tonumber(args[1]) < 4 then
								miktar = tonumber(args[1])
							end 

							koseTutDurum(true)
							npcBulundu = false
							npcAra = true
						elseif IsPedInAnyVehicle(playerPed) then
							QBCore.Functions.Notify("You cannot corner while in the vehicle.")
						else
							QBCore.Functions.Notify("You're Already Holding a Corner")
						end
					else
						QBCore.Functions.Notify("You Can't Sell During the Day!!", "error")
					end
				else
					QBCore.Functions.Notify("You Can Try Taking a Corner in 1 Minute!", "error")
				end
			else
				QBCore.Functions.Notify("Not Enough Police!")
			end
		end)
	else
		QBCore.Functions.Notify("You Just Canceled Corner Hold Try Again In 5 Minutes!", "error")
	end
end)

Citizen.CreateThread(function()
	while true do
		cd = 100
		if koseTut then
			if not npcBulundu and npcAra then
				cd = 5000
				local playerPed = PlayerPedId()
				local playerCoords = GetEntityCoords(playerPed)

				local bolgeBulundu = false
				for kodadi, bolge in pairs(Config.bolge) do
					local bolgeKordinat = bolge["kordinat"]
					if #(bolgeKordinat - playerCoords) < 35 then
						bolgeAdi = kodadi
						bolgeBulundu = true
						break
					end
				end

				if bolgeBulundu then
					QBCore.Functions.Notify('You Keep Holding This Corner')
					Citizen.Wait(3000)
					npc = pedAra(playerPed)
				else
					koseTutDurum(false)
					npcAra = false
					npcBulundu = false
					QBCore.Functions.Notify("You Can't Corner Here", "error")
				end
			end

			if npcBulundu and not npcAra and not satilanNpcler[npc] then
				cd = 1
				local playerPed = PlayerPedId()
				local playerCoords = GetEntityCoords(playerPed)
				local npcCoords = GetEntityCoords(npc)
				local npcMesafe = #(npcCoords - playerCoords)

				if #(bolgeKordinat - playerCoords) < 100 then
					if npcMesafe < 50 then
						local npcArabada = IsPedInAnyVehicle(npc)
						if npcArabada then
							npcAraci = GetVehiclePedIsIn(npc, false)
						end

						QBCore.Functions.DrawText3D(npcCoords.x, npcCoords.y, npcCoords.z+1.05, "~g~[E] ~w~" .. miktar ..  " Piece " .. rastgeleEsyaAdi .." sell / ".. rastgeleEsyaFiyati*miktar .."$ ~g~[H] ~w~fire", 0.45)
						
						if HasEntityBeenDamagedByAnyPed(npc) then
							QBCore.Functions.Notify("Buyer Doesn't Want To Buy Anything Anymore Because He Was Injured!, New Buyer Wanted")
							tekrarNpcAra(true)
							polisbildirim()
							
						elseif npcMesafe <= 2.0 or npcArabada and npcMesafe < 15 then
							if npcArabada then
								FreezeEntityPosition(npcAraci, true)
							else
								FreezeEntityPosition(npc, true)
								QBCore.Shared.RequestAnimDict("anim@amb@clubhouse@mini@darts@", function()
									TaskPlayAnim(npc, "anim@amb@clubhouse@mini@darts@",  "wait_idle", 8.0, -8.0, -1, 0, 0, 0, 0, 0)
								end)
							end

							if npcMesafe <= 2.0 then
								if IsControlJustPressed(0, 51) then -- E
									satilanNpcler[npc] = true
									local durum = nil
									QBCore.Functions.TriggerCallback('tgiann-kosetut:satis-gerceklesti', function(durumx)
										durum = durumx
									end, rastgeleEsya, rastgeleEsyaFiyati, miktar, QBCore.Key)
									while durum == nil do Citizen.Wait(100) end
									if durum then
										animasyon(playerPed, "mp_common", "givetake1_a", false, npc)
										Citizen.Wait(350)
										tekrarNpcAra(false)
									else
										tekrarNpcAra(true)
									end
									Citizen.Wait(5000)
								elseif IsControlJustPressed(0, 304) then -- H
									QBCore.Functions.Notify("You Fired the Buyer")
									if math.random(1, 100) < 7 then
										polisbildirim()
									end
									tekrarNpcAra(true)																
								end
							end
						else
							if npcArabada then
								FreezeEntityPosition(npcAraci, false)
							else
								FreezeEntityPosition(npc, false)
							end
						end
					else
						if math.random(1,100) < 7 then
							polisbildirim()
						end
						QBCore.Functions.Notify("The Buyer Has Moved Too Far From You")
						tekrarNpcAra(true)	
					end
				else
					QBCore.Functions.Notify("Cornering Canceled Because You Moved Too Far From The Cornering Zone")
					if math.random(1,100) < 50 then
						polisbildirim()
					end
					npcBulundu = false
					npcAra = false
					koseTutDurum(false)
				end
			end
		end
		Citizen.Wait(cd)
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1500)
		if npcBulundu and not IsPedInAnyVehicle(npc) then
			local playerPed = PlayerPedId()
	        local playerPos = GetEntityCoords(playerPed)
			TaskGoToCoordAnyMeans(npc, playerPos, 1.0, 0, 0, 786603, 0xbf800000)
		end	
	end
end)

RegisterNetEvent('tgiann-kosetut:async-polis-bildirim')
AddEventHandler('tgiann-kosetut:async-polis-bildirim', function()
end)

function animasyon(ped, ad, anim, npcArabada, npc)
	QBCore.Shared.RequestAnimDict(ad, function()
		if not npcArabada then
			TaskPlayAnim(npc, ad, anim, 8.0, -8.0, -1, 0, 0, 0, 0, 0)
		end
		TaskPlayAnim(ped, ad, anim, 8.0, -8.0, -1, 0, 0, 0, 0, 0)
	end)

	local time = 45000
	polisbildirim()
	QBCore.Functions.Progressbar("satis", "The Sales Transaction Is Occurring", 45000, false, false, { -- p1: menu name, p2: yazı, p3: ölü iken kullan, p4:iptal edilebilir
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = ad,
        anim = anim,
        flags = 49,
    }, {}, {}, function() -- Done
    end, function() -- Cancel
	end)
	Citizen.Wait(time)
end



function pedAra(playerPed)
	local playerCoords = GetEntityCoords(playerPed)
	local handle, ped = FindFirstPed()
	local success
	local rped = nil
	repeat
		local mesafe = #(playerCoords - GetEntityCoords(ped))
		if mesafe < 30.0 and not IsPedAPlayer(ped) and not satilanNpcler[ped] then
			rped = ped
			if not IsPedInAnyVehicle(rped) then
				QBCore.Functions.Notify('A Buyer Is Coming Towards You')
			else
				QBCore.Functions.Notify('A Buyer In A Vehicle Wants To Buy Something From You')
			end

			rastgeleEsyaSec = math.random(1, #Config.bolge[bolgeAdi]["esyalar"]) 
			rastgeleEsya = Config.bolge[bolgeAdi]["esyalar"][rastgeleEsyaSec]
			rastgeleEsyaAdi = QBCore.Shared.Items[rastgeleEsya].label
			rastgeleEsyaFiyati = math.random(exports["elixir-base"]:KoseTut(rastgeleEsya).r1, exports["elixir-base"]:KoseTut(rastgeleEsya).r2)
			bolgeKordinat = playerCoords
			satilanNpcler[rped] = false
			npcBulundu = true
			npcAra = false
			break
		end
		success, ped = FindNextPed(handle)
	until not success
	EndFindPed(handle)
	return rped
end

function tekrarNpcAra(listeEkle)
	if listeEkle then
		satilanNpcler[npc] = true
	end
	Citizen.Wait(2000)
	if IsPedInAnyVehicle(npc) then
		local arac = GetVehiclePedIsIn(npc, false)
		TaskWanderStandard(arac, 10.0, 10)
		FreezeEntityPosition(arac, false)
	else
		TaskWanderStandard(npc, 10.0, 10)
		FreezeEntityPosition(npc, false)
		ClearPedTasks(npc)
	end
	ClearPedTasks(playerPed)
	Citizen.Wait(5000)
	npcBulundu = false
	npcAra = true
end

function koseTutDurum(data)
	koseTut = data
	TriggerEvent("elixir-base:kose-tut-vehicle", koseTut)
end

