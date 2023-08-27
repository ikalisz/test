local PlayerData, dragStatus = {}, {}
dragStatus.isDragged = false

QBCore = nil
Citizen.CreateThread(function()
    while QBCore == nil do
        TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)
        Citizen.Wait(200)
    end
	PlayerData = QBCore.Functions.GetPlayerData()

end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    PlayerData = QBCore.Functions.GetPlayerData()
end)

RegisterNetEvent("policeloaded", function()
    PlayerData = QBCore.Functions.GetPlayerData()
	PlayerData.job = job
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate')
AddEventHandler('QBCore:Client:OnJobUpdate', function(job)
	PlayerData.job = job
end)

-- RegisterCommand('mesai', function()
-- 	TriggerServerEvent("QBCore:ToggleDuty")
-- end)

playerPed = PlayerPedId()
playerCoord = GetEntityCoords(playerPed)

Citizen.CreateThread(function()

	for i=1, #Config.PoliceStations.BossActions, 1 do
		exports["elixir-base"]:addNotif("E", "Boss Transactions", 2, 1, Config.PoliceStations.BossActions[i], false, "police", false, true)
	end

	for k,v in pairs(Config.PoliceStations.Blip) do
		local blip = AddBlipForCoord(v.Coords)

		SetBlipSprite (blip, v.Sprite)
		SetBlipDisplay(blip, v.Display)
		SetBlipScale  (blip, 0.7)
		SetBlipColour (blip, v.Colour)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Mission Row Police Department")
		EndTextCommandSetBlipName(blip)
	end
	while true do
		playerPed = PlayerPedId()
		playerCoord = GetEntityCoords(playerPed)
		Citizen.Wait(500)
	end
end)

function KayitMenuPolis()
	QBCore.UI.Menu.CloseAll()
	QBCore.UI.Menu.Open('default', GetCurrentResourceName(), 'room_invite', {
		title    = 'Patient Registration Process',
		align    = 'top-right',
		elements = {
			{label = 'Registered Patients', value = "kayitli"}
		},
	}, function(data, menu)
		if data.current.value == "kayitli" then
			menu.close()
			QBCore.Functions.TriggerCallback('esx_ambulancejob_hastakayitdata', function(results) 
				local elements_kayitli     = {}
				
				for i=1, #results, 1 do
					table.insert(elements_kayitli, {label = ('<span style="color:green;font-weight: bold;">%s &nbsp;</span>'):format("Doctor:").. results[i].doktor ..('<span style="color:green;font-weight: bold;">&nbsp; %s &nbsp;</span>'):format("Patient: ") .. results[i].hasta .. ('<span style="color:green;font-weight: bold;">&nbsp; %s &nbsp;</span>'):format("Explanation:").. results[i].aciklama .. ('<span style="color:green;font-weight: bold;">&nbsp; %s &nbsp;</span>'):format("History:").. results[i].tarih})
				end
				
				QBCore.UI.Menu.Open('default', GetCurrentResourceName(), 'aciklama_menu',
				{
					title = "Registered Patients",
					align    = 'top-right',
					elements = elements_kayitli,
				},
				function(data2, menu2)
					menu2.close()
				end, function(data2, menu2)
					menu2.close()
				end)
			end)
		elseif data.current.value == "kapat" then
			menu.close()
		end
		
	end, function(data, menu)
		menu.close()
	end)
end

function OpenCloakroomMenu()
	-- Giysi Yeri
end

function OpenFineMenu()
	QBCore.UI.Menu.Open('dialog', GetCurrentResourceName(), 'billing', {
		title = "Total Amount of Fine to be Deducted"
	}, function(data, menu)
		local amount = tonumber(data.value)

		if amount == nil or amount < 0 then
			QBCore.Functions.Notify("Incorrect Value")
		else
			local closestPlayer, closestDistance = QBCore.Functions.GetClosestPlayer()
			if closestPlayer == -1 or closestDistance > 3.0 then
				QBCore.Functions.Notify("No One Nearby!")
			else
				menu.close()
				QBCore.Functions.Notify(amount ..'$ Penalty Worth Sent to Person!')
				TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(closestPlayer), 'police', "LS Police", amount)
			end
		end
	end, function(data, menu)
		menu.close()
	end)
end

function ShowPlayerLicense(player)
	local elements, targetName = {}
	QBCore.Functions.TriggerCallback('esx_policejob:getOtherPlayerData', function(data)
		if data.licenses then
			for i=1, #data.licenses, 1 do
				if data.licenses[i].label and data.licenses[i].type then
					table.insert(elements, {
						label = data.licenses[i].label,
						type = data.licenses[i].type
					})
				end
			end
		end

		if Config.EnableESXIdentity then
			targetName = data.firstname .. ' ' .. data.lastname
		else
			targetName = data.name
		end

		QBCore.UI.Menu.Open('default', GetCurrentResourceName(), 'manage_license', {
			title    = "License Cancel",
			align    = 'top-left',
			elements = elements,
		}, function(data, menu)
			QBCore.Functions.Notify("Player's License Revoked")
			TriggerServerEvent('esx_license:removeLicense', player, data.current.type)

			Citizen.Wait(300)
			ShowPlayerLicense(player)
			
		end, function(data, menu)
			menu.close()
		end)

	end, player)
