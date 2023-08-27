local PlayerData = {}

QBCore = nil
Citizen.CreateThread(function()
    while QBCore == nil do
        TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)
        Citizen.Wait(200)
    end
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    PlayerData = QBCore.Functions.GetPlayerData()
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate')
AddEventHandler('QBCore:Client:OnJobUpdate', function(job)
    PlayerData.job = job
end)

--Citizen.CreateThread(function()
	--local blip = AddBlipForCoord(vector3(977.38, -104.51, 74.85))

	--SetBlipSprite(blip, 348)
	--SetBlipDisplay(blip, 4)
	--SetBlipScale(blip, 0.7)
	--SetBlipColour(blip, 1)
	--SetBlipAsShortRange(blip, true)

	--BeginTextCommandSetBlipName("STRING")
	--AddTextComponentString('Lost MC')
	--EndTextCommandSetBlipName(blip)
--end)

-- Display markers
Citizen.CreateThread(function()
	while true do
		local time = 5000
		if PlayerData.job and PlayerData.job.name == 'motor' then 
			time = 1000
			local playerPed = PlayerPedId()
			local coords    = GetEntityCoords(playerPed)
		
			local distance = #(coords - vector3(977.38, -104.51, 74.85))
			if distance < 3 then
				time = 1
				local text = ""
				if distance < 1.5 then
					text = "[E] "
					if IsControlJustPressed(0, 38) then 
						TriggerEvent("inventory:client:SetCurrentStash", "motorDepo", QBCore.Key)
						TriggerServerEvent("inventory:server:OpenInventory", "stash", "motorDepo", {
							maxweight = 4000000,
							slots = 500,
						})
					end
				end
				QBCore.Functions.DrawText3D(977.38, -104.51, 74.85, text.."Depo")
			end
			
		end
		Citizen.Wait(time)
	end
end)