local QBCore = exports['qb-core']:GetCoreObject()
local open = false

RegisterNetEvent('jsfour-idcard:open')
AddEventHandler('jsfour-idcard:open', function(data, type)
	open = true
	SendNUIMessage({
		action = "open",
		array  = data,
		type   = type
	})
end)

-- Key events
Citizen.CreateThread(function()
	while true do
		local time = 250
		if open then
			time = 1
			DisableControlAction(0, 177, true)
			DisableControlAction(0, 200, true)
			if IsDisabledControlJustReleased(0, 177) then
				SendNUIMessage({action = "close"})
				open = false
			end
		end
		Citizen.Wait(time)
	end
end)

RegisterNetEvent('jsfour-idcard:open-pd')
AddEventHandler('jsfour-idcard:open-pd', function(data)
	open = true
	SendNUIMessage({
		action = "openPd",
		array  = data,
	})
end)

--RegisterNetEvents
RegisterNetEvent('oyuncuanim')
AddEventHandler('oyuncuanim', function()
    local playerPed = PlayerPedId()
    local model = `prop_cs_swipe_card`
    while not HasModelLoaded(model) do print("model") RequestModel(model) Citizen.Wait(100) end
    local prop = CreateObject(`prop_cs_swipe_card`, 1.0, 1.0, 1.0, 1, 1, 0)
    open = true
    AttachEntityToEntity(prop, playerPed, GetPedBoneIndex(playerPed, 57005), 0.12, 0.01, -0.045, 110.0, 120.0, -15.0, 1, 0, 0, 0, 2, 1)
    SetModelAsNoLongerNeeded(model)
    while (not HasAnimDictLoaded("paper_1_rcm_alt1-9")) do RequestAnimDict("paper_1_rcm_alt1-9") Citizen.Wait(100) end
    TaskPlayAnim(playerPed, "paper_1_rcm_alt1-9", "player_one_dual-9", 1.0, 1.0, 5500, 33, 1, false, false, false)
    Citizen.Wait(1500)
    DeleteEntity(prop)
end)

RegisterNetEvent('kimlik:islemleri', function(item)
    local Player = QBCore.Functions.GetPlayerData()
	exports['qb-menu']:openMenu({
		{
			icon = "fas fa-id-card",
			header = "Identity",
			isMenuHeader = true
		},
		{
			header = "Look at ID",
			txt = item.info.owner.." review name ID.",
			icon = "fas fa-search",
			params = {
				event = 'kimlik:seks',
				args = {
					item2 = item
				}
			}
		},
		{
			header = "Share ID",
			txt = item.info.owner.." Share ID.",
			icon = "fas fa-handshake",
			params = {
				event = 'kimlik:seks2',
				args = {
					item2 = item
				}
			}
		},
	})
end)

AddEventHandler('kimlik:seks', function(args)
	local newItem2 = args.item2
	TriggerEvent('kimlik:bak', newItem2)
end)

AddEventHandler('kimlik:seks2', function(args)
	local newItem2 = args.item2
	TriggerEvent('kimlik:ver', newItem2)
end)

RegisterNetEvent("kimlik:bak")
AddEventHandler("kimlik:bak", function(newItem2)
    TriggerServerEvent('jsfour-idcard:open', newItem2.info.citizenid, GetPlayerServerId(PlayerId()))
end)

RegisterNetEvent("kimlik:ver")
AddEventHandler("kimlik:ver", function(newItem2)
	local player = QBCore.Functions.GetClosestPlayer()
	if player ~= -1 then
        TriggerServerEvent('jsfour-idcard:open', newItem2.info.citizenid, GetPlayerServerId(player))
	else
		QBCore.Functions.Notify("There is no one nearby.", "error")
	end
end)