end

function OpenUnpaidBillsMenu(player)
	local elements = {}

	QBCore.Functions.TriggerCallback('esx_billing:getTargetBills', function(bills)
		for k,bill in ipairs(bills) do
			table.insert(elements, {
				label = ('%s - &nbsp;<span style="color:red;">%s</span>'):format(bill.label, " $".. QBCore.Shared.GroupDigits(bill.amount)),
				billId = bill.id
			})
		end

		QBCore.UI.Menu.Open('default', GetCurrentResourceName(), 'billing', {
			title    = "Bills",
			align    = 'top-left',
			elements = elements
		}, nil, function(data, menu)
			menu.close()
		end)
	end, player)
end

RegisterCommand("prison", function()
	if PlayerData.job and PlayerData.job.name ~= 'unemployed' and PlayerData.job.name == "police" then
		QBCore.Functions.Notify('You are under arrest by the Los Santos Police Department, you have the right not to speak and to have a lawyer, anything you say or say can be used as evidence against you!. Do you understand your rights?', "primary", 15000)
	end
end)

local tekneSpawn = false
RegisterCommand("pboat", function()
	if not tekneSpawn then
		if PlayerData.job and PlayerData.job.name ~= 'unemployed' and PlayerData.job.name == "police" then
			local PlayerPed = PlayerPedId()
			if IsPedSwimming(PlayerPed) then
				tekneSpawn = true
				local sayi = 8
				while sayi > 0 do
					QBCore.Functions.Notify('Tool Will Be Extracted After '..sayi..' Seconds!')
					sayi = sayi - 1
					Citizen.Wait(1000)
				end

				local coords = GetEntityCoords(PlayerPed)
				QBCore.Functions.SpawnVehicle("predator", function(vehicle)
					QBCore.Functions.Notify('Vehicle Removed!')
					SetVehRadioStation(vehicle, "OFF")
					TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
					TriggerEvent("x-hotwire:give-keys", vehicle)
				end, {x=coords.x + 1, y=coords.y + 1, z=coords.z + 1, h= 90.0 }, true)
				tekneSpawn = false
			else
				QBCore.Functions.Notify('You Need To Be In The Water!', 'error')
			end
		end
	end
end)

RegisterNetEvent('policeKeybindGeneral')
AddEventHandler('policeKeybindGeneral', function()
	if PlayerData.job and PlayerData.job.name == "police" then

		if PlayerData.job.boss then
			for i=1, #Config.PoliceStations.BossActions, 1 do
				if #(GetEntityCoords(playerPed) - Config.PoliceStations.BossActions[i]) < 1 then
					QBCore.UI.Menu.CloseAll()
					TriggerEvent('esx_society:openBossMenu', 'police', function(data, menu)
						menu.close()
					end, { wash = false, withdraw = false }) 
					break
				end
			end
		end
	end
end)

RegisterNetEvent('pdbossmenu',function()
	if PlayerData.job and PlayerData.job.name == "police" then

		if PlayerData.job.boss then
			for i=1, #Config.PoliceStations.BossActions, 1 do
				-- if #(GetEntityCoords(playerPed) - Config.PoliceStations.BossActions[i]) < 1 then
					QBCore.UI.Menu.CloseAll()
					TriggerEvent('esx_society:openBossMenu', 'police', function(data, menu)
						menu.close()
					end, { wash = false, withdraw = false }) 
					break
				-- end
			end
		end
	end
end)

RegisterCommand("objects", function()
	local playerPed = PlayerPedId()
	if PlayerData.job and PlayerData.job.name == 'police' and IsPedOnFoot(playerPed) then
		trackedEntities = {
			'prop_roadcone02a',
			'prop_barrier_work05',
			--'p_ld_stinger_s',
			'prop_boxpile_07d',
			'P_ld_stinger_s'
		}

		local coords = GetEntityCoords(playerPed)

		local closestDistance = -1
		local closestEntity   = nil

		for i=1, #trackedEntities, 1 do
			local object = GetClosestObjectOfType(coords, 10.0, GetHashKey(trackedEntities[i]), false, false, false)
			if DoesEntityExist(object) then
				local objCoords = GetEntityCoords(object)
				local distance  = GetDistanceBetweenCoords(coords, objCoords, true)
				if distance < 2 then
					if trackedEntities[i] == "P_ld_stinger_s" then
						TriggerEvent("police:spikesup")
					else
						QBCore.Functions.DeleteObject(object)
						SetEntityAsNoLongerNeeded(object)
					end
				end
			end
			
		end
	else
		QBCore.Functions.Notify('You Are Not a Police!')
	end
end)

function loadanimdict(dictname)
	if not HasAnimDictLoaded(dictname) then
		RequestAnimDict(dictname) 
		while not HasAnimDictLoaded(dictname) do 
			Citizen.Wait(1)
		end
	end
end

function SendToCommunityService(player)
	QBCore.UI.Menu.Open('dialog', GetCurrentResourceName(), 'Community Service Menu', {
		title = "Community Service Menu",
	}, function (data2, menu)
		local community_services_count = tonumber(data2.value)
		
		if community_services_count == nil then
			QBCore.Functions.Notify('Invalid services count.')
		else
			TriggerServerEvent("esx_communityservice:sendToCommunityService", player, community_services_count, QBCore.Key)
			menu.close()
		end
	end, function (data2, menu)
		menu.close()
	end)
end


--F3 Menüsü
RegisterNetEvent('esx_policejob:plakabak')
AddEventHandler('esx_policejob:plakabak', function(vehicleData)
	QBCore.Functions.Notify("Vehicle Plateı: "..vehicleData.plate, "primary", 25000)
end)
				
RegisterNetEvent('esx_policejob:cezakes')
AddEventHandler('esx_policejob:cezakes', function(closestPlayer)
	OpenFineMenu()
end)	

RegisterNetEvent('esx_policejob:cezalarinabak')
AddEventHandler('esx_policejob:cezalarinabak', function(closestPlayer)
	OpenUnpaidBillsMenu(closestPlayer)
end)	

RegisterNetEvent('esx_policejob:lisanskontrol')
AddEventHandler('esx_policejob:lisanskontrol', function(closestPlayer)
	ShowPlayerLicense(closestPlayer)
	QBCore.Functions.Notify('You go', 'error', 7500)
end)

RegisterNetEvent('esx_policejob:kamu')
AddEventHandler('esx_policejob:kamu', function(closestPlayer)
	SendToCommunityService(closestPlayer)
end)



RegisterNetEvent('pd:kisisel')
AddEventHandler('pd:kisisel', function()
	TriggerEvent("inventory:client:SetCurrentStash", "Polis_"..QBCore.Functions.GetPlayerData().citizenid, QBCore.Key)
	TriggerServerEvent("inventory:server:OpenInventory", "stash", "Polis_"..QBCore.Functions.GetPlayerData().citizenid)
end)

RegisterCommand('pdepo', function()
	local plyPed = PlayerPedId()
    plyVeh = GetVehiclePedIsIn(plyPed, false)
	if GetVehicleClass(plyVeh) == 18 then
		if PlayerData.job.name == 'police' or PlayerData.job.name == 'offpolice' then
				QBCore.Functions.Progressbar("policeFixBody", "Secure Warehouse Openingr", 4000, true, true, {
					disableMovement = true,
					disableCarMovement = true,
					disableMouse = false,
					disableCombat = true,
				}, {
				}, {}, {}, function() -- Done
				TriggerEvent("inventory:client:SetCurrentStash", "PCarStash_"..QBCore.Functions.GetPlayerData().citizenid, QBCore.Key)
				TriggerServerEvent("inventory:server:OpenInventory", "stash", "PCarStash_"..QBCore.Functions.GetPlayerData().citizenid,  {
					maxweight = 200000,
					slots = 20,
				})
			end, function() -- Cance
			exports["elix1rBase"]:SendAlert("Transaction Canceled!", "error")
		end)
	else
		QBCore.Functions.Notify("You must be on duty to open this safe.!", "error")
	end
	else
		QBCore.Functions.Notify("You Must Be In The Police Car!", "error")
	end
end)



local police = PolyZone:Create({
    vector2(459.9993, -1000.28),
    vector2(423.1575, -1000.28),
    vector2(423.1575, -973.038),
    vector2(463.6969, -973.039),
},{
    name = "AuthLocations",
    minZ = 23.6,
    maxZ = 30.0,
    debugPoly = false
})

RegisterCommand("fix", function(source)
        local PlayerData = QBCore.Functions.GetPlayerData()
        local vehicle = QBCore.Functions.GetClosestVehicle()
        local player = PlayerPedId()
        local coords = GetEntityCoords(player, 0)
        local Auth = GetDistanceBetweenCoords(AuthLocations, coords, true)
        local plyVeh = GetVehiclePedIsIn(player, false)
        local InVehicle = IsPedInVehicle(player, plyVeh, false)
        if InVehicle then
        location = police:isPointInside(coords)
        if location then 
                if PlayerData.job.name == 'police' or PlayerData.job.name == 'offpolice' then
                    if GetVehicleClass(plyVeh) == 18 then
                TriggerServerEvent("InteractSound_SV:PlayOnSource", "airwrench", 0.050)
                QBCore.Functions.Progressbar("citizenVehicleFix", "Body Repairing..", 9000, true, true, {
                    disableMovement = false,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                    }, {
                    }, {}, {}, function() -- Done
                        TriggerServerEvent("InteractSound_SV:PlayOnSource", "airwrench", 0.050)
                        QBCore.Functions.Progressbar("policeFixBody", "Motor Repairing..", 9000, true, true, {
                            disableMovement = true,
                            disableCarMovement = true,
                            disableMouse = false,
                            disableCombat = true,
                        }, {
                        }, {}, {}, function() -- Done
                        TriggerServerEvent("InteractSound_SV:PlayOnSource", "airwrench", 0.050)
                        SetVehicleFixed(vehicle)
                        SetVehicleDirtLevel(vehicle, 0)
                        SetVehicleDirtLevel(vehicle, 0)
                        exports['np-fuel']:SetFuel(vehicle, 100.0)
                    end, function() -- Cance
                        exports["elix1rBase"]:SendAlert("Transaction Canceled!", "error")
                    end)
                    end, function()-- Cancel
                        exports["elix1rBase"]:SendAlert("Transaction Canceled!", "error")
                    end)
                else
                    exports["elix1rBase"]:SendAlert("Only police vehicles can be repaired here.", "error")
                end
            else
                exports["elix1rBase"]:SendAlert("You Are Not a Police", "error")
            end
        else
            exports["elix1rBase"]:SendAlert("You have to be in the right position to use it!", "error")
        end
    else
        exports["elix1rBase"]:SendAlert("You are not in the vehicle!", "error")
    end
end)


RegisterNetEvent('kimliksatinal', function()
    local Player = QBCore.Functions.GetPlayerData()
	exports['qb-menu']:openMenu({
		{
			icon = "fas fa-car-wash",
			header = "Identity Transactions",
			isMenuHeader = true
		},
		{
			header = "Check Your ID",
			txt = "" .. PlayerData.charinfo.firstname .. " " .. PlayerData.charinfo.lastname .. " Review Named ID",
			icon = "fas fa-check",
			params = {
				event = "kimlik:bak",
			}
		},
		{
			header = "Identity Sticker (100$)",
			txt = "" .. PlayerData.charinfo.firstname .. " " .. PlayerData.charinfo.lastname .. " Extract Your Named ID",
			icon = "fas fa-check",
			params = {
				event = "idcard",
			}
		},
		{
			header = "Shooting license",
			txt = "1000$ Buy Hunting License",
			icon = "fas fa-check",
			isServer = false,
            params = {
                event = "avcilik",
            }
		},
		{
			header = "Close Menu",
			txt = "",
			icon = "fas fa-times",
			params = {
				event = "qb-menu:closeMenu"
			}
		},
	})
end)

RegisterNetEvent("idcard", function(src)
	TriggerServerEvent("kimligimiver", src)
end)

RegisterNetEvent("avcilik", function(src)
	TriggerServerEvent("huntinglicense:server", src)
end)


local pdBildirimCd = false
RegisterNetEvent("lobimemur", function()
	local Player = QBCore.Functions.GetPlayerData()
	if not pdBildirimCd then
		data = {
			id = id,
			code = 1,
			description = "" ..Player.charinfo.firstname.. " " ..Player.charinfo.lastname.. " Person Named Waiting for an Officer in the Lobby",
			location = exports["jtDispatch"]:GetTheStreet(),
			coords = GetEntityCoords(PlayerPedId()),
			sprite = 280
		}
		TriggerServerEvent("jtDispatch:add-notification", data, "police")
		pdBildirimCd = true
		Citizen.Wait(120000) -- 5 dakika
		pdBildirimCd = false
	else
		QBCore.Functions.Notify('You can send a notification in 2 minutes!', 'error', 7500)
	end
end)

RegisterCommand("control", function()
    local uzaklik = 2.0
    local bOyuncu,bUzaklik = QBCore.Functions.GetClosestPlayer()
    if bOyuncu ~= -1 and uzaklik >= bUzaklik then
        QBCore.Functions.TriggerCallback("huntinglicence:kontrol",function(sonuc)
            if sonuc == 1 then
				QBCore.Functions.Notify('Hunting License Available', 'success', 7500)
			else 
				QBCore.Functions.Notify('No Hunting License Found!', 'error', 7500)
            end
        end, GetPlayerServerId(bOyuncu)) 
    else
        QBCore.Functions.Notify('No players nearby!', 'error', 7500)
    end
end)



