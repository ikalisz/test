local QBCore = exports['qb-core']:GetCoreObject()
local Hired = false
local HasPizza = false
local DeliveriesCount = 0
local Delivered = false
local PizzaDelivered = false
local ownsVan = false
local activeOrder = false

CreateThread(function()
    local pizzajobBlip = AddBlipForCoord(vector3(Config.BossCoords.x, Config.BossCoords.y, Config.BossCoords.z)) 
    SetBlipSprite(pizzajobBlip, 267)
    SetBlipAsShortRange(pizzajobBlip, true)
    SetBlipScale(pizzajobBlip, 0.6)
    SetBlipColour(pizzajobBlip, 2)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Pizza Teslimat")
    EndTextCommandSetBlipName(pizzajobBlip)
end)

function ClockInPed()

    if not DoesEntityExist(pizzaBoss) then

        RequestModel(Config.BossModel) while not HasModelLoaded(Config.BossModel) do Wait(0) end

        pizzaBoss = CreatePed(0, Config.BossModel, Config.BossCoords, false, false)
        
        SetEntityAsMissionEntity(pizzaBoss)
        SetPedFleeAttributes(pizzaBoss, 0, 0)
        SetBlockingOfNonTemporaryEvents(pizzaBoss, true)
        SetEntityInvincible(pizzaBoss, true)
        FreezeEntityPosition(pizzaBoss, true)
        loadAnimDict("amb@world_human_leaning@female@wall@back@holding_elbow@idle_a")        
        TaskPlayAnim(pizzaBoss, "amb@world_human_leaning@female@wall@back@holding_elbow@idle_a", "idle_a", 8.0, 1.0, -1, 01, 0, 0, 0, 0)

        exports['qb-target']:AddTargetModel(Config.BossModel, { 
            options = {
                { 
                    type = "client",
                    event = "ra1derPizzaJob:client:startJob",
                    icon = "fa-solid fa-pizza-slice",
                    label = "Get Started",
                    canInteract = function()
                        return not Hired
                    end,
                },
                { 
                    type = "client",
                    event = "ra1derPizzaJob:client:finishWork",
                    icon = "fa-solid fa-pizza-slice",
                    label = "Finish the Job",
                    canInteract = function()
                        return Hired
                    end,
                },
            }, 
            distance = 1.5, 
        })
    end
end

AddEventHandler('onResourceStart', function(resource)
    if GetCurrentResourceName() == resource then
        PlayerJob = QBCore.Functions.GetPlayerData().job
        ClockInPed()
    end
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    ClockInPed()
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    exports['qb-target']:RemoveZone("deliverZone")
    RemoveBlip(JobBlip)
    Hired = false
    HasPizza = false
    DeliveriesCount = 0
    Delivered = false
    PizzaDelivered = false
    ownsVan = false
    activeOrder = false  
    DeletePed(pizzaBoss)
end)

AddEventHandler('onResourceStop', function(resourceName) 
	if GetCurrentResourceName() == resourceName then
        exports['qb-target']:RemoveZone("deliverZone")
        RemoveBlip(JobBlip)
        Hired = false
        HasPizza = false
        DeliveriesCount = 0
        Delivered = false
        PizzaDelivered = false
        ownsVan = false
        activeOrder = false
        DeletePed(pizzaBoss)  
	end 
end)

CreateThread(function()
    DecorRegister("pizza_job", 1)
end)

function PullOutVehicle()
    if ownsVan then
        QBCore.Functions.Notify("You already have a business tool! Go and get it or end your job", "error")
    else
        PlayerData = QBCore.Functions.GetPlayerData()
        local lisans = PlayerData.metadata.licences["drive"]
        if lisans then 
            local coords = Config.VehicleSpawn
            QBCore.Functions.SpawnVehicle2(Config.Vehicle, function(pizzaCar)
                SetVehicleNumberPlateText(pizzaCar, "PIZZA"..tostring(math.random(1000, 9999)))
                SetVehicleColours(pizzaCar, 111, 111)
                SetVehicleDirtLevel(pizzaCar, 1)
                DecorSetFloat(pizzaCar, "pizza_job", 1)
                TaskWarpPedIntoVehicle(PlayerPedId(), pizzaCar, -1)
                TriggerEvent("x-hotwire:give-keys", pizzaCar)
                SetVehicleEngineOn(pizzaCar, true, true)
                exports["np-fuel"]:SetFuel(pizzaCar, 100.0)
                exports['qb-target']:AddTargetEntity(pizzaCar, {
                    options = {
                        {
                            icon = "fa-solid fa-pizza-slice",
                            label = "Pizza Al",
                            action = function(entity) TakePizza() end,
                            canInteract = function() 
                                return Hired and activeOrder and not HasPizza
                            end,
                            
                        },
                    },
                    distance = 2.5
                })
            end, coords, true)
            Hired = true
            ownsVan = true
            NextDelivery()
        else
            QBCore.Functions.Notify('You cant get a job here without a license.!', 'error', 7500)
        end
    end
