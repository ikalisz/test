QBCore = nil
Citizen.CreateThread(function()
    while QBCore == nil do
        TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)
        Citizen.Wait(200)
    end
end)

actionKey = 38

zones = {	
	["skati"] = {
		type = 21,  
		coords = vector3(0, 0, -2.0),	
		color = vector3(500, 555, 222),
		to = vector3(290.3, -268.59, 54.0),
		text = "Beam Me Scotty "
	},

	["casinodisari"] = {
		type = 21,  
		coords = vector3(1089.5997314453, 205.91123962402, -48.999729156494),
		color = vector3(255, 0, 0),
		to = vector3(935.89440917969, 46.915412902832, 81.095794677734),
		text = "Get out ",
		event = "chCasinoWall:exitedCasino"
	},

	["casinoiceri"] = {
		type = 21,  
		coords = vector3(935.89440917969, 46.915412902832, 81.095794677734),
		color = vector3(255, 0, 0),
		to = vector3(1089.5997314453, 205.91123962402, -48.999729156494),
		text = "Come in ",
		event = "chCasinoWall:enteredCasino"
	},

	["casinocaticik"] = {
		type = 21,  
		coords = vector3(1085.15, 214.23, -49.2),
		color = vector3(255, 0, 0),
		to = vector3(964.2912597, 58.9096641, 111.65295562744),
		text = "Get On The Roof",
		event = "chCasinoWall:exitedCasino"
	},

	["casinocatiiceri"] = {
		type = 21,  
		coords = vector3(964.2912597, 58.9096641, 111.65295562744),
		color = vector3(255, 0, 0),
		to = vector3(1085.15, 214.23, -49.2),
		text = "Come in",
		event = "chCasinoWall:enteredCasino"
	},
	
 
	["nightClub-icerri"] = {
		type = 21,  
		coords = vector3(4.83, 220.17, 107.41),	
		color = vector3(255, 0, 0),
		to = vector3(-1569.38, -3017.52, -74.80),
		text = "Come in"
	},

	["isletmekiralaGiris"] = {
		type = 21,  
		coords = vector3(-70.9276, -801.079, 44.227),
		color = vector3(255, 0, 0),
		to = vector3(-140.649, -618.056, 168.82),
		text = "Go upstairs"
	},

	["isletmekiralaCikis"] = {
		type = 21,  
		coords = vector3(-140.654, -618.160, 168.82),
		color = vector3(255, 0, 0),
		to = vector3(-70.9276, -801.079, 44.227),
		text = "Go down"
	},

	["nightClub-disari"] = {
		type = 21,  
		coords = vector3(-1569.38, -3017.52, -74.80),	
		color = vector3(255, 0, 0),
		to = vector3(4.83, 220.17, 107.71),
		text = "Get out"
	}, 

	["Lab-Gir"] = { 
		type = 21,  
		coords = vector3(2889.65, 4391.33, 50.45),	
		color = vector3(255, 0, 0),
		to = vector3(3526.37, 3673.63, 28.12),
		text = "Enter the Lab"
	}, 
	
	["Lab-Cik"] = { 
		type = 21,  
		coords = vector3(3526.37, 3673.63, 28.12),	
		color = vector3(255, 0, 0),
		to = vector3(2889.65, 4391.33, 50.45),
		text = "Exit the Lab"
	}, 
}


Citizen.CreateThread(function()
	for zone, data in pairs(zones) do
		exports["elixir-base"]:addNotif("E", data.text, 3, 2, data.coords)
	end
end)

RegisterNetEvent('teleportKeybindGeneral')
AddEventHandler('teleportKeybindGeneral', function(data)
	for zone, data in pairs(zones) do
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
		if #(coords - data.coords) < 2 then
			if data.event then 
				TriggerEvent(data.event)
			end
			DoScreenFadeOut(1000)
			Wait(1500)
			SetEntityCoords(playerPed, data.to)
			DoScreenFadeIn(1000)
			break
		end
	end
end)

