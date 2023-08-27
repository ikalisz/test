local training = false
QBCore = nil
local coreLoaded = false
Citizen.CreateThread(function()
    while QBCore == nil do
        TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)
        Citizen.Wait(200)
    end
    coreLoaded = true
end)

local blips = {
	{title="Spor Salonu", colour=5, id=311, x = -1203.97, y = -1568.59, z = 4.61}
}

Citizen.CreateThread(function()
	for _, info in pairs(blips) do
		info.blip = AddBlipForCoord(info.x, info.y, info.z)
		SetBlipSprite(info.blip, info.id)
		SetBlipDisplay(info.blip, 4)
		SetBlipScale(info.blip, 0.5)
		SetBlipColour(info.blip, info.colour)
		SetBlipAsShortRange(info.blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(info.title)
		EndTextCommandSetBlipName(info.blip)
	end
end)



-- LOCATION (START)

local gym = {
	["normal"] = vector3(-33.18, -1665.15, 28.49),
	["normal2"] = vector3(-1203.97, -1568.59, 4.61),
	["jail"] = vector3(1776.872, 2495.110, 45.822),
	["polis"] = vector3(-1103.59, -834.57, 26.83),
	["jail2"] = vector3(1643.2681884766, 2529.0456542969, 44.964868927002),
}

local gymCoords = {
	["arms"] = {
		["name"] = "Remove Z-Bar",
		["anim"] = {
			["man"] = "WORLD_HUMAN_MUSCLE_FREE_WEIGHTS",
		},
		["skil"] = "Güç",
		["coords"] = {
			["normal2"] = {
				vector3(-1197.06,-1572.9, 4.61)
			},
			["jail"] = {
				vector3(1781.376, 2491.687, 45.822),
			},
			["jail2"] = {
				vector3(1644.5966796875, 2522.5490722656, 44.964868927002),
				vector3(1645.0541992188, 2537.0971679688, 44.964876556396),
			},
			["polis"] = {
				vector3(-1103.59, -834.57, 26.83)
			},
		}	
	},

	["pushup"] = {
		["name"] = "Pushup",
		["anim"] = {
			["man"] = "world_human_push_ups",
			["women"] = "amb@world_human_push_ups@male@base",
		},
		["skil"] = "Kondisyon",
		["coords"] = {
			["normal2"] = {
				vector3(-1199.88, -1564.05, 4.61),
				vector3(-1207.53, -1566.12, 4.61)
			},
			["jail"] = {
				vector3(1776.175, 2492.689, 45.848),
			},
			["jail2"] = {
				vector3(1637.6713867188, 2524.3872070312, 44.964895629883),
			},
			["polis"] = {
				vector3(-1108.75, -836.5, 26.85)
			},
		}
	},

	["yoga"] = {
		["name"] = "Yoga",
		["anim"] = {
			["man"] = "WORLD_HUMAN_YOGA",
		},
		["skil"] = "Kondisyon",
		["coords"] = {
			["normal2"] = {
				vector3(-1208.66, -1561.70, 4.6079),
				vector3(-1205.58, -1559.06, 4.6145)
			},
			["polis"] = {
				vector3(-1110.34, -837.6, 26.85)
			},
			["jail"] = {
				vector3(1777.343, 2493.935, 45.846)
			},
			["jail2"] = {
				vector3(1648.5992431641, 2534.4016113281, 44.964895629883),
			},
		}
	},

	["situps"] = {
		["name"] = "Situps",
		["anim"] = {
			["man"] = "world_human_sit_ups",
			["women"] = "amb@world_human_sit_ups@male@base",
		},
		["skil"] = "Güç",
		["coords"] = {
			["normal2"] = {
				vector3(-1201.6, -1561.16, 4.62),
			},
			["jail"] = {
				vector3(1778.632, 2494.770, 45.849),
			},
			["jail2"] = {
				vector3(1648.5139160156, 2526.1586914062, 44.964895629883),
			},
		}
	},

	["chins"] = {
		["name"] = "Chinups",
		["anim"] = {
			["man"] = "PROP_HUMAN_MUSCLE_CHIN_UPS",
		},
		["skil"] = "Kondisyon",
		["coords"] = {
			["normal2"] = {
				vector3(-1199.99, -1571.15, 4.61),
			},		
			["polis"] = {
				vector3(-1104.08, -838.45, 26.83),
				vector3(-1105.18, -837.0, 26.83)
			},
			["jail"] = {
				vector3(1775.941, 2497.509, 45.823),
			},
			["jail2"] = {
				vector3(1649.2885742188, 2529.5148925781, 44.964876556396),
				vector3(1643.3684082031, 2527.7624511719, 44.964876556396),
			},
		
		}
	}
}

local trainer = {
	{
		["coords"] = vector3(-1195.17, -1577.53, 3.6),
		["h"] = 123.79,
		["name"] = "[E] Jhon CENA"
	}
	
}

-- Citizen.CreateThread(function()
-- 	for i=1, #trainer do
-- 		exports["elixir-base"]:pedcreate(trainer[i]["name"] , 0x5265F707, trainer[i]["coords"].x, trainer[i]["coords"].y, trainer[i]["coords"].z, trainer[i]["h"])
-- 	end
--     while true do
-- 		local time = 1000
-- 		local playerPed = PlayerPedId()
-- 		local playerCoords = GetEntityCoords(playerPed)

-- 		for i=1, #trainer do
-- 			local coords = trainer[i]["coords"]
-- 			if #(playerCoords - coords) < 25 and coreLoaded then
-- 				time = 1
-- 				if #(playerCoords - coords) < 2.5 then
-- 					QBCore.Functions.DrawText3D(coords.x, coords.y, coords.z+2.05, trainer[i].name)
-- 					if IsControlJustPressed(0,38) then
-- 						SporSalonuMarket()
-- 					end
-- 				end
-- 			end
-- 		end
-- 		Citizen.Wait(time)
-- 	end
-- end)

local runningTime = 0
Citizen.CreateThread(function()
	while true do
		local playerPed = PlayerPedId()
		if IsPedRunning(playerPed) then
			runningTime = runningTime + 1
			if runningTime > 100 then
				runningTime = 0
				exports["gamz-skillsystem"]:UpdateSkill("Kondisyon", 0.30)
			end
		end
		Citizen.Wait(2500)
	end
end)
local qbui = false
Citizen.CreateThread(function()
    while true do
		local time = 2500
		local playerPed = PlayerPedId()
		local playerCoords = GetEntityCoords(playerPed)

		for gymName, coords in pairs(gym) do
			if #(playerCoords - coords) < 25 and coreLoaded then
				time = 1
				for _, train in pairs(gymCoords) do
					local trainCoords = train["coords"][gymName]
					if trainCoords ~= nil then
						for i=1, #trainCoords do
							if #(playerCoords - trainCoords[i]) < 7 then
								DrawMarker(21, trainCoords[i], 0, 0, 0, 0, 0, 0, 0.301, 0.301, 0.3001, 0, 255, 50, 200, 0, 0, 0, 0)
								if #(playerCoords - trainCoords[i]) < 1 then
									time = 0
									QBCore.Functions.DrawText3D(trainCoords[i].x, trainCoords[i].y, trainCoords[i].z+0.35, "[E] " .. train["name"] )
									if IsControlJustPressed(0,38) then
										if not training then
											training = true									
											local model = GetEntityModel(playerPed)			
											QBCore.Functions.Notify("Exercise begins...")
											DisableControlAction(0, 186, true)
											if model == 1885233650 then
												TaskStartScenarioInPlace(playerPed, train["anim"]["man"], 0, true)
											else
												if train["anim"]["women"] == nil then
													TaskStartScenarioInPlace(playerPed, train["anim"]["man"], 0, true)
												else
													startAnim(train["anim"]["women"], "base")
												end
											end
											QBCore.Functions.Progressbar('name', train["name"], 30000, false, true, { -- Name | Label | Time | useWhileDead | canCancel
												disableMovement = true,
												disableCarMovement = true,
												disableMouse = false,
												disableCombat = true,
											}, {
												animDict = '',
												anim = '',
												flags = 16,
											}, {}, {}, function() -- Play When Done
												TriggerServerEvent("QBCore:Server:SetMetaData", "hunger", QBCore.Functions.GetPlayerData().metadata["hunger"] - 1)
												TriggerServerEvent("QBCore:Server:SetMetaData", "thirst", QBCore.Functions.GetPlayerData().metadata["thirst"] - 3)
												ClearPedTasksImmediately(PlayerPedId())
												QBCore.Functions.Notify("You Feel Your Body Improved But You Have To Wait 30 Seconds To Do Another Exercise.")
												exports["gamz-skillsystem"]:UpdateSkill(train["skil"], 0.30)
											Citizen.Wait(30000)
											training = false
											QBCore.Functions.Notify("Now you can exercise again....")	
											DisableControlAction(0, 186, false)			
											end)
										else
											QBCore.Functions.Notify("You need to rest a little more...")
										end
									end
								end
							end
						end
					end
				end
			end
		end
		Citizen.Wait(time)
	end
end)


function startAnim(lib, anim)
	QBCore.Shared.RequestAnimDict(lib, function()
		TaskPlayAnim(PlayerPedId(), lib, anim, 8.0, 8.0, 30000, 1, 1, false, false, false)		
	end)
end


function OpenGymShopMenu()
    QBCore.UI.Menu.CloseAll()
    QBCore.UI.Menu.Open('default', GetCurrentResourceName(), 'gym_shop_menu', {
		title    = 'Gym - Shop',
		align = "center",
		elements = {
			{label = 'Protein Drink ($10)', value = 'protein_shake'},
			{label = 'Water ($2)', value = 'water'},
			{label = 'Sports Meal ($4)', value = 'sportlunch'},
			{label = 'Energy drink ($3)', value = 'powerade'},
		}
	}, function(data, menu)
		if data.current.value == 'protein_shake' then
			TriggerServerEvent('esx_gym:buyProteinshake')
		elseif data.current.value == 'water' then
			TriggerServerEvent('esx_gym:buyWater')
		elseif data.current.value == 'sportlunch' then
			TriggerServerEvent('esx_gym:buySportlunch')
		elseif data.current.value == 'powerade' then
			TriggerServerEvent('esx_gym:buyPowerade')
		end
	end, function(data, menu)
		menu.close()
	end)
end