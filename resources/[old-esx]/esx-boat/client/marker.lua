-- Key controls
Citizen.CreateThread(function()
	while true do
		time = 2000
		local playerPed = PlayerPedId()
		local playerCoords = GetEntityCoords(playerPed)
		for i=1, #Config.Zones.BoatShops do
			local distance = GetDistanceBetweenCoords(playerCoords, Config.Zones.BoatShops[i].Outside, true)
			if distance < 40 and coreLoaded then
				time = 1
				DrawMarker(2, Config.Zones.BoatShops[i].Outside, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.2, 0.15, 200, 0, 0, 222, false, true, false, false, false, false, false)
				if distance < 3 then
					QBCore.Functions.DrawText3D(Config.Zones.BoatShops[i].Outside.x,Config.Zones.BoatShops[i].Outside.y,Config.Zones.BoatShops[i].Outside.z+0.3, "[E] Bot Satın Al")
					if IsControlJustReleased(0, 38) then
						QBCore.Functions.TriggerCallback('esx_boat:check-lisance', function(have)
							if have then
								OpenBoatShop(Config.Zones.BoatShops[1])
							else
								OpenLisance()
							end
						end)
					end
				end
			end
		end
		Citizen.Wait(time)
	end
end)

-- Blips
Citizen.CreateThread(function()
	local blipList = {}

	for i=1, #Config.Zones.BoatShops, 1 do
		table.insert(blipList, {
			coords = Config.Zones.BoatShops[i].Outside,
			text   = "Boat Seller",
			sprite = 427,
			color  = 3,
			scale  = 0.5
		})
	end

	for i=1, #blipList, 1 do
		CreateBlip(blipList[i].coords, blipList[i].text, blipList[i].sprite, blipList[i].color, blipList[i].scale)
	end
end)

function CreateBlip(coords, text, sprite, color, scale)
	local blip = AddBlipForCoord(coords.x, coords.y)

	SetBlipSprite(blip, sprite)
	SetBlipScale(blip, scale)
	SetBlipColour(blip, color)

	SetBlipAsShortRange(blip, true)

	BeginTextCommandSetBlipName('STRING')
	AddTextComponentSubstringPlayerName(text)
	EndTextCommandSetBlipName(blip)
end