end


RegisterNetEvent('ra1derPizzaJob:client:startJob', function()
    if not Hired then
        PullOutVehicle()
    end
end)


RegisterNetEvent('ra1derPizzaJob:client:deliverPizza', function()
    if HasPizza and Hired and not PizzaDelivered then
        TriggerEvent('animations:client:EmoteCommandStart', {"knock"})
        PizzaDelivered = true
        QBCore.Functions.Progressbar("knock", "Pizza Teslim Ediliyor", 3000, false, false, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {}, {}, {}, function()
            TriggerServerEvent("ra1derPizzaJob:server:Bahsis")
            DeliveriesCount = DeliveriesCount + 1
            RemoveBlip(JobBlip)
            exports['qb-target']:RemoveZone("deliverZone")
            HasPizza = false
            activeOrder = false
            PizzaDelivered = false
            DetachEntity(prop, 1, 1)
            DeleteObject(prop)
            Wait(1000)
            ClearPedSecondaryTask(PlayerPedId())
            QBCore.Functions.Notify("Pizza delivered, go to new location", "success") 
            SetTimeout(5000, function()    
                NextDelivery()
            end)
        end)
    else
        QBCore.Functions.Notify("You didn't take the pizza from the car?.", "error") 
    end
end)


function loadAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
		RequestAnimDict(dict)
		Wait(0)
	end
end

function TakePizza()
    local player = PlayerPedId()
    local pos = GetEntityCoords(player)
    if not IsPedInAnyVehicle(player, false) then
        local ad = "anim@heists@box_carry@"
        local prop_name = 'prop_pizza_box_01'
        if DoesEntityExist(player) and not IsEntityDead(player) then
            if not HasPizza then
                if #(pos - vector3(newDelivery.x, newDelivery.y, newDelivery.z)) < 30.0 then
                    loadAnimDict(ad)
                    local x,y,z = table.unpack(GetEntityCoords(player))
                    prop = CreateObject(GetHashKey(prop_name), x, y, z+0.2,  true,  true, true)
                    AttachEntityToEntity(prop, player, GetPedBoneIndex(player, 60309), 0.2, 0.08, 0.2, -45.0, 290.0, 0.0, true, true, false, true, 1, true)
                    TaskPlayAnim(player, ad, "idle", 3.0, -8, -1, 63, 0, 0, 0, 0 )
                    HasPizza = true
                else
                    QBCore.Functions.Notify("You are not close enough to the customer's home!", "error")
                end
            end
        end
    end
end


function NextDelivery()
    if not activeOrder then
        newDelivery = Config.JobLocs[math.random(1, #Config.JobLocs)]

        JobBlip = AddBlipForCoord(newDelivery.x, newDelivery.y, newDelivery.z)
        SetBlipSprite(JobBlip, 1)
        SetBlipDisplay(JobBlip, 4)
        SetBlipScale(JobBlip, 0.8)
        SetBlipFlashes(JobBlip, true)
        SetBlipAsShortRange(JobBlip, true)
        SetBlipColour(JobBlip, 2)
        SetBlipRoute(JobBlip, true)
        SetBlipRouteColour(JobBlip, 2)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName("New customer")
        EndTextCommandSetBlipName(JobBlip)
        exports['qb-target']:AddCircleZone("deliverZone", vector3(newDelivery.x, newDelivery.y, newDelivery.z), 1.3,{ name = "deliverZone", debugPoly = false, useZ=true, }, { options = { { type = "client", event = "ra1derPizzaJob:client:deliverPizza", icon = "fa-solid fa-pizza-slice", label = "Pizzayı Teslim Et"}, }, distance = 1.5 })
        activeOrder = true
        QBCore.Functions.Notify("You have a new delivery!", "success")
    end
end

RegisterNetEvent('ra1derPizzaJob:client:finishWork', function()
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
    local veh = QBCore.Functions.GetClosestVehicle()
    local finishspot = vector3(Config.BossCoords.x, Config.BossCoords.y, Config.BossCoords.z)
    if #(pos - finishspot) < 10.0 then
        if Hired then
            if DecorExistOn((veh), "pizza_job") then
                QBCore.Functions.DeleteVehicle(veh)
                RemoveBlip(JobBlip)
                Hired = false
                HasPizza = false
                ownsVan = false
                activeOrder = false
                if DeliveriesCount > 0 then
                    TriggerServerEvent('ra1derPizzaJob:server:Payment', DeliveriesCount)
                else
                    QBCore.Functions.Notify("You were not paid for not completing any deliveries.", "error")
                end
                DeliveriesCount = 0
            else
                QBCore.Functions.Notify("You must return your work vehicle to receive payment.", "error")
                return
            end
        end
    end
end)

