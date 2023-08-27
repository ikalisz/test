-- Draw markers & Marker logic
Citizen.CreateThread(function()

	for i=1, #Config.Hospitals.Boss, 1 do
		exports["elixir-base"]:addNotif("E", "Boss Transactions", 2, 1, Config.Hospitals.Boss[i], false, "ambulance", false, true)
	end
end)

RegisterNetEvent('emsKeybindGeneral')
AddEventHandler('emsKeybindGeneral', function()
	if PlayerData.job and PlayerData.job.name == "ambulance" then

		if PlayerData.job.boss then
			for i=1, #Config.Hospitals.Boss, 1 do
				if #(GetEntityCoords(playerPed) - Config.Hospitals.Boss[i]) < 1 then
					QBCore.UI.Menu.CloseAll()
					TriggerEvent('esx_society:openBossMenu', 'ambulance', function(data, menu)
						menu.close()
					end, { wash = false, withdraw = false }) -- disable washing money
					break
				end
			end
		end
	end
end)

function GetClosestPlayerMenu()
	local player, distance = QBCore.Functions.GetClosestPlayer()
	if distance ~= -1 and distance <= 8.0 then
		return true, GetPlayerServerId(player)
	else
		return false
	end
end

RegisterNetEvent('ems:hastakayit')
AddEventHandler('ems:hastakayit', function()
	KayitMenu()
end)

function KayitMenu()
	QBCore.UI.Menu.CloseAll()
	local found, HastaId = GetClosestPlayerMenu()
	local elements = {{label = 'Registered Patients', value = "kayitli"}}
	if found then
		local islemDevemEdiyor = true
		QBCore.Functions.TriggerCallback('tgiann-ambulance:check-player-name', function(targetPlayerName) 
			table.insert(elements, {label = targetPlayerName.. ' ['..HastaId..']', value = targetPlayerName })
			islemDevemEdiyor = false
		end, HastaId)
		while islemDevemEdiyor do Citizen.Wait(1) end
	else
		table.insert(elements, {label = 'No One Near!', value = "noPlayer"})
	end
	
	QBCore.UI.Menu.Open('default', GetCurrentResourceName(), 'hastaIslemler',{
		title    = 'Patient Registration Process',
		align    = 'top-right',
		elements = elements,
	}, function(data, menu)
		if data.current.value == "kayitli" then
			QBCore.Functions.TriggerCallback('esx_ambulancejob_hastakayitdata', function(results) 
				local elements_kayitli = {}
				for i=1, #results, 1 do
					table.insert(elements_kayitli, {label = ('<span style="color:green;font-weight: bold;">%s &nbsp;</span>'):format("Doctor:").. results[i].doktor ..('<span style="color:green;font-weight: bold;">&nbsp; %s &nbsp;</span>'):format("Hasta: ") .. results[i].hasta .. ('<span style="color:green;font-weight: bold;">&nbsp; %s &nbsp;</span>'):format("Explanation:").. results[i].aciklama .. ('<span style="color:green;font-weight: bold;">&nbsp; %s &nbsp;</span>'):format("Tarih:").. results[i].tarih})
				end

				QBCore.UI.Menu.Open('default', GetCurrentResourceName(), 'kayitliHastalar', {
					title = "Registered Patients",
					align = 'top-right',
					elements = elements_kayitli,
				}, function(data2, menu2)
				end, function(data2, menu2)
					menu2.close()
				end)
			end)
		elseif data.current.value ~= "noPlayer" then
			QBCore.UI.Menu.Open('dialog', GetCurrentResourceName(), 'kayitMenu', {
				title = "Explanation"
			},function(data2, menu2)
				menu2.close()
				TriggerServerEvent("esx_ambulancejob_hastakayit", data.current.value, data2.value, PlayerData.charinfo.firstname.. " " ..PlayerData.charinfo.lastname)
				FaturaKes(HastaId)
			end, function(data2, menu2)
				menu2.close()
			end)
		end
		
	end, function(data, menu)
		menu.close()
	end)
end

