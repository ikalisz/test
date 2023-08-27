PlayerData = {}
jailTime = 0
local inJail = false
local isDead = false
local inJailArea = false

local jailCoords = PolyZone:Create({
	vector2(1818.5726318359, 2612.0561523438),
	vector2(1809.6007080078, 2611.9899902344),
	vector2(1809.7658691406, 2620.6032714844),
	vector2(1817.6466064453, 2640.4194335938),
	vector2(1834.8406982422, 2689.0239257812),
	vector2(1829.9180908203, 2703.9204101562),
	vector2(1776.5189208984, 2747.0720214844),
	vector2(1762.1005859375, 2752.1997070312),
	vector2(1662.0432128906, 2748.5180664062),
	vector2(1648.3663330078, 2741.4819335938),
	vector2(1584.8715820312, 2679.4748535156),
	vector2(1576.0063476562, 2667.2243652344),
	vector2(1547.9332275391, 2591.345703125),
	vector2(1547.2607421875, 2575.9323730469),
	vector2(1551.1787109375, 2482.8894042969),
	vector2(1558.4265136719, 2469.416015625),
	vector2(1652.9500732422, 2409.7309570312),
	vector2(1667.7816162109, 2407.7866210938),
	vector2(1748.7457275391, 2420.0883789062),
	vector2(1762.5209960938, 2426.7429199219),
	vector2(1808.4969482422, 2474.2888183594),
	vector2(1813.5616455078, 2488.8591308594),
	vector2(1806.2302246094, 2535.7768554688),
	vector2(1807.8586425781, 2561.4006347656),
	vector2(1808.3239746094, 2591.4526367188),
	vector2(1819.0633544922, 2591.6591796875),
	vector2(1826.7766113281, 2591.6267089844),
	vector2(1826.7720947266, 2579.5773925781),
	vector2(1831.6055908203, 2579.5446777344),
	vector2(1831.6682128906, 2591.4548339844),
	vector2(1831.7585449219, 2590.4309082031),
	vector2(1836.5673828125, 2590.3977050781),
	vector2(1836.5554199219, 2596.6984863281),
	vector2(1819.1229248047, 2596.5805664062)
}, {
	name="hapis",
	minZ = 40.341663360596,
	maxZ = 60.002994537354
})


local erkek = {
	props = {
		{ 6, -1, 0 }, -- watch / Saat
	},
	components = {
		{ 1, 0, 0 }, -- Mask / Maske
		{ 15, 363, 2 }, -- Torso / Gövde
		{ 3, 1, 0 },	-- Arms / Kollar
		{ 10, 0, 0 }, -- Decal / Çıkartma
		{ 8, 15, 0 }, -- Tshirt / Tişört
		{ 4, 134,20 }, -- Pants / Pantalon
		{ 6, 6, 0 }, -- Shoes / Ayakkabı
		{ 7, 0, 0 }, -- chain / Kolye
		{ 9, 0, 0 }, -- Bproof / Zırh
		{ 5, 0, 0 }, -- Bags / Çanta
	}
}

local kadin = {
	props = {
		{ 6, -1, 0 }, -- watch / Saat
	},
	components = {
		{ 1, 0, 0 }, -- Mask / Maske
		{ 11, 633, 0 }, -- Torso / Gövde
		{ 3, 1, 0 },	-- Arms / Kollar
		{ 10, 0, 0 }, -- Decal / Çıkartma
		{ 8, 15, 0 }, -- Tshirt / Tişört
		{ 4, 232, 0 }, -- Pants / Pantalon
		{ 6, 47, 0 }, -- Shoes / Ayakkabı
		{ 7, 0, 0 }, -- chain / Kolye
		{ 9, 0, 0 }, -- Bproof / Zırh
		{ 5, 0, 0 }, -- Bags / Çanta
	}
}


QBCore = nil
local coreLoaded = false
Citizen.CreateThread(function()
    while QBCore == nil do
        TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)
        Citizen.Wait(200)
    end
	-- Cutscene()
	exports["qb-target"]:AddBoxZone("esyagerialmajail", vector3(1840.3757324219, 2578.337890625, 46.014358520508), 1, 1, {
        name="esyagerialmajail",
        heading=336.0,
        debugPoly=false,
        minZ=44,
        maxZ=46.8,
    },
        {
            options = {
                {
                    event = "jail:gerialesya",
                    icon = "fas fa-circle",
                    label = "Get Your Items Back",
                },
            },
            job = {"all"},
            distance = 1.5,
			spritecoord = vector3(1840.3757324219, 2578.337890625, 46.014358520508),
        }
    )
	
	exports["elixir-base"]:pedcreate("yetkilibirabi", 0x7FA2F024, 1773.1505126953, 2493.9938964844, 45.740753173828 - 1, 125.4162826538, "random@shop_gunstore", "_idle_b")
	exports["elixir-base"]:pedcreate("bisikletciabi", 0xFDC653C7, 1635.2182617188, 2586.8732910156, 44.793133850098, 357.0573425293, "missheist_agency3aig_lift_waitped_b", "base")
	exports["elixir-base"]:pedcreate("yemekciabi", 0xDB9C0997, 1781.00390625, 2560.8356933594, 44.673133850098, 172.53852844238, "anim@amb@business@meth@meth_monitoring_cooking@cooking@", "base_idle_tank_cooker")
    coreLoaded = true
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
	PlayerData = QBCore.Functions.GetPlayerData()
	inJail = PlayerData.metadata.injail
	exports["elixir-base"]:pedcreate("yetkilibirabi", 0x7FA2F024, 1773.1505126953, 2493.9938964844, 45.740753173828 - 1, 125.4162826538, "random@shop_gunstore", "_idle_b")
	exports["elixir-base"]:pedcreate("bisikletciabi", 0xFDC653C7, 1635.2182617188, 2586.8732910156, 44.793133850098, 357.0573425293, "missheist_agency3aig_lift_waitped_b", "base")
	exports["elixir-base"]:pedcreate("yemekciabi", 0xDB9C0997, 1781.00390625, 2560.8356933594, 44.673133850098, 172.53852844238, "anim@amb@business@meth@meth_monitoring_cooking@cooking@", "base_idle_tank_cooker")
	if inJail == true then
		jailTime = PlayerData.metadata.jailtime
		if jailTime > 0 then
			JailLogin()
		end
	end
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload')
AddEventHandler('QBCore:Client:OnPlayerUnload', function()
    PlayerData = {}
	inJail = false
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate')
AddEventHandler('QBCore:Client:OnJobUpdate', function(job)
    PlayerData.job = job
end)

RegisterNetEvent("esx-qalle-jail:openJailMenu")
AddEventHandler("esx-qalle-jail:openJailMenu", function()
	OpenJailMenu()
end)

RegisterNetEvent("esx-qalle-jail:jailPlayer")
AddEventHandler("esx-qalle-jail:jailPlayer", function(newJailTime)
	jailTime = newJailTime
	Cutscene()
end)

-- RegisterCommand('hapis', function(args)
-- 	TriggerServerEvent("esx-qalle-jail:jailPlayer", GetPlayerServerId(PlayerId()), 15, "orospu", QBCore.Key)
-- end)

-- RegisterCommand('hapiskaldir', function()
-- 	UnJail()
-- end)



AddEventHandler('tgiann:playerdead', function(dead)
	isDead = dead
end)

RegisterNetEvent("esx-qalle-jail:unJailPlayer")
AddEventHandler("esx-qalle-jail:unJailPlayer", function()
	jailTime = 0
	UnJail()
end)

function JailLogin()
	local JailPosition = Config.JailPositions["Cell"]
	SetEntityCoords(PlayerPedId(), JailPosition["x"], JailPosition["y"], JailPosition["z"] - 1)

	QBCore.Functions.Notify("You're Jailed!")
	InJail()
end

function giysigiy(outfits)
	local playerPed = PlayerPedId()
	for _, comp in ipairs(outfits.components) do
		SetPedComponentVariation(playerPed, comp[1], comp[2], comp[3], 0)
	end
 
	for _, comp in ipairs(outfits.props) do
		if comp[2] == 0 then
			ClearPedProp(playerPed, comp[1])
		else
			SetPedPropIndex(playerPed, comp[1], comp[2], comp[3], true)
		end
	end
end

function UnJail(coord)
	inJail = false
	local ped = PlayerPedId()
	TriggerEvent("tgiann-hackkoruma:cankontrol", false)
	SetEntityCoords(ped, coord or vector3(1838.71, 2585.87, 45.89))
	if not isDead then
		SetPedMaxHealth(ped, 200)
		SetEntityHealth(ped, 200)
	end
	tasiniyor = false
	yemekcd = false
	TriggerEvent("comServUI:set", "PENALTY IS OVER.", false)
	ExecuteCommand('refreshskin')
	inkamu = false
	inkamu2 = nil
	QBCore.Functions.Notify("You're free, don't forget to get your stuff from the information section!")
end

exports('playerInJailArea', function(str)
	return inJail
end)


exports('getJail', function()
	return jailCoords
end)



local tasiniyor = false
local iceriSure = 1
function InJail()
	inJail = true
	-- exports["qb-target"]:AddBoxZone("yetkilibirabi", vector3(1773.1505126953, 2493.9938964844, 45.740753173828), 1, 1, {
	exports['qb-target']:AddBoxZone("31", vector3(1773.1505126953, 2493.9938964844, 45.740753173828), 3, 3, {
        name="yetkilibirabi",
        heading=91.0,
        debugPoly=false,
        minZ=44,
        maxZ=46.8,
    },
        {
            options = {
                -- {
                --     event = "jail:gorusme",
                --     icon = "fas fa-circle",
                --     label = "Görüşme Yapmak İstiyorum",
                -- },
			
				{
                    event = "jail:kamugorev",
                    icon = "fas fa-circle",
                    label = "Request Public Service",
                },
            },
            job = {"all"},
            distance = 3.0,
			-- spritecoord = vector3(1773.1505126953, 2493.9938964844, 45.740753173828),
        }
    )



	exports["qb-target"]:AddBoxZone("bisikletciabi", vector3(1635.2182617188, 2586.8732910156, 45.793133850098), 1, 1, {
        name="bisikletciabi",
        heading=336.0,
        debugPoly=false,
        minZ=45,
        maxZ=47,
    },
        {
            options = {
				{
                    event = "jail:bisikletkirala",
                    icon = "fas fa-circle",
                    label = "BMX Rent (15 minutes)",
                },
            },
            job = {"all"},
            distance = 3.0,
			spritecoord = vector3(1635.2182617188, 2586.8732910156, 45.793133850098),
        }
	)
	

	exports['qb-target']:AddBoxZone("313", vector3(1781.910, 2560.783, 45.673), 1.4, 1.6, {
		heading=179,
		debugPoly= false,
		minZ=37.66,
		maxZ=38.66
	}, {
		options = {
					{
                    event = "jail:yiyecekicecek",
                    icon = "fas fa-circle",
                    label = "Request French Fries & Coke",
                },
					{
                    event = "telefonkardes",
                    icon = "fas fa-circle",
                    label = "Buy Phone ($100)",
                },
		},
		job = {"all"},
		distance = 2
	})

	-- RegisterNetEvent("telefonkardes", function()

	TriggerEvent("comServUI:set", "By the end of the sentence " .. jailTime .. " month left.", "araba")

	CreateThread(function()
		local model = GetEntityModel(PlayerPedId())
		if model == 1885233650 then -- Erkek Model
			giysigiy(erkek)
		elseif model == -1667301416 then
			giysigiy(kadin)
		end

		sayac = 0
		while jailTime > 0 do
			local playerPed = PlayerPedId()
			local playerCoords = GetEntityCoords(playerPed)
			inJailArea = jailCoords:isPointInside(playerCoords)
			if not inJailArea then
				local JailPosition = Config.JailPositions["Cell"]
				DoScreenFadeOut(0)
				SetEntityCoords(playerPed, JailPosition["x"], JailPosition["y"], JailPosition["z"] - 1)
				Wait(400)
				DoScreenFadeIn(1000)
			end
			jailTime = jailTime - 1
			TriggerServerEvent("esx-qalle-jail:updateJailTime", jailTime, QBCore.Key)
			if jailTime > 0 then
				TriggerEvent("comServUI:set", "to the end of the sentence " .. jailTime .. " month left.", true)
			else
				UnJail()
			end	
			Wait(60000)
		end
	end)
end

local tasimaKonum = {
	vector3(1765.97, 2569.03, 45.73),
	vector3(1766.1, 2573.14, 45.73),
	vector3(1785.99, 2569.2, 45.73),
	vector3(1785.99, 2573.37, 45.73),
	vector3(1785.47, 2577.41, 45.71),
	vector3(1785.71, 2581.52, 45.71),
}

local secilenKonum = 1


CreateThread(function()
    while true do
        local time = 5000
        if tasiniyor then
            time = 1
            local playerPed = PlayerPedId()
            DisablePlayerFiring(playerPed, true)

            DisableControlAction(0,21,true) -- disable sprint
            DisableControlAction(0, 24, true) -- Attack
            DisableControlAction(0, 257, true) -- Attack 2
            DisableControlAction(0, 25, true) -- Aim
            DisableControlAction(0, 263, true) -- Melee Attack 1
            DisableControlAction(0, 37, true) -- Select Weapon

            DisableControlAction(0, 56, true) -- F9
            DisableControlAction(0, 45, true) -- Reload
            DisableControlAction(0, 22, true) -- Jump
            DisableControlAction(0, 44, true) -- Cover

            DisableControlAction(0, 288, true) --F1
            DisableControlAction(0, 167, true) -- F6

            DisableControlAction(0, 26, true) -- Disable looking behind
            DisableControlAction(0, 73, true) -- Disable clearing animation

            DisableControlAction(0, 59, true) -- Disable steering in vehicle
            DisableControlAction(0, 71, true) -- Disable driving forward in vehicle
            DisableControlAction(0, 72, true) -- Disable reversing in vehicle
			DisableControlAction(2, 21, true) -- Disable going stealth

            DisableControlAction(0, 47, true)  -- Disable weapon
            DisableControlAction(0, 264, true) -- Disable melee
            DisableControlAction(0, 257, true) -- Disable melee
            DisableControlAction(0, 140, true) -- Disable melee
            DisableControlAction(0, 141, true) -- Disable melee
            DisableControlAction(0, 142, true) -- Disable melee
            DisableControlAction(0, 143, true) -- Disable melee
            DisableControlAction(0, 75, true)  -- Disable exit vehicle
            DisableControlAction(0, 301, true)  -- Disable exit vehicle
            DisableControlAction(27, 75, true) -- Disable exit vehicle
            DisableControlAction(0, 23, true)
        end
        Wait(time)
    end
end)  

function OpenJailMenu()
	QBCore.UI.Menu.Open('default', GetCurrentResourceName(), 'jail_prison_menu',{
		title    = "Jail Menu",
		align    = 'center',
		elements = {
			{ label = "Jail (nearby player)", value = "jail_closest_player" },
			{ label = "Unjail", value = "unjail_player" }
		}
	}, function(data, menu)
		local action = data.current.value
		if action == "jail_closest_player" then
			menu.close()
			QBCore.UI.Menu.Open('dialog', GetCurrentResourceName(), 'jail_choose_time_menu',{
            		title = "Jail time (minutes)"
			}, function(data2, menu2)

            	jailTime = tonumber(data2.value)

            	if jailTime == nil then
              		QBCore.Functions.Notify("Duration must be minutes!")
            	else
              		menu2.close()

              		local closestPlayer, closestDistance =  QBCore.Functions.GetClosestPlayer()

              		if closestPlayer == -1 or closestDistance > 3.0 then
                		QBCore.Functions.Notify("No players found recently!")
					else
						QBCore.UI.Menu.Open('dialog', GetCurrentResourceName(), 'jail_choose_reason_menu',{
							title = "Hapis Sebebi"
						}, function(data3, menu3)
		
						  	local reason = data3.value
		  
						  	if reason == nil then
								QBCore.Functions.Notify("You should write a reason for jail!")
						  	else
								menu3.close()
		  
								local closestPlayer, closestDistance =  QBCore.Functions.GetClosestPlayer()
		  
								if closestPlayer == -1 or closestDistance > 3.0 then
								  	QBCore.Functions.Notify("No players found recently!")
								else
								  	TriggerServerEvent("esx-qalle-jail:jailPlayer", GetPlayerServerId(closestPlayer), jailTime, reason, QBCore.Key)
								end
		  
						  	end
		  
						end, function(data3, menu3)
							menu3.close()
						end)
              		end

				end

          	end, function(data2, menu2)
				menu2.close()
			end)
		elseif action == "unjail_player" then

			local elements = {}

			QBCore.Functions.TriggerCallback("esx-qalle-jail:retrieveJailedPlayers", function(playerArray)

				if #playerArray == 0 then
					QBCore.Functions.Notify("The Prison is empty!")
					return
				end

				for i = 1, #playerArray, 1 do
					table.insert(elements, {label = "Prisoner: " .. playerArray[i].name .. " | jail time: " .. playerArray[i].jailTime .. " minute", value = playerArray[i].identifier })
				end

				QBCore.UI.Menu.Open('default', GetCurrentResourceName(), 'jail_unjail_menu',{
					title = "Get Out of Jail",
					align = "center",
					elements = elements
				},function(data2, menu2)

					local action = data2.current.value

					TriggerServerEvent("esx-qalle-jail:unJailPlayer", action, QBCore.Key)

					menu2.close()

				end, function(data2, menu2)
					menu2.close()
				end)
			end)

		end

	end, function(data, menu)
		menu.close()
	end)	
end

RegisterNetEvent('esx-qalle-jail:hapisat')
AddEventHandler('esx-qalle-jail:hapisat', function()
	QBCore.UI.Menu.Open('dialog', GetCurrentResourceName(), 'jail_choose_time_menu',{
		title = "Jail time (minutes)"
	}, function(data2, menu2)

		jailTime = tonumber(data2.value)
		if jailTime == nil then
			QBCore.Functions.Notify("Duration must be minutes!")
		else
			menu2.close()

			local closestPlayer, closestDistance =  QBCore.Functions.GetClosestPlayer()

			if closestPlayer == -1 or closestDistance > 3.0 then
				QBCore.Functions.Notify("No players found recently!")
			else
				QBCore.UI.Menu.Open('dialog', GetCurrentResourceName(), 'jail_choose_reason_menu',{
					title = "Reason for Prison"
				},function(data3, menu3)
					local reason = data3.value
	
					if reason == nil then
						QBCore.Functions.Notify("You should write a reason for jail!")
					else
						menu3.close()
	
						local closestPlayer, closestDistance =  QBCore.Functions.GetClosestPlayer()
						if closestPlayer == -1 or closestDistance > 3.0 then
							QBCore.Functions.Notify("No players found recently!")
						else
							TriggerServerEvent("esx-qalle-jail:jailPlayer", GetPlayerServerId(closestPlayer), jailTime, reason, QBCore.Key)
						end
	
					end
	
				end, function(data3, menu3)
					menu3.close()
				end)
			end
		end

	end, function(data2, menu2)
		menu2.close()
	end)
end)

RegisterNetEvent('esx-qalle-jail:hapiscikar')
AddEventHandler('esx-qalle-jail:hapiscikar', function()
	local elements = {}
	QBCore.Functions.TriggerCallback("esx-qalle-jail:retrieveJailedPlayers", function(playerArray)

		if #playerArray == 0 then
			QBCore.Functions.Notify("the prison is empty!")
			return
		end

		for i = 1, #playerArray, 1 do
			table.insert(elements, {label = "prisoner: " .. playerArray[i].name .. " | jail time: " .. playerArray[i].jailTime .. " minute", value = playerArray[i].identifier })
		end

		QBCore.UI.Menu.Open('default', GetCurrentResourceName(), 'jail_unjail_menu',{
			title = "Unjail Menu",
			align = "center",
			elements = elements
		},function(data2, menu2)
			local action = data2.current.value

			TriggerServerEvent("esx-qalle-jail:unJailPlayer", action, QBCore.Key)

			menu2.close()

		end, function(data2, menu2)
			menu2.close()
		end)
	end)
end)

RegisterNetEvent("esx-qalle-jail:player-un-jail")
AddEventHandler("esx-qalle-jail:player-un-jail", function(userSource)
	QBCore.Functions.TriggerCallback("elixir-base:item-kontrol", function(amount)
		if amount > 0 then
			local player, distance = QBCore.Functions.GetClosestPlayer()
			if distance ~= -1 and distance <= 2.0 then
				QBCore.Functions.Progressbar("hapis_kacir", 'You Are Trying To Kidnap The Person', 20000, false, true, { -- p1: menu name, p2: yazı, p3: ölü iken kullan, p4:iptal edilebilir
					disableMovement = true,
					disableCarMovement = true,
					disableMouse = false,
					disableCombat = true,
				}, {}, {}, {}, function() -- Done
					TriggerServerEvent('esx-qalle-jail:server:closest-player-un-jail', GetPlayerServerId(player), GetEntityCoords(PlayerPedId()))
				end, function() -- Cancel
				end)	
			else
				QBCore.Functions.Notify('There is no one nearby!', 'error')
			end
		else
			QBCore.Functions.Notify('No MA Coins On It!', 'error')
		end
	end, "hackcoin")
end)

RegisterNetEvent("esx-qalle-jail:client:closest-player-un-jail")
AddEventHandler("esx-qalle-jail:client:closest-player-un-jail", function(player, name, coord)
	if jailTime > 0 then
		TriggerServerEvent('esx-qalle-jail:server:closest-player-un-jail-confrim', player)
		QBCore.Functions.Notify("You were abducted from jail by a player!")

		jailTime = 0
		Citizen.Wait(200)
		UnJail(coord)
		for i=1, 2 do
			Citizen.Wait(25000)

		end
	end
end)





local function polisbildirim()
	local ped = PlayerPedId()
	local playerPos = GetEntityCoords(ped)
	local id = math.random(1, 9999)
	
		data = {
			id = id,
			code = 10-78,
			description = "" ..name.. "Criminal Escaped From Prison",
			location = GetTheStreet(),
			coords = playerPos,
			sprite = 66
		}
		TriggerServerEvent("jtDispatch:add-notification", data, "police")
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




attachPropList = {
	["minigameThermite"] = {
		["model"] = "prop_oiltub_06", ["bone"] = 57005, ["x"] = 0.1,["y"] = 0.0,["z"] = -0.09,["xR"] = 145.0,["yR"] = 20.0, ["zR"] = 80.0
	},
	["geyikderi"] = {
		["model"] = "hunting_pelt_01_a",    ["bone"] = 28422,
		["x"] = 0.0,
		["y"] = -0.10,
		["z"] = -0.0,
		["xR"] = 0.0,
		["yR"] = 0.0,
		["zR"] = 0.0,
	},
	["fuel"] = {
		["model"] = "prop_cs_fuel_nozle", ["bone"] = 18905, ["x"] = 0.1,["y"] = 0,["z"] = -0.09,["xR"] = 145.0,["yR"] = 20.0, ["zR"] = 80.0
	},
	["jailkamu"] = {
		["model"] = "prop_weld_torch", ["bone"] = 57005, ["x"] = 0.11,["y"] = 0.02,["z"] = -0.00,["xR"] = 30.0,["yR"] = 175.0, ["zR"] = 0.0
	},
	["stolentv"] = {
		["model"] = "prop_tv_flat_01",
		["bone"] = 28422,
		["x"] = 0.0,
		["y"] = -0.1,
		["z"] = 0.1,
		["xR"] = 0.0,
		["yR"] = 0.0,
		["zR"] = 0.0
	},
}

attachedProp = 0
function removeAttachedProp()
	if DoesEntityExist(attachedProp) then
		DeleteEntity(attachedProp)
		attachedProp = 0
	end
end

RegisterNetEvent("removeAttachedProp")
AddEventHandler("removeAttachedProp", function()
  removeAttachedProp()
end)

RegisterNetEvent('attachProp')
AddEventHandler('attachProp', function(attachModelSent,boneNumberSent,x,y,z,xR,yR,zR)
	removeAttachedProp()
	attachModel = GetHashKey(attachModelSent)
  boneNumber = boneNumberSent
  local ped = PlayerPedId()
	SetCurrentPedWeapon(ped, 0xA2719263)
	local bone = GetPedBoneIndex(ped, boneNumberSent)
	RequestModel(attachModel)
	while not HasModelLoaded(attachModel) do
		Citizen.Wait(100)
	end
	attachedProp = CreateObject(attachModel, 1.0, 1.0, 1.0, 1, 1, 0)
  AttachEntityToEntity(attachedProp, ped, bone, x, y, z, xR, yR, zR, 1, 1, 0, 0, 2, 1)
end)

RegisterNetEvent('attachItem')
AddEventHandler('attachItem', function(item)
	TriggerEvent("attachProp",attachPropList[item]["model"], attachPropList[item]["bone"], attachPropList[item]["x"], attachPropList[item]["y"], attachPropList[item]["z"], attachPropList[item]["xR"], attachPropList[item]["yR"], attachPropList[item]["zR"])
end)