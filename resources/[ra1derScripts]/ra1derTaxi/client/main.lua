QBCore = nil 
Citizen.CreateThread(function()
	while QBCore == nil do
		TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)
		Citizen.Wait(0)
	end

	while QBCore.Functions.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	PlayerData = QBCore.Functions.GetPlayerData()
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function(xPlayer)
    local isLoggedIn = true

	PlayerData = xPlayer
end)

RegisterNetEvent('QBCore:Client:OnJobUptade')
AddEventHandler('QBCore:Client:OnJobUptade',  function(job)
	PlayerData.job = job
end)
-- Code

local isLoggedIn = false
local PlayerData = {}

local meterIsOpen = false

local meterActive = false
local currentTaxi = nil

local lastLocation = nil

local meterData = {
    fareAmount = 3,
    currentFare = 0,
    distanceTraveled = 0,
}

local dutyPlate = nil

local NpcData = {
    Active = false,
    CurrentNpc = nil,
    LastNpc = nil,
    CurrentDeliver = nil,
    LastDeliver = nil,
    Npc = nil,
    NpcBlip = nil,
    DeliveryBlip = nil,
    NpcTaken = false,
    NpcDelivered = false,
    -- CountDown = 180
}

RegisterNetEvent("taksiaracsil", function()
    if #(GetEntityCoords(PlayerPedId()) - vector3(914.62, -165.15, 74.09)) < 15.0 then
        if IsPedInAnyVehicle(PlayerPedId(), false) then
            DoScreenFadeOut(1000)
            Wait(1500)
            QBCore.Functions.DeleteVehicle(GetVehiclePedIsIn(PlayerPedId()))
            TriggerServerEvent("elixir-base:KullanciPara", QBCore.Key, "ekle", "üst", "250")
            DoScreenFadeIn(1000)
        end
    else
        QBCore.Functions.Notify('You can only leave the vehicle at the taxi center!', 'error', 7500)
    end
end)

RegisterCommand("taxi", function()
    local veh = GetVehiclePedIsIn(PlayerPedId(),false)
    if DoesEntityExist(veh) then
            if whitelistedVehicle(veh) then 
                    exports['qb-menu']:openMenu({
                        {
                            header = "Taxi Actions",
                            icon = "fas fa-question-circle",
                            isMenuHeader = true
                        },
                        {
                            header = "Customer Search",
                            icon = "fas fa-users",
                            txt = "",
                            isServer = false,
                            params = {
                                event = "taksinpc"
                            }
                        },
                        {
                            header = "Show Taximeter",
                            icon = "fas fa-tachometer",
                            txt = "",
                            isServer = false,
                            params = {
                                event = "taksimetre"
                            }
                        },
                        {
                            header = "Taximeter On/Off",
                            icon = "fas fa-lock-open",
                            isServer = false,
                            params = {
                                event = "taksimetreac"
                            }
                        },
                        {
                            header = "Drop Vehicle (250$ Deposit)",
                            icon = "fas fa-taxi",
                            isServer = false,
                            params = {
                                event = "taksiaracsil"
                            }
                        },
                        {
                            header = "Close Menu",
                            icon = "fas fa-times",
                            txt = "",
                            params = {
                                event = "qb-menu:closeMenu"
                            }
                        },
                    })
        else
            QBCore.Functions.Notify('You are not in the taxi car you were given!', 'error', 7500)
        end
    end
end)
RegisterNetEvent("taksiver", function()
    OpenBoatsMenu(917.0228, -160.889, 74.799)
end)

RegisterNetEvent("rentTaxi", function()
    PlayerData = QBCore.Functions.GetPlayerData()
    local lisans = PlayerData.metadata.licences["drive"]
    if lisans then 
        TriggerServerEvent("ra1derTaxi:RentTaxi")
    else
        QBCore.Functions.Notify('You cant start a taxi business because you dont have a drivers license!', 'error', 7500)
    end
end)

