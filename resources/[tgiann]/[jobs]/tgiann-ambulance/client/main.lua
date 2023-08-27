PlayerData = {}
playerDeadEx = false
IsBusy = false
kullanilanMed = 0
kullanilanMedikit = 0
PlayerLoaded = false

QBCore = nil
Citizen.CreateThread(function()
    while QBCore == nil do
		TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)
        Citizen.Wait(200)
	end
end)

 RegisterCommand("load", function()
	PlayerLoaded = true
	PlayerData = QBCore.Functions.GetPlayerData()
	playerDeadEx = PlayerData.metadata["isdead"]
end, false) 

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
	PlayerData = QBCore.Functions.GetPlayerData()
	PlayerLoaded = true
end)


RegisterNetEvent('QBCore:Client:OnJobUpdate')
AddEventHandler('QBCore:Client:OnJobUpdate', function(job)
    PlayerData.job = job
end)

Citizen.CreateThread(function()
	for k,v in pairs(Config.Hospitals.Blip) do
		local blip = AddBlipForCoord(v.coords)

		SetBlipSprite(blip, v.sprite)
		SetBlipScale(blip, 0.7)
		SetBlipColour(blip, v.color)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName('STRING')
		AddTextComponentSubstringPlayerName("Hospital")
		EndTextCommandSetBlipName(blip)
	end

	while true do
		playerPed = PlayerPedId()
		playerCoord = GetEntityCoords(playerPed)
		Citizen.Wait(500)
	end
end)

function DrawTxt(x, y, width, height, scale, text, r, g, b, a, outline)
    SetTextFont(0)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(2, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end

RegisterCommand("hospitalfix", function()
	local playerPed = PlayerPedId()
	if #(GetEntityCoords(playerPed) - vector3(289.2, -585.33, 17.76)) < 200.0 then
		if QBCore.Functions.GetPlayerData().metadata["isdead"] then
			SetEntityCoords(playerPed, vector3(308.92, -592.47, 43.28))
		else
			QBCore.Functions.Notify('You Can Use This Command While Dead')
		end
	else
		QBCore.Functions.Notify('You Cannot Use This Command Here')
	end
end)

RegisterNetEvent('esx_ambulancejob:user-bandage')
AddEventHandler('esx_ambulancejob:user-bandage', function()	
	if kullanilanMed < 8 then 
		if not IsBusy then
			IsBusy = true
			QBCore.Functions.TriggerCallback("elixir-base:removeItem", function(result)
				if result then
					local playerPed = PlayerPedId()
					QBCore.Functions.Progressbar("use_bandage", "Bandage is being used", 4000, false, true, {
						disableMovement = false,
						disableCarMovement = false,
						disableMouse = false,
						disableCombat = true,
					}, {
						animDict = "anim@amb@business@weed@weed_inspecting_high_dry@",
						anim = "weed_inspecting_high_base_inspector",
						flags = 49,
					}, {}, {}, function() -- Done
						IsBusy = false
						TriggerEvent("tgiann-hackkoruma:cankontrol", false)
						SetEntityHealth(playerPed, GetEntityHealth(playerPed)+25)
						kullanilanMed = kullanilanMed + 1
					end, function() -- Cancel
						IsBusy = false
					end)
				else
					IsBusy = false
				end
			end, "bandage", 1)
		end
	else
		QBCore.Functions.Notify('Your Wounds Are So Heavy The Bandage Doesnt Work Anymore You Need To Be Treated In The Hospital')
	end
end)

RegisterNetEvent('esx_ambulancejob:user-medikit')
AddEventHandler('esx_ambulancejob:user-medikit', function()	
	if kullanilanMedikit < 3 then 
		if not IsBusy then
			IsBusy = true
			QBCore.Functions.TriggerCallback("elixir-base:removeItem", function(result)
				if result then
					local playerPed = PlayerPedId()
					QBCore.Functions.Progressbar("use_medkilit", "Health Bag is Used", 12000, false, true, {
						disableMovement = true,
						disableCarMovement = true,
						disableMouse = false,
						disableCombat = true,
					}, {
						animDict = "anim@heists@narcotics@funding@gang_idle",
						anim = "gang_chatting_idle01",
						flags = 32,
					}, {}, {}, function() -- Done
						IsBusy = false
						TriggerEvent("tgiann-hackkoruma:cankontrol", false)
						SetEntityHealth(playerPed, 200)
						kullanilanMedikit = kullanilanMedikit + 1
					end, function() -- Cancel
						IsBusy = false
					end)
				else
					IsBusy = false
				end
			end, "medikit", 1)
		end
	else
		QBCore.Functions.Notify('Your Wounds Are So Heavy The Bandage Doesnt Work Anymore You Need To Be Treated In The Hospital')
	end
end)

RegisterNetEvent('esx_ambulancejob:user-adrenalin')
AddEventHandler('esx_ambulancejob:user-adrenalin', function()	
	local closestPlayer, closestDistance = QBCore.Functions.GetClosestPlayer()
	local playerPed = PlayerPedId()
	if not IsPedInAnyVehicle(playerPed) then
		if closestPlayer ~= -1 and closestDistance <= 3.0 then
			if not IsBusy then
				IsBusy = true
				QBCore.Functions.TriggerCallback("elixir-base:removeItem", function(result)
					if result then
						local playerPed = PlayerPedId()
						QBCore.Functions.Progressbar("use_adrenalin", "Adrenaline is being used", 45000, false, true, {
							disableMovement = true,
							disableCarMovement = true,
							disableMouse = false,
							disableCombat = true,
						}, {
							animDict = "anim@amb@business@weed@weed_inspecting_high_dry@",
							anim = "weed_inspecting_high_base_inspector",
							flags = 49,
						}, {}, {}, function() -- Done
							IsBusy = false
							local closestPlayer, closestDistance = QBCore.Functions.GetClosestPlayer()
							if closestDistance ~= -1 and closestDistance <= 3.0 then
								TriggerServerEvent("tgiann-ambulance:cloeset-adrenalin", GetPlayerServerId(closestPlayer), QBCore.Key)
							else
								QBCore.Functions.Notify('Adrenaline Wasted Because No One Was Nearby')
							end
						end, function() -- Cancel
							IsBusy = false
							QBCore.Functions.Notify('Adrenaline Wasted')
						end)
					else
						IsBusy = false
					end
				end, "adrenalin", 1)
			end
		else
			QBCore.Functions.Notify('No One Nearby')
		end
	else
		QBCore.Functions.Notify('You cant use it in the vehicle')
	end
end)

RegisterNetEvent('tgiann-ambulance:adrenalin-effect')
AddEventHandler('tgiann-ambulance:adrenalin-effect', function()	
	if playerDeadEx then
		revivePlayer(125, false)
		TriggerEvent("tgiann-basicneeds:igne")
	else
		QBCore.Functions.Notify('Adranelin was used on it, but it didnt have much effect because you werent unconscious.')
		TriggerEvent("tgiann-basicneeds:igne")
	end
end)

RegisterNetEvent('esx_ambulancejob:revive')
AddEventHandler('esx_ambulancejob:revive', function(yemek)
	revivePlayer(200, yemek)
end)


RegisterNetEvent("emsFatura:Kes", function()
	QBCore.UI.Menu.Open('dialog', GetCurrentResourceName(), 'billing', {
		title = "Total Invoice Amount to be Issued"
	}, function(data, menu)
		local amount = tonumber(data.value)

		if amount == nil or amount < 0 then
			QBCore.Functions.Notify("Incorrect Value")
		else
			local closestPlayer, closestDistance = QBCore.Functions.GetClosestPlayer()
			if closestPlayer == -1 or closestDistance > 3.0 then
				QBCore.Functions.Notify("No One Nearby")
			else
				menu.close()
				QBCore.Functions.Notify(amount ..'$ Penalty Worth Sent to Person!')
				TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(closestPlayer), 'ambulance', "LS EMS", amount)
			end
		end
	end, function(data, menu)
		menu.close()
	end)
end)