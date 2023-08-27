local PlayerData = {}
local paraTasimaGoreviAktif, GorevAraci, paraYukleniyor, paraAlindi, parayiAl, aracParaMiktari, paralarAlindi, rastgeleBanka, sure, aktifAlan, aractakiToplamPara, sonAdim = false, nil, false, false, false, 0, false, 1, 0, nil, 0, false
local paraAraciBulundu, yakindakiArac, soygunAractakiToplamPara = false, nil, 0
local bildirimGonderSayi = 0
local npcArac = false

QBCore = nil
local coreLoaded = false
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
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate')
AddEventHandler('QBCore:Client:OnJobUpdate', function(job)
    PlayerData.job = job
end)

--[[ 
Citizen.CreateThread(function()
	local blipData = Config.Blip
	local blip = AddBlipForCoord(blipData.Coords)

	SetBlipSprite(blip, blipData.Sprite)
	SetBlipDisplay(blip, blipData.Display)
	SetBlipScale(blip, blipData.Scale)
	SetBlipColour(blip, blipData.Colour)
	SetBlipAsShortRange(blip, true)

	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString('Özel Güvenlik Şirketi')
	EndTextCommandSetBlipName(blip)
end) ]]

function OpenArmoryMenu(station)
	QBCore.UI.Menu.CloseAll()
	QBCore.UI.Menu.Open('default', GetCurrentResourceName(), 'armory', {
		title    = "Private Security Company Arms",
		align    = 'top-left',
		elements = {
			{label = "Buy Weapons", value = 'buy_weapons'},
			{label = 'Weapons Merchant Inventory', value = 'put_stock'},
		}
	}, function(data, menu)
		if data.current.value == 'buy_weapons' then
			menu.close()
			TriggerServerEvent("inventory:server:OpenInventory", "shop", "merry", Config.Items)
		elseif data.current.value == 'put_stock' then
			menu.close()
			TriggerEvent("inventory:client:SetCurrentStash", "merryweatherDepo", QBCore.Key)
			TriggerServerEvent("inventory:server:OpenInventory", "stash", "merryweatherDepo", {maxweight = 4000000,slots = 500,})
		end

	end, function(data, menu)
		menu.close()
	end)
end

local weaponRepair = vector3(1005.74, -2483.39, 28.46) --vector3(2328.14, 2569.87, 46.68) 
Citizen.CreateThread(function()
	while true do
		local time = 250
		local playerPed = PlayerPedId()
		local playerCoords = GetEntityCoords(playerPed)
		local distance = #(playerCoords - weaponRepair)
		if distance < 5 and coreLoaded then
			time = 1
			local text = ""
			if distance < 1 then
				text = "[E] "
				if IsControlJustPressed(0, 38) then 
					QBCore.UI.Menu.CloseAll()
					repairMenu()
				end
			end
			QBCore.Functions.DrawText3D(weaponRepair.x,weaponRepair.y,weaponRepair.z, text.."Repair Weapon")
		end
		Citizen.Wait(time)
	end
end)