CreateThread(function()
    local taxi = vector3(894.87, -179.21, 73.7)
    local taxiH = 239.7
    exports["elixir-base"]:pedcreate("taxi", 0xFDA94268, taxi.x, taxi.y, taxi.z,  taxiH)
end)

exports['qb-target']:AddBoxZone("taxi", vector3(894.87, -179.21, 73.7), 1.1, 1.1, {
	name = "Clothingggg",
	heading = 239.23,
	debugPoly = false,
	minZ = 73.56,
	maxZ = 75.87834,
	}, {
		options = {
			{
            	type = "client",
            	event = "rentTaxi",
				icon = "fas fa-taxi",
				label = "Take Taxi Car",
			},
		},
		distance = 2.0
})

CreateThread(function()
    local taxi,taxTab = false,{
		"taxi"
    }
    while true do 
        Wait(0)
        local veh = GetVehiclePedIsIn(PlayerPedId(),false)
        if veh then
            local btaxi = false
            for k,v in pairs(taxTab) do
                if GetEntityModel(veh) == GetHashKey(v) then
                    btaxi = true
                end
            end
            if btaxi and not taxi then
                taxi = true
                --Taksi ise
                QBCore.Functions.Notify("You can use taxi operations with /taxi!", 15000)
            end
        elseif taxi then
            taxi = false
        end
    end
end)



RegisterNetEvent("opentaximenu")
AddEventHandler("opentaximenu",function()
    DoScreenFadeOut(1000)
    Wait(1500)
    OpenBoatsMenu(917.0228, -160.889, 74.799)
    DoScreenFadeIn(1000)
end)

function OpenBoatsMenu(x, y , z)
	local ped = PlayerPedId()
	SetPedCoordsKeepVehicle(ped, x, y , z)
	TriggerEvent('QBCore:Command:SpawnVehicle', "taxi")
end

RegisterNetEvent("taksinpc",function()
    TriggerEvent('qb-taxi:client:DoTaxiNpc')
end)