function FaturaKes(HastaId)
	QBCore.UI.Menu.Open('dialog', GetCurrentResourceName(), 'billing', {
		title = "Invoice"
	}, function(data, menu)
		local amount = tonumber(data.value)
		if amount == nil or amount < 0 then
			QBCore.Functions.Notify("Incorrect Value", "error")
		else
			TriggerServerEvent('esx_billing:sendBill', HastaId, 'ambulance', "Hastane", amount)
			QBCore.Functions.Notify("Invoice has been issued to the patient")
			menu.close()
		end
	end, function(data, menu)
		menu.close()
	end)
end	

RegisterNetEvent('esx_ambulancejob:TgiannCanlandir')
AddEventHandler('esx_ambulancejob:TgiannCanlandir', function(closestPlayer)
	local playerPed = PlayerPedId()
	if not IsBusy then
		IsBusy = true
		time = 90000  
		for k,v in pairs(Config.Hospitals.Blip) do
			if #(GetEntityCoords(playerPed) - v.coords) < 150 or #(GetEntityCoords(playerPed) - vector3(473.36, -1008.9, 34.22)) < 150 or #(GetEntityCoords(playerPed) - vector3(4435.62, -4446.72, 4.33)) < 150 then
				time = 5000
			end
		end
		QBCore.Functions.Progressbar("oyuncu_iyilestir", "The player is being healed", time, false, true, { -- p1: menu name, p2: yazı, p3: ölü iken kullan, p4:iptal edilebilir
			disableMovement = true,
			disableCarMovement = true,
			disableMouse = false,
			disableCombat = true,
		}, {
			animDict = "mini@cpr@char_a@cpr_str",
			anim = "cpr_pumpchest",
			flags = 16,
		}, {}, {}, function() -- Done
			TriggerServerEvent('esx_ambulancejob:revive', closestPlayer)
			QBCore.Functions.Notify("Earned $50 for Healing the Injured")
			IsBusy = false
		end, function() -- Cancel
			IsBusy = false
		end)

	end
end)

RegisterNetEvent('esx_ambulancejob:TgiannIgne')
AddEventHandler('esx_ambulancejob:TgiannIgne', function(closestPlayer)
	if not IsBusy then
		IsBusy = true
		QBCore.Functions.Progressbar("oyuncuya_igne", "Injecting Drugs!", 5500, false, true, { -- p1: menu name, p2: yazı, p3: ölü iken kullan, p4:iptal edilebilir
			disableMovement = true,
			disableCarMovement = true,
			disableMouse = false,
			disableCombat = true,
		}, {
			animDict = "anim@gangops@facility@servers@bodysearch@",
			anim = "player_search",
			flags = 48,
		}, {}, {}, function() -- Done
			TriggerServerEvent('esx_ambulancejob:igne', closestPlayer, QBCore.Key)
			IsBusy = false
		end, function() -- Cancel
			IsBusy = false
		end)
	end
end)

local tekneSpawn = false
RegisterCommand("boat", function()
	if not tekneSpawn then
		if PlayerData.job and PlayerData.job.name == "ambulance" then
			local PlayerPed = PlayerPedId()
			if IsPedSwimming(PlayerPed) then
				tekneSpawn = true
				local sayi = 10
				while sayi > 0 do
					QBCore.Functions.Notify('Vehicle '..sayi..' Will Be Released in Seconds!')
					sayi = sayi - 1
					Citizen.Wait(1000)
				end

				local coords = GetEntityCoords(PlayerPed)
				QBCore.Functions.SpawnVehicle(`dinghy`, function(vehicle)
					QBCore.Functions.Notify('Vehicle Removed!')
					SetVehRadioStation(vehicle, "OFF")
					TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
					TriggerEvent("x-hotwire:give-keys", vehicle)
				end, {x=coords.x + 1, y=coords.y + 1, z=coords.z + 1, h= 90.0 }, true)
				tekneSpawn = false
			else
				local vehicle, distance = QBCore.Functions.GetClosestVehicle(GetEntityCoords(PlayerPed))
				if distance < 3 then
					if GetEntityModel(vehicle) == `dinghy` then
						QBCore.Functions.DeleteVehicle(vehicle)
						QBCore.Functions.Notify('Vehicle Towed!')
					else
						QBCore.Functions.Notify('Not Near Vehicle EMS Boat', 'error')
					end
				else
					QBCore.Functions.Notify('No Vehicles Nearby!', 'error')
				end
			end
		end
	end
end)