-- Display markers
Citizen.CreateThread(function()
	while true do
		local time = 5000
		if PlayerData.job and PlayerData.job.name == 'mafia' then 
			time = 1000
			local playerPed = PlayerPedId()
			local playerCoords = GetEntityCoords(playerPed)

			for merryNum, location in pairs(Config.MafiaStation) do
				for k,coord in ipairs(location.Armories) do
					local distance = #(playerCoords - coord)
					if distance < 2 then
						time = 1
						local text = ""
						if distance < 1 then
							text = "[E] "
							if IsControlJustPressed(0, 38) then
								OpenArmoryMenu()
							end
						end
						QBCore.Functions.DrawText3D(coord.x,coord.y,coord.z, text.."Depo")
					end
				end

				for k,coord in ipairs(location.BossActions) do
					local distance = #(playerCoords - coord)
					if distance < 2 then
						time = 1
						local text = ""
						if distance < 1 then
							text = "[E] "
							if IsControlJustPressed(0, 38) then 
								QBCore.UI.Menu.CloseAll()
								TriggerEvent('esx_society:openBossMenu', 'mafia', function(data, menu)
									menu.close()
								end, { wash = false }) -- disable washing money
							end
						end
						QBCore.Functions.DrawText3D(coord.x,coord.y,coord.z, text.."Boss Transactions")
					end
				end

				

				if  PlayerData.job.boss then
					for k,coord in ipairs(location.paraTasima) do
						local distance = #(playerCoords - coord)
						if distance < 10 then
							time = 1
							DrawMarker(2, coord.x, coord.y, coord.z-0.45, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.6, 0.6, 0.6, 0, 88, 155, 100, false, true, 2, false, false, false, false)
							if distance < 2 then
								local text = ""
								if distance < 1 then
									text = "[E] "
									if IsControlJustPressed(0, 38) then 
										QBCore.Functions.TriggerCallback('ozelGuvenlik:time-control', function(status)
											if status then
												paraTasimaAktif()
											end
										end)
									end
								end
								QBCore.Functions.DrawText3D(coord.x,coord.y,coord.z, text.."Money Transport Mission")
							end
						end
					end
				end

			end
		end
		Citizen.Wait(time)
	end
end)

function repairMenu()
	QBCore.Functions.Notify("Make Sure You Have A Weapon That You Will Only Repair As A Weapon Or You Might Fix The Wrong Weapon!", "error", 25000)
	QBCore.UI.Menu.Open('default', GetCurrentResourceName(), 'npc_craft', {
		title    = "Weapon Repair Menu",
		align    = 'top-left',
		elements = {
			{label = "Repair Gun", value = "pistol"},
			-- {label = "SMG Tamir Et", value = "smg"},
			-- {label = "Tüfek Tamir Et", value = "taarruz"},
			-- {label = "Pompalı Tamir Et", value = "pomba"},
			-- {label = "Taser ve Yakın Dövüş Silahlarını Tamir Et", value = "diger"},
		}
	},function(data, menu)
		if data.current.value then	
			SetCurrentPedWeapon(PlayerPedId(), `WEAPON_UNARMED`, true)
            TriggerServerEvent("tgiann-merrtweather:repair-weapon", data.current.value, true)
			menu.close()
		end
	end, function(data, menu)
		menu.close()
	end)
end

local bankar = {
	[1] = {x = 319.32, y = -268.59, z = 53.76, px = 311.25, py = -283.19, pz = 53.76},
	[2] = {x = -345.76, y = -29.81, z = 47.38, px = -353.35, py = -54.31, pz = 49.04},
	[3] = {x = 1173.53, y = 2696.9, z = 37.96, px = 1176.26, py = 2711.61, pz = 38.09},
	[4] = {x = -2973.14, y = 480.65, z = 15.25, px = -2957.56, py = 481.94, pz = 15.7},
	[5] = {x = -118.28, y = 6460.21, z = 31.47, px = -102.91, py = 6469.37, pz = 31.63},
}

function paraTasimaAktif()
	paraTasimaGoreviAktif = true
	parayiAl = true
	aracParaMiktari = math.random(70000,90000)
	aractakiToplamPara = aracParaMiktari
	rastgeleBanka = math.random(1,5)
	local playerPed = PlayerPedId()
	QBCore.Functions.SpawnVehicle(1747439474, function(arac)
		GorevAraci = arac
		TaskWarpPedIntoVehicle(playerPed, arac, -1)
		TriggerEvent("x-hotwire:give-keys", arac)
	end, {x=504.39, y=-3128.04, z=6.07, h=177.07 }, true)

	SetNewWaypoint(bankar[rastgeleBanka].x, bankar[rastgeleBanka].y)
	QBCore.Functions.Notify("The Delivery Point is marked on the GPS, load the money immediately behind the vehicle before you go")
end

Citizen.CreateThread(function()
	while true do
		local playerPed = PlayerPedId()
		if paraTasimaGoreviAktif then
			sure1 = 1
			-- Parayı Al
			if parayiAl and aracParaMiktari > 0 then
				if PlayerData.job.name == 'mafia' and PlayerData.job.boss then
					if (GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId(), true), 503.65, -3121.21, 6.07, true) < 5) then
						QBCore.Functions.DrawText3D(503.65, -3121.21, 6.07, "[E] Get the money", 0.45)
						if (GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId(), true), 503.65, -3121.21, 6.07, true) < 1) then			
							if IsControlJustPressed(1, 38) and parayiAl then
								paraAlindi = true
								parayiAl = false
								QBCore.Functions.Progressbar("paraları_al", "Collecting Money", 5000, false, true, { -- p1: menu name, p2: yazı, p3: ölü iken kullan, p4:iptal edilebilir
									disableMovement = false,
									disableCarMovement = false,
									disableMouse = false,
									disableCombat = true,
								}, {
									animDict = "missexile3",
									anim = "ex03_dingy_search_case_base_michael",
									flags = 49,
								}, {}, {}, function() -- Done
									if aracParaMiktari > 0 and aracParaMiktari >= 5000 then
										aracParaMiktari = aracParaMiktari - 5000
										QBCore.Functions.Notify("You Got $5,000 and " .. QBCore.Shared.GroupDigits(aracParaMiktari) .. "$ More German Required")
										TriggerServerEvent("ozelGuvenlik:aracaParaKoy", 5000, QBCore.Shared.Trim(GetVehicleNumberPlateText(GorevAraci)), QBCore.Key)
									elseif aracParaMiktari > 0 and aracParaMiktari <= 5000 then
										TriggerServerEvent("ozelGuvenlik:aracaParaKoy", aracParaMiktari, QBCore.Shared.Trim(GetVehicleNumberPlateText(GorevAraci)), QBCore.Key)
										QBCore.Functions.Notify("You got " .. QBCore.Shared.GroupDigits(aracParaMiktari) .. "$ and there's no more money to take")
										aracParaMiktari = 0
									end
								end, function() -- Cancel
									-- Cancel
								end)

							end
						end
					end
				end
			end

			-- Alınan Parayı Araca Koy
			if not IsPedInAnyVehicle(playerPed, false) and paraAlindi then
				if PlayerData.job.name == 'mafia' and PlayerData.job.boss then
					local arackordinat = GetEntryPositionOfDoor(GorevAraci, 2)
					if (GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId(), true), arackordinat.x, arackordinat.y, arackordinat.z, true) < 1.5) then
						aktifAlan = "paraKoy"
						if IsControlJustPressed(1, 38) then
							aktifAlan = nil
							if aracParaMiktari > 0 then
								parayiAl = true
							else
								paralarAlindi = true
							end
							paraAlindi = false
							SetVehicleDoorOpen(GorevAraci, 2, 0, 0)
							SetVehicleDoorOpen(GorevAraci, 3, 0, 0)
							Citizen.Wait(1000)

							QBCore.Functions.Progressbar("para_yükle", "Loading Money", 5000, false, true, { -- p1: menu name, p2: yazı, p3: ölü iken kullan, p4:iptal edilebilir
								disableMovement = true,
								disableCarMovement = true,
								disableMouse = false,
								disableCombat = true,
							}, {
								animDict = "missexile3",
								anim = "ex03_dingy_search_case_base_michael",
								flags = 49,
							}, {}, {}, function() -- Done
								Citizen.Wait(1000)
								SetVehicleDoorShut(GorevAraci,2,0)
								SetVehicleDoorShut(GorevAraci,3,0)
								if aracParaMiktari == 0 then
									QBCore.Functions.Notify("You Have Successfully Loaded All the Money into the Vehicle")
								end
							end, function() -- Cancel
								-- Cancel
							end)
							
						end
					else
						aktifAlan = nil
					end
				end
			end

			-- Araçtan Paraları Alma
			if not IsPedInAnyVehicle(playerPed, false) and paralarAlindi then
				if PlayerData.job.name == 'mafia' and PlayerData.job.boss then
					if (GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId(), true), bankar[rastgeleBanka].x, bankar[rastgeleBanka].y, bankar[rastgeleBanka].z, true) < 15.0) then
						local arackordinat = GetEntryPositionOfDoor(GorevAraci, 2)
						if (GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId(), true), arackordinat.x, arackordinat.y, arackordinat.z, true) < 1.5) then
							aktifAlan = "paraAl"
							if IsControlJustPressed(1, 38) then
								aktifAlan = nil
								paralarAlindi = false
								SetVehicleDoorOpen(GorevAraci, 2, 0, 0)
								SetVehicleDoorOpen(GorevAraci, 3, 0, 0)
								Citizen.Wait(1000)
								QBCore.Functions.Progressbar("paraları_al", "Collecting Money", 120000, false, true, { -- p1: menu name, p2: yazı, p3: ölü iken kullan, p4:iptal edilebilir
									disableMovement = true,
									disableCarMovement = true,
									disableMouse = false,
									disableCombat = true,
								}, {
									animDict = "missexile3",
									anim = "ex03_dingy_search_case_base_michael",
									flags = 49,
								}, {}, {}, function() -- Done
									SetVehicleDoorShut(GorevAraci,2,0)
									SetVehicleDoorShut(GorevAraci,3,0)
									TriggerServerEvent("elixir-base:KullanciPara", QBCore.Key, "ekle", "üst", aractakiToplamPara)
									TriggerServerEvent("ozelGuvenlik:aracaParaKoy", 0, QBCore.Shared.Trim(GetVehicleNumberPlateText(GorevAraci)), QBCore.Key)
									QBCore.Functions.Notify("You Received the ".. aractakiToplamPara .." Dollars in the Vehicle Now Deliver the Money to the Bank")
									sonAdim = true
								end, function() -- Cancel
									aktifAlan = "paraAl"
									paralarAlindi = true
								end)
							end
						else
							aktifAlan = nil
						end
					end
				end
			end

			-- Araçtan alınan paraları bankaya verme
			if not IsPedInAnyVehicle(playerPed, false) and sonAdim then
				if PlayerData.job.name == 'mafia' and PlayerData.job.boss then
					if (GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId(), true), bankar[rastgeleBanka].px, bankar[rastgeleBanka].py, bankar[rastgeleBanka].pz, true) < 5.0) then
						QBCore.Functions.DrawText3D(bankar[rastgeleBanka].px, bankar[rastgeleBanka].py, bankar[rastgeleBanka].pz, "[E] Deliver the Money", 0.45)
						if (GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId(), true), bankar[rastgeleBanka].px, bankar[rastgeleBanka].py, bankar[rastgeleBanka].pz, true) < 1.0) then
							if IsControlJustPressed(1, 38) then
								sonAdim = false
								QBCore.Functions.Progressbar("para_teslim", "Coins being delivered", 120000, false, true, { -- p1: menu name, p2: yazı, p3: ölü iken kullan, p4:iptal edilebilir
									disableMovement = true,
									disableCarMovement = true,
									disableMouse = false,
									disableCombat = true,
								}, {}, {}, { }, function() -- Done
									TriggerServerEvent("elixir-base:KullanciPara", QBCore.Key, "sil", "üst", aractakiToplamPara)
									TriggerServerEvent("elixir-base:KullanciPara", QBCore.Key, "ekle", "üst", aractakiToplamPara/100*20)
									QBCore.Functions.Notify("Delivery Successful!")
									QBCore.Functions.Notify("You Receive Your Delivery Charge! " .. aractakiToplamPara/100*20 .. "$")
									aractakiToplamPara = 0
								end, function() -- Cancel
									sonAdim = true
								end)
							end
						end
					end
				end
			end
			
		else
			sure1 = 5000
		end
		Citizen.Wait(sure1)
	end
end)

RegisterNetEvent('tgiann-merryweather:para-araci')
AddEventHandler('tgiann-merryweather:para-araci', function()
	if not paraAraciBulundu then
		QBCore.Functions.TriggerCallback('ozelGuvenlik:aractakiPara', function(data)
			yakindakiArac, mesafe = QBCore.Functions.GetClosestVehicle(GetEntityCoords(PlayerPedId(), true))
			if mesafe < 10 then
				if GetEntityModel(yakindakiArac) == 1747439474 then
					if data.arac == QBCore.Shared.Trim(GetVehicleNumberPlateText(yakindakiArac)) then
						if data.para > 0 then
							QBCore.Functions.Notify("You Found the Car Full of Money")
							paraAraciBulundu = true
							soygunAractakiToplamPara = data.para
						else
							QBCore.Functions.Notify("You Found The Right Car, But There's No Money In It!")
						end
					else
						QBCore.Functions.TriggerCallback('elixir-base:polis-sayi', function(AktifPolis)
							if AktifPolis >= 7 then --3
								QBCore.Functions.TriggerCallback('ozelGuvenlik:npc-soyuldumu', function(data)
									if data then
										if IsVehicleSeatFree(yakindakiArac, -1) == 1 then
											QBCore.Functions.Notify("You Found the Car Full of Money")
											paraAraciBulundu = true
											npcArac = true
											loadPed(`s_m_m_security_01`)
											loadPed(`csb_mweather`)
											local security1 = CreatePedInsideVehicle(yakindakiArac, 29, `s_m_m_security_01`, 1, true, false)
											local security2 = CreatePedInsideVehicle(yakindakiArac, 29, `csb_mweather`, 2, true, false)
											giveWeponPed(security1, "WEAPON_CARBINERIFLE")
											giveWeponPed(security2, "WEAPON_COMBATPDW")
											Citizen.Wait(85000)
											local PlayerCords = GetEntityCoords(PlayerPedId())
											local found, spawnPos, spawnHeading = GetClosestVehicleNodeWithHeading(PlayerCords.x + math.random(30, 80), PlayerCords.y + math.random(20, 60), PlayerCords.z, 0, 3, 0)
										
											QBCore.Functions.SpawnVehicle(`cog55`, function(securityCar)
												ClearAreaOfVehicles(GetEntityCoords(securityCar), 5000, false, false, false, false, false)
												SetVehicleOnGroundProperly(securityCar)
												local security2 = CreatePedInsideVehicle(securityCar, 12, `csb_mweather`, -1, true, false)
												local security3 = CreatePedInsideVehicle(securityCar, 12, `csb_mweather`, 0, true, false)
												giveWeponPed(security2, "WEAPON_MACHINEPISTOL")
												giveWeponPed(security3, "WEAPON_MACHINEPISTOL")

											end, {x=spawnPos.x, y=spawnPos.y, z=spawnPos.z, h=spawnHeading}, true) -- coords, isnetwork
											SetModelAsNoLongerNeeded(`s_m_m_security_01`)
											SetModelAsNoLongerNeeded(`csb_mweather`)
										else
											QBCore.Functions.Notify("You Can't Control the Vehicle While Someone Is In The Driver's Seat!", "error")
										end
									else
										QBCore.Functions.Notify("This Vehicle Has Already Been Stripped")
									end
								end, QBCore.Shared.Trim(GetVehicleNumberPlateText(yakindakiArac)), true)
							else
								QBCore.Functions.Notify("Not Enough Cops on Server")
							end
						end)
					end
				else
					QBCore.Functions.Notify("Nearby Vehicle Not Bank Money Tool")
				end
			else
				QBCore.Functions.Notify("No Vehicles Nearby")
			end
		end)
	end
end)

function loadPed(ped)
	RequestModel(ped)
	while not HasModelLoaded(ped) and RequestModel(ped) do
		RequestModel(ped)
		Citizen.Wait(0)
	end
end

function giveWeponPed(ped, weapon)
	SetPedCanRagdoll(ped, false)
	SetPedSuffersCriticalHits(ped, false)
	RemoveAllPedWeapons(ped, true)  
	SetPedDropsWeaponsWhenDead(ped,false)

    GiveWeaponToPed(ped, GetHashKey(weapon), 120, 0, 1)
	SetCurrentPedWeapon(ped, GetHashKey(weapon), true)

	SetPedArmour(ped, math.random(120,200))
	local rastgeleCan = math.random(300,380)
    SetEntityMaxHealth(ped, rastgeleCan)
    SetEntityHealth(ped, rastgeleCan)

    SetPedRelationshipGroupHash(ped, `COP`)
	SetPedRelationshipGroupDefaultHash(ped, `COP`)
	
	SetPedCombatAttributes(ped, 46, true)
	SetPedAccuracy(ped, math.random(85,100))
	SetPedCombatMovement(ped, 2)
	SetPedCombatAbility(ped, 100)
	SetPedCombatRange(ped, 0)
	SetPedAsCop(ped, true)
	SetCanAttackFriendly(ped, false, true)
	TaskCombatPed(ped, PlayerPedId(), 0, 16)
end

Citizen.CreateThread(function()
	while true do
		if paraAraciBulundu then
			sure2 = 1
			local playerPed = PlayerPedId()
			if not IsPedInAnyVehicle(playerPed, false) then
				local arackordinat = GetEntryPositionOfDoor(yakindakiArac, 2)
				if #(GetEntityCoords(playerPed) - arackordinat) < 1.5 then
					aktifAlan = "paraÇal"
					if IsControlJustPressed(1, 38) then
						FreezeEntityPosition(yakindakiArac, true)
						FreezeEntityPosition(playerPed, true)
						if npcArac then
							bildirimGonderSayi = 3
							aramaSure = math.random(480000, 540000)
							--aramaSure = math.random(10000, 12000)
						else
							aramaSure = 120000
						end
						aktifAlan = nil
						paraAraciBulundu = false
						SetVehicleDoorOpen(yakindakiArac, 2, 0, 0)
						SetVehicleDoorOpen(yakindakiArac, 3, 0, 0)
						Citizen.Wait(1000)

						QBCore.Functions.Progressbar("para_çal", "Receiving Money", aramaSure, false, true, { -- p1: menu name, p2: yazı, p3: ölü iken kullan, p4:iptal edilebilir
							disableMovement = true,
							disableCarMovement = true,
							disableMouse = false,
							disableCombat = true,
						}, {
							animDict = "missexile3",
							anim = "ex03_dingy_search_case_base_michael",
							flags = 49,
						}, {}, {}, function() -- Done
							SetVehicleDoorShut(yakindakiArac, 2, 0)
							SetVehicleDoorShut(yakindakiArac, 3, 0)
							
							if npcArac then
								QBCore.Functions.TriggerCallback('ozelGuvenlik:npc-soyuldumu', function(data)
									if data then
										TriggerServerEvent("esx_guvenlik:item-ve-para", QBCore.Shared.Trim(GetVehicleNumberPlateText(yakindakiArac)), QBCore.Key)
									else
										QBCore.Functions.Notify("Someone Else Takes the Money in the Vehicle")
									end
								end, QBCore.Shared.Trim(GetVehicleNumberPlateText(yakindakiArac)), false)
							else
								TriggerServerEvent("ozelGuvenlik:aracaParaKoy", 0, QBCore.Shared.Trim(GetVehicleNumberPlateText(yakindakiArac)), QBCore.Key)
								TriggerServerEvent("elixir-base:KullanciPara", QBCore.Key, "ekle", "üst", soygunAractakiToplamPara)
								QBCore.Functions.Notify("You Take the ".. soygunAractakiToplamPara .." dollar in the vehicle!")
								TriggerServerEvent("tgiann-merryweather:server:soygun-engel", arackordinat)
							end
							FreezeEntityPosition(yakindakiArac, false)
							FreezeEntityPosition(playerPed, false)
						end, function() -- Cancel
							aktifAlan = "paraÇal"
							paraAraciBulundu = true
							FreezeEntityPosition(yakindakiArac, false)
							FreezeEntityPosition(playerPed, false)
						end)
					
					end
				else
					aktifAlan = nil
				end
				
			end
		else
			sure2 = 5000
		end
		Citizen.Wait(sure2)
	end
end)

Citizen.CreateThread(function()
	while true do
		if bildirimGonderSayi > 0 then
			polisBildirim()
			-- TriggerEvent("Tgiann-PolisBildirim:BildirimGonder", "Banka Aracı Kaçırıldı", false)
			bildirimGonderSayi = bildirimGonderSayi - 1
			Citizen.Wait(60000)
		end
		Citizen.Wait(1000)
	end
end)

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

function polisBildirim()  
    if not bildirimGonderildi then
        bildirimGonderildi = true
		local playerPed = PlayerPedId()
		local currentPos = GetEntityCoords(playerPed)
		local gender = IsPedMale(playerPed)
		TriggerServerEvent('dispatch:svNotify', {
			dispatchCode = "10-60",
			firstStreet = GetStreetAndZone(),
			gender = gender,
			priority = 2,
			origin = {x = currentPos.x, y = currentPos.y, z = currentPos.z},
			dispatchMessage = "Bank Vehicle Robbed"
		})
    end
end

Citizen.CreateThread(function()
	while true do
		sure = 1000
		local coords = GetEntityCoords(PlayerPedId())
		if aktifAlan == "paraKoy" then
			sure = 1
			QBCore.Functions.DrawText3D(coords.x,coords.y,coords.z, "[E] Put Money in Vehicle")
		elseif aktifAlan == "paraAl" or aktifAlan == "paraÇal" then
			sure = 1
			QBCore.Functions.DrawText3D(coords.x,coords.y,coords.z, "[E] Get Money in Vehicle")
		end
		Citizen.Wait(sure)
	end
end)

RegisterNetEvent('tgiann-merryweather:client:soygun-engel')
AddEventHandler('tgiann-merryweather:client:soygun-engel', function(coords)
	if #(GetEntityCoords(PlayerPedId()) - coords) < 50 then
        TriggerEvent("elixir-base:soygun-engel")
    end
end)

local seriNoDegis = vector3(-1517.1673583984, 111.4408493042, 50.052989959717) --4998.14, -5752.4, 14.84
Citizen.CreateThread(function()
	while true do
		time = 250
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
		local distance = #(coords - seriNoDegis)
		if distance < 2 and coreLoaded and not bussy then 
			time = 1
			local text = ""
			if distance < 1 then
				text = "[E] "
				if IsControlJustReleased(0, 38) then 
					if IsPedArmed(playerPed, 7) then
						local _,wep = GetCurrentPedWeapon(playerPed)
						TriggerServerEvent("tgiann-merrtweather:change-weapon-serial", QBCore.Shared.WeaponsHashtoName[wep], QBCore.Key)
						SetCurrentPedWeapon(playerPed, `WEAPON_UNARMED`, true)
					else
						QBCore.Functions.Notify("You must have a gun", "error")
					end
					Citizen.Wait(2000)
				end
			end
			QBCore.Functions.DrawText3D("Change Serial Number" ..seriNoDegis.x, seriNoDegis.y, seriNoDegis.z, text) -- 4998.14, -5752.4, 14.84
		end
		Citizen.Wait(time)
	end
end) 