RegisterNetEvent('qb-taxi:client:DoTaxiNpc')
AddEventHandler('qb-taxi:client:DoTaxiNpc', function()
    local veh = GetVehiclePedIsIn(PlayerPedId(),false)
    if DoesEntityExist(veh) then
        if whitelistedVehicle(veh) then
                if not NpcData.Active then
                    NpcData.CurrentNpc = math.random(1, #Config.NPCLocations.TakeLocations)
                    if NpcData.LastNpc ~= nil then
                        while NpcData.LastNpc ~= NpcData.CurrentNpc do
                            NpcData.CurrentNpc = math.random(1, #Config.NPCLocations.TakeLocations)
                        end
                    end

                    local Gender = math.random(1, #Config.NpcSkins)
                    local PedSkin = math.random(1, #Config.NpcSkins[Gender])
                    local model = GetHashKey(Config.NpcSkins[Gender][PedSkin])
                    RequestModel(model)
                    while not HasModelLoaded(model) do
                        Citizen.Wait(0)
                    end
                    NpcData.Npc = CreatePed(3, model, Config.NPCLocations.TakeLocations[NpcData.CurrentNpc].x, Config.NPCLocations.TakeLocations[NpcData.CurrentNpc].y, Config.NPCLocations.TakeLocations[NpcData.CurrentNpc].z - 0.98, Config.NPCLocations.TakeLocations[NpcData.CurrentNpc].h, false, true)
                    PlaceObjectOnGroundProperly(NpcData.Npc)
                    FreezeEntityPosition(NpcData.Npc, true)
                    if NpcData.NpcBlip ~= nil then
                        RemoveBlip(NpcData.NpcBlip)
                    end
                    exports['elix1rBase']:SendAlert("NPC, shown in your navigation!")
                    NpcData.NpcBlip = AddBlipForCoord(Config.NPCLocations.TakeLocations[NpcData.CurrentNpc].x, Config.NPCLocations.TakeLocations[NpcData.CurrentNpc].y, Config.NPCLocations.TakeLocations[NpcData.CurrentNpc].z)
                    SetBlipColour(NpcData.NpcBlip, 3)
                    SetBlipRoute(NpcData.NpcBlip, true)
                    SetBlipRouteColour(NpcData.NpcBlip, 3)
                    NpcData.LastNpc = NpcData.CurrentNpc
                    NpcData.Active = true

                    Citizen.CreateThread(function()
                        while not NpcData.NpcTaken do

                            local ped = PlayerPedId()
                            local pos = GetEntityCoords(ped)
                            local dist = GetDistanceBetweenCoords(pos, Config.NPCLocations.TakeLocations[NpcData.CurrentNpc].x, Config.NPCLocations.TakeLocations[NpcData.CurrentNpc].y, Config.NPCLocations.TakeLocations[NpcData.CurrentNpc].z, true)

                            if dist < 20 then
                                -- DrawMarker(2, Config.NPCLocations.TakeLocations[NpcData.CurrentNpc].x, Config.NPCLocations.TakeLocations[NpcData.CurrentNpc].y, Config.NPCLocations.TakeLocations[NpcData.CurrentNpc].z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 255, 255, 255, 255, 0, 0, 0, 1, 0, 0, 0)
                            
                                if dist < 5 then
                                    local npccoords = GetEntityCoords(NpcData.Npc)
                                    exports['qb-ui']:showInteraction("[E] Call the Customer to the Vehicle", nil, "mcagir")
                                    -- DrawText3D(Config.NPCLocations.TakeLocations[NpcData.CurrentNpc].x, Config.NPCLocations.TakeLocations[NpcData.CurrentNpc].y, Config.NPCLocations.TakeLocations[NpcData.CurrentNpc].z, '[E] Araca Çagır')
                                    if IsControlJustPressed(0, Keys["E"]) then
                                        exports['qb-ui']:hideInteraction("mcagir")
                                        local veh = GetVehiclePedIsIn(ped, 0)
                                        local maxSeats, freeSeat = GetVehicleMaxNumberOfPassengers(vehicle)

                                        for i=maxSeats - 1, 0, -1 do
                                            if IsVehicleSeatFree(vehicle, i) then
                                                freeSeat = i
                                                break
                                            end
                                        end

                                        meterIsOpen = true
                                        meterActive = true
                                        lastLocation = GetEntityCoords(PlayerPedId())
                                        SendNUIMessage({
                                            action = "openMeter",
                                            toggle = true,
                                            meterData = Config.Meter
                                        })
                                        SendNUIMessage({
                                            action = "toggleMeter"
                                        })

                                        ClearPedTasksImmediately(NpcData.Npc)
                                        FreezeEntityPosition(NpcData.Npc, false)
                                        TaskEnterVehicle(NpcData.Npc, veh, -1, freeSeat, 1.0, 0)
                                        exports['elix1rBase']:SendAlert("Get the NPC from the marked location!")
                                        if NpcData.NpcBlip ~= nil then
                                            RemoveBlip(NpcData.NpcBlip)
                                        end
                                        GetDeliveryLocation()
                                        NpcData.NpcTaken = true
                                    end
                                else
                                    exports['qb-ui']:hideInteraction("mcagir")
                                end
                            end

                            Citizen.Wait(1)
                        end
                    end)
                else
                    exports['elix1rBase']:SendAlert("You're already doing an NPC quest!")
                end
        else
            exports['elix1rBase']:SendAlert("You are not a taxi driver.")
        end
    end
end)

function GetDeliveryLocation()
    NpcData.CurrentDeliver = math.random(1, #Config.NPCLocations.DeliverLocations)
    if NpcData.LastDeliver ~= nil then
        while NpcData.LastDeliver ~= NpcData.CurrentDeliver do
            NpcData.CurrentDeliver = math.random(1, #Config.NPCLocations.DeliverLocations)
        end
    end

    if NpcData.DeliveryBlip ~= nil then
        RemoveBlip(NpcData.DeliveryBlip)
    end
    NpcData.DeliveryBlip = AddBlipForCoord(Config.NPCLocations.DeliverLocations[NpcData.CurrentDeliver].x, Config.NPCLocations.DeliverLocations[NpcData.CurrentDeliver].y, Config.NPCLocations.DeliverLocations[NpcData.CurrentDeliver].z)
    SetBlipColour(NpcData.DeliveryBlip, 3)
    SetBlipRoute(NpcData.DeliveryBlip, true)
    SetBlipRouteColour(NpcData.DeliveryBlip, 3)
    NpcData.LastDeliver = NpcData.CurrentDeliver

    Citizen.CreateThread(function()
        while true do

            local ped = PlayerPedId()
            local pos = GetEntityCoords(ped)
            local dist = GetDistanceBetweenCoords(pos, Config.NPCLocations.DeliverLocations[NpcData.CurrentDeliver].x, Config.NPCLocations.DeliverLocations[NpcData.CurrentDeliver].y, Config.NPCLocations.DeliverLocations[NpcData.CurrentDeliver].z, true)

            if dist < 10 then
                DrawMarker(2, Config.NPCLocations.DeliverLocations[NpcData.CurrentDeliver].x, Config.NPCLocations.DeliverLocations[NpcData.CurrentDeliver].y, Config.NPCLocations.DeliverLocations[NpcData.CurrentDeliver].z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 255, 255, 255, 255, 0, 0, 0, 1, 0, 0, 0)
            
                if dist < 5 then
                    local npccoords = GetEntityCoords(NpcData.Npc)
                    -- DrawText3D(Config.NPCLocations.DeliverLocations[NpcData.CurrentDeliver].x, Config.NPCLocations.DeliverLocations[NpcData.CurrentDeliver].y, Config.NPCLocations.DeliverLocations[NpcData.CurrentDeliver].z, '[E] Müsteriyi Indir')
                    exports['qb-ui']:showInteraction("[E] Talk to Customer", nil, "mindir")
                    if IsControlJustPressed(0, Keys["E"]) then
                        exports['qb-ui']:hideInteraction("mindir")
                        local veh = GetVehiclePedIsIn(ped, 0)
                        TaskLeaveVehicle(NpcData.Npc, veh, 0)
                        SetEntityAsMissionEntity(NpcData.Npc, false, true)
                        SetEntityAsNoLongerNeeded(NpcData.Npc)
                        local targetCoords = Config.NPCLocations.TakeLocations[NpcData.LastNpc]
                        TaskGoStraightToCoord(NpcData.Npc, targetCoords.x, targetCoords.y, targetCoords.z, 1.0, -1, 0.0, 0.0)
                        SendNUIMessage({
                            action = "toggleMeter"
                        })
                        TriggerServerEvent('qb-taxi:server:NpcPay', meterData.currentFare)
                        exports['elix1rBase']:SendAlert("You left the person where they wanted")
                        if NpcData.DeliveryBlip ~= nil then
                            RemoveBlip(NpcData.DeliveryBlip)
                        end
                        Wait(3500)
                        -- RemovePed(NpcData.Npc)
                            if DoesEntityExist(NpcData.Npc) then
                                DeletePed(NpcData.Npc)
                            end
                        ResetNpcTask()
                        break
                    end
                else
                    exports['qb-ui']:hideInteraction("mindir")
                end
            end

            Citizen.Wait(1)
        end
    end)
end

function ResetNpcTask()
    NpcData = {
        Active = false,
        CurrentNpc = nil,
        LastNpc = nil,
        CurrentDeliver = nil,
        LastDeliver = nil,
        Npc = nil,
        NpcBlip = nil,
        DeliveryBlip = nil,
        NpcTaken = false,
        NpcDelivered = false,
    }
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(3000)
        calculateFareAmount()
    end
end)

function calculateFareAmount()
    if meterIsOpen and meterActive then
        start = lastLocation
  
        if start then
            current = GetEntityCoords(PlayerPedId())
            distance = CalculateTravelDistanceBetweenPoints(start, current)
            meterData['distanceTraveled'] = distance
    
            fareAmount = (meterData['distanceTraveled'] / 100.00) * meterData['fareAmount']
    
            meterData['currentFare'] = math.ceil(fareAmount)

            SendNUIMessage({
                action = "updateMeter",
                meterData = meterData
            })
        end
    end
end

-- Citizen.CreateThread(function()
--     while true do
--         inRange = false
--             if ESX.GetPlayerData().job.name == "taxi" then
--                 local ped = PlayerPedId()
--                 local pos = GetEntityCoords(ped)
--                 local vehDist = GetDistanceBetweenCoords(pos, Config.Locations["vehicle"]["x"], Config.Locations["vehicle"]["y"], Config.Locations["vehicle"]["z"])

--                 if vehDist < 30 then
--                     inRange = true

--                     DrawMarker(2, Config.Locations["vehicle"]["x"], Config.Locations["vehicle"]["y"], Config.Locations["vehicle"]["z"], 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 0.3, 0.5, 0.2, 200, 0, 0, 222, false, false, false, true, false, false, false)

--                     if vehDist < 1.5 then
--                         if whitelistedVehicle() then
--                             DrawText3D(Config.Locations["vehicle"]["x"], Config.Locations["vehicle"]["y"], Config.Locations["vehicle"]["z"] + 0.3, '[E] Voertuig Parkeren')
--                             if IsControlJustReleased(0, Keys["E"]) then
--                                 if IsPedInAnyVehicle(PlayerPedId(), false) then
--                                     DeleteVehicle(GetVehiclePedIsIn(PlayerPedId()))
--                                 end
--                             end
--                         else
--                             DrawText3D(Config.Locations["vehicle"]["x"], Config.Locations["vehicle"]["y"], Config.Locations["vehicle"]["z"] + 0.3, '[E] Voertuig Pakken')
--                             if IsControlJustReleased(0, Keys["E"]) then
--                                 TaxiGarage()
--                                 Menu.hidden = not Menu.hidden
--                             end
--                         end
--                         Menu.renderGUI()
--                     end
--                 end
--             end

--         if not inRange then
--             Citizen.Wait(3000)
--         end

--         Citizen.Wait(3)
--     end
-- end)
RegisterNetEvent("taksimetre",function()
    -- if ESX.GetPlayerData().job.name == "taxi" then
        TriggerEvent('qb-taxi:client:toggleMeter')
        -- TriggerEvent('qb-taxi:client:toggleMuis')
    -- end
end)

RegisterNetEvent("taksimetreac",function()
    -- if QBCore.Functions.GetPlayerData().job.name == "taxi" then
        meterIsOpen = true
        meterActive = true
        SendNUIMessage({
            action = "openMeter",
            toggle = true,
            meterData = Config.Meter
        })
        SendNUIMessage({
            action = "toggleMeter"
        })

    -- end
end)



RegisterNetEvent('qb-taxi:client:toggleMeter')
AddEventHandler('qb-taxi:client:toggleMeter', function()
    local ped = PlayerPedId()
    
    if IsPedInAnyVehicle(ped, false) then
        if whitelistedVehicle() then
            if not meterIsOpen then
                SendNUIMessage({
                    action = "openMeter",
                    toggle = true,
                    meterData = Config.Meter
                })
                meterIsOpen = true
            else
                SendNUIMessage({
                    action = "openMeter",
                    toggle = false
                })
                meterIsOpen = false
            end
        else
            exports['elix1rBase']:SendAlert("This vehicle does not have a taximeter!")
        end
    else
        exports['elix1rBase']:SendAlert("You are not in the vehicle!")
    end
end)

RegisterNetEvent('qb-taxi:client:enableMeter')
AddEventHandler('qb-taxi:client:enableMeter', function()
    local ped = PlayerPedId()

    if meterIsOpen then
        SendNUIMessage({
            action = "toggleMeter"
        })
    else
        exports['elix1rBase']:SendAlert("The taximeter is not active!")
    end
end)

RegisterNUICallback('enableMeter', function(data)
    meterActive = data.enabled

    if not data.enabled then
        SendNUIMessage({
            action = "resetMeter"
        })
    end
    lastLocation = GetEntityCoords(PlayerPedId())
end)

RegisterNetEvent('qb-taxi:client:toggleMuis')
AddEventHandler('qb-taxi:client:toggleMuis', function()
    Citizen.Wait(400)
    if meterIsOpen then
        if not mouseActive then
            SetNuiFocus(true, true)
            mouseActive = true
        end
    else
        exports['elix1rBase']:SendAlert("No taximeter, my friend!")
    end
end)

RegisterNUICallback('hideMouse', function()
    SetNuiFocus(false, false)
    mouseActive = false
end)

function whitelistedVehicle(vehicle)
    local veh = GetEntityModel(vehicle)
    local retval = false

    for i = 1, #Config.AllowedVehicles, 1 do
        if veh == GetHashKey(Config.AllowedVehicles[i].model) then
            retval = true
            break
        end
    end
    return retval
end

function TaxiGarage()
    ped = PlayerPedId();
    MenuTitle = "Garage"
    ClearMenu()
    Menu.addButton("Voertuigen", "VehicleList", nil)
    Menu.addButton("Sluit Menu", "closeMenuFull", nil) 
end

function VehicleList()
    ped = PlayerPedId();
    MenuTitle = "Voertuigen:"
    ClearMenu()
    for k, v in pairs(Config.AllowedVehicles) do
        Menu.addButton(Config.AllowedVehicles[k].label, "TakeVehicle", k, "Garage", " Motor: 100%", " Body: 100%", " Fuel: 100%")
    end
        
    Menu.addButton("Terug", "TaxiGarage",nil)
end

function TakeVehicle(k)
        local coords = {x = Config.Locations["vehicle"]["x"], y = Config.Locations["vehicle"]["y"], z = Config.Locations["vehicle"]["z"]}
        QBCore.Functions.SpawnVehicle(Config.AllowedVehicles[k].model, function(veh)
            SetVehicleNumberPlateText(veh, "TAXI"..tostring(math.random(1000, 9999)))
            SetEntityHeading(veh, Config.Locations["vehicle"]["h"])
            exports['LegacyFuel']:SetFuel(veh, 100.0)
            closeMenuFull()
            TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
            TriggerEvent("x-hotwire:give-keys", GetVehicleNumberPlateText(veh))
            SetVehicleEngineOn(veh, true, true)
            dutyPlate = GetVehicleNumberPlateText(veh)
        end, coords, true)
end

function closeMenuFull()
    Menu.hidden = true
    currentGarage = nil
    ClearMenu()
end

-- function DrawText3D(x, y, z, text)
-- 	SetTextScale(0.35, 0.35)
--     SetTextFont(4)
--     SetTextProportional(1)
--     SetTextColour(255, 255, 255, 215)
--     SetTextEntry("STRING")
--     SetTextCentre(true)
--     AddTextComponentString(text)
--     SetDrawOrigin(x,y,z, 0)
--     DrawText(0.0, 0.0)
--     local factor = (string.len(text)) / 370
--     DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
--     ClearDrawOrigin()
-- end

Citizen.CreateThread(function()
    TaxiBlip = AddBlipForCoord(Config.Locations["vehicle"]["x"], Config.Locations["vehicle"]["y"], Config.Locations["vehicle"]["z"])

    SetBlipSprite (TaxiBlip, 198)
    SetBlipDisplay(TaxiBlip, 4)
    SetBlipScale  (TaxiBlip, 0.6)
    SetBlipAsShortRange(TaxiBlip, true)
    SetBlipColour(TaxiBlip, 5)

    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName("Downtown Cab")
    EndTextCommandSetBlipName(TaxiBlip)
end)