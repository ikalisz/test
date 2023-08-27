
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(7)
		if NetworkIsSessionStarted() then
			Citizen.Wait(10)
			TriggerServerEvent('QBCore:PlayerJoined')
			return
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(7)
		if isLoggedIn then
			Citizen.Wait((1000 * 60) * 10)
			TriggerEvent("QBCore:Player:UpdatePlayerData")
		else
			Citizen.Wait(5000)
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(7)
		if isLoggedIn then
			Citizen.Wait(30000)
			TriggerEvent("QBCore:Player:UpdatePlayerPosition")
		else
			Citizen.Wait(5000)
		end
	end
end)

CreateThread(function()
	local time = 3000
	while true do
		if isLoggedIn then
			time = 10
			Wait((1000 * 25) * 30) -- 12.5 dakika
			TriggerServerEvent("QBCore:job-money") -- maaş
		else
			time = 5000
		end
		Wait(time)
	end
end)