RegisterNetEvent('ehliyet:islemleri', function(item)
    local Player = QBCore.Functions.GetPlayerData()
	exports['qb-menu']:openMenu({
		{
			icon = "fas fa-id-card",
			header = "Driver's License",
			isMenuHeader = true
		},
		{
			header = "Check Your Driver's License",
			txt = item.info.owner.." view driver's license.",
			icon = "fas fa-search",
			params = {
				event = 'ehliyet:seks',
				args = {
					item2 = item
				}
			}
		},
		{
			header = "Share Your Driver's License",
			txt = item.info.owner.." Share your license.",
			icon = "fas fa-handshake",
			params = {
				event = 'ehliyet:seks2',
				args = {
					item2 = item
				}
			}
		},
	})
end)

AddEventHandler('ehliyet:seks', function(args)
	local newItem2 = args.item2
	TriggerEvent('ehliyet:bak', newItem2)
end)

AddEventHandler('ehliyet:seks2', function(args)
	local newItem2 = args.item2
	TriggerEvent('ehliyet:ver', newItem2)
end)

RegisterNetEvent("ehliyet:bak")
AddEventHandler("ehliyet:bak", function(newItem2)
	TriggerServerEvent('jsfour-idcard:open', newItem2.info.citizenid, GetPlayerServerId(PlayerId()), 'driver')
end)

RegisterNetEvent("ehliyet:ver")
AddEventHandler("ehliyet:ver", function(newItem2)
	local player, dist = QBCore.Functions.GetClosestPlayer()
	if player ~= -1 and dist <= 3.0 then
    	TriggerServerEvent('jsfour-idcard:open', newItem2.info.citizenid, GetPlayerServerId(player), 'driver')
	else
		QBCore.Functions.Notify("There is no one nearby.", "error")
	end
end)

RegisterNetEvent('ruhsat:islemleri', function(item)
    local Player = QBCore.Functions.GetPlayerData()
	exports['qb-menu']:openMenu({
		{
			icon = "fas fa-id-card",
			header = "License Procedures",
			isMenuHeader = true
		},
		{
			header = "Check License",
			txt = item.info.owner.." view license.",
			icon = "fas fa-search",
			params = {
				event = 'ruhsat:seks',
				args = {
					item2 = item
				}
			}
		},
		{
			header = "Share License",
			txt = item.info.owner.." share the license.",
			icon = "fas fa-handshake",
			params = {
				event = 'ruhsat:seks2',
				args = {
					item2 = item
				}
			}
		},
	})
end)

AddEventHandler('ruhsat:seks', function(args)
	local newItem2 = args.item2
	TriggerEvent('ruhsat:bak', newItem2)
end)

AddEventHandler('ruhsat:seks2', function(args)
	local newItem2 = args.item2
	TriggerEvent('ruhsat:ver', newItem2)
end)

RegisterNetEvent("ruhsat:bak")
AddEventHandler("ruhsat:bak", function(newItem2)
	TriggerServerEvent('jsfour-idcard:open', newItem2.info.citizenid, GetPlayerServerId(PlayerId()), 'weapon')
end)

RegisterNetEvent("ruhsat:ver")
AddEventHandler("ruhsat:ver", function(newItem2)
	local player = QBCore.Functions.GetClosestPlayer()
	if player ~= -1 then
    	TriggerServerEvent('jsfour-idcard:open', newItem2.info.citizenid, GetPlayerServerId(player), 'weapon')
	else
		QBCore.Functions.Notify("There is no one nearby.", "error")
	end
end)

RegisterNetEvent("ruhsat:bak")
AddEventHandler("ruhsat:bak", function(newItem2)
	TriggerServerEvent('jsfour-idcard:open', newItem2.info.citizenid, GetPlayerServerId(PlayerId()), 'weapon')
end)

RegisterNetEvent("ruhsat:ver")
AddEventHandler("ruhsat:ver", function(newItem2)
	local player = QBCore.Functions.GetClosestPlayer()
	if player ~= -1 then
    	TriggerServerEvent('jsfour-idcard:open', newItem2.info.citizenid, GetPlayerServerId(player), 'weapon')
	else
		QBCore.Functions.Notify("There is no one nearby.", "error")
	end
end)