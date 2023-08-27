local QBCore = exports['qb-core']:GetCoreObject()


local miner = PolyZone:Create({
    vector2(2955.273, 2768.700),
    vector2(2941.150, 2761.797),
    vector2(2917.542, 2791.934),
    vector2(2926.708, 2800.845),
},{
    name = "Miner",
    minZ = 38.0,
    maxZ = 45.0,
    debugPoly = Config.DebugPoly
})

Citizen.CreateThread(function()
    if Config.UseBlips then
    local miners = AddBlipForCoord(Config.BlipCoord.x, Config.BlipCoord.y, Config.BlipCoord.z)
    SetBlipSprite(miners, 568) -- Blip ID
    SetBlipDisplay(miners, 4) 
    SetBlipScale (miners, 0.8) --Blip Scale
    SetBlipColour(miners, 1) -- Blip Color
    SetBlipAsShortRange(miners, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(Config.MinerBlipText)
    EndTextCommandSetBlipName(miners)

    local ped = AddBlipForCoord(Config.PedCoord.x, Config.PedCoord.y, Config.PedCoord.z)
    SetBlipSprite(ped, 233) -- Blip ID
    SetBlipDisplay(ped, 4) 
    SetBlipScale (ped, 0.8) --Blip Scale
    SetBlipColour(ped, 4) -- Blip Color
    SetBlipAsShortRange(ped, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(Config.SellBlipText)
    EndTextCommandSetBlipName(ped)
    end
end)

attemptTreasureChest = function()
	local ped = PlayerPedId()
	local animDict = "veh@break_in@0h@p_m_one@"
	local animName = "low_force_entry_ds"
	RequestAnimDict(animDict)
	while not HasAnimDictLoaded(animDict) do
		Wait(100)
	end
	TaskPlayAnim(ped, animDict, animName, 1.0, 1.0, 1.0, 1, 0.0, 0, 0, 0)
	RemoveAnimDict(animDict)
	QBCore.Functions.Notify('You Are Trying To Open The Chest', 'primary', 1500)
	Wait(1500)
	ClearPedTasks(PlayerPedId())
end


RegisterNetEvent('ra1derMiner:client:KasaAç', function()
	local ped = PlayerPedId()
	attemptTreasureChest()
	QBCore.Functions.Progressbar("accepted_key", "Safe Opening", 3000, false, true, {
		disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
	}, {
		animDict = "mini@repair",
		anim = "fixing_a_player",
		flags = 16,
	}, {}, {}, function() -- Done
		ClearPedTasks(ped)
	end, function() -- Cancel
		ClearPedTasks(ped)
		QBCore.Functions.Notify("It is cancelled!", "error")
	end)
end)



RegisterNetEvent("ra1derMiner:serverStartMine")
AddEventHandler("ra1derMiner:serverStartMine", function()
    local playerCoords = GetEntityCoords(PlayerPedId())
    local coords = GetEntityCoords(PlayerPedId())
    local ped = PlayerPedId()
    MinerZone = miner:isPointInside(coords)
    if MinerZone then 
        TriggerServerEvent('InteractSound_SV:PlayOnSource', Config.MinerSoundName, Config.MinerSoundVolume)
        TriggerEvent("Give:Pickaxe")
        QBCore.Functions.Progressbar('Miner', Config.ProgressbarText, Config.ProgressbarTime, false, true, { -- Name | Label | Time | useWhileDead | canCancel
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {
            animDict = 'melee@large_wpn@streamed_core',
            anim = 'ground_attack_on_spot',
            flags = 16,
        }, {}, {}, function()
            TriggerEvent("Delete:Pickaxe")
        local finished = exports[Config.SkillbarName]:taskBar(Config.SkillbarTime, 50)
              if finished then
                local deger = math.random(0, 100)
                if deger >= 0 and deger < 45 then
                    TriggerServerEvent("stone:add")
                elseif deger >= 46 and deger < 57 then
                    TriggerServerEvent("scrapmetal:add")
                elseif deger >= 58 and deger < 66 then
                    TriggerServerEvent("scrapcopper:add") 	
                elseif deger >= 67 and deger < 80 then
                    TriggerServerEvent("scrapiron:add") 
                elseif deger >= 79 and deger < 90 then
                    TriggerServerEvent("scrapgold:add") 	
                elseif deger >= 90 and deger < 96 then
                    TriggerServerEvent("diamond:add") 
                elseif deger >= 97 and deger < 100 then	
                    TriggerServerEvent("case:add")
                end
            end
            end, function()
                QBCore.Functions.Notify(Config.Text["cancel"], 'error', 3500) 
            TriggerEvent("Delete:Pickaxe")
        end)
    else
        QBCore.Functions.Notify(Config.Text["not_minerzone"], 'error', 3500) 
        TriggerEvent("Delete:Pickaxe")
    end
end)

RegisterNetEvent("Give:Pickaxe")
AddEventHandler("Give:Pickaxe", function()
    pickaxe = CreateObject(GetHashKey(Config.PickaxeProp), 0, 0, 0, true, true, true) 
    AttachEntityToEntity(pickaxe, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 57005), -0.04, -0.04, -0.04, 350.0, 100.00, 140.0, true, true, false, true, 1, true)
end)

RegisterNetEvent("Delete:Pickaxe")
AddEventHandler("Delete:Pickaxe", function()
    DetachEntity(pickaxe, 1, true)
    DeleteEntity(pickaxe)
    DeleteObject(pickaxe, 1, true)
    DeleteObject(pickaxe)
    ClearPedTasks(PlayerPedId())
end)


-- RegisterNetEvent("ra1derMiner:client:SellMenu") 
-- AddEventHandler("ra1derMiner:client:SellMenu", function()
--     exports['qb-menu']:openMenu({
-- 		{
--             header = "Maden Materyalleri Satış",
--             icon = "fas fa-dollar-sign",
--             isMenuHeader = true
--         },
--         {
--             header = '<span style="color:#ffffff;">İşlenmiş Taş Parçaları Sat</span>',
--             txt = "Mevcut Fiyat: $: $"..Config.MetalPrice.."",
--             icon = "fas fa-comment-dollar",
--             params = {
-- 				isServer = true,
--                 event = "ra1derMiner:server:Sell",
-- 				args = 1
--             }
--         },
--         {
--             header = '<span style="color:#929292;">İşlenmiş Metal Sat </span>',
--             txt = "Mevcut Fiyat: $: $"..Config.MetalPrice.."",
--             icon = "fas fa-comment-dollar",
--             params = {
-- 				isServer = true,
--                 event = "ra1derMiner:server:Sell",
-- 				args = 2
--             }
--         },
--         {
--             header = '<span style="color:#6b3900;">İşlenmiş Bakır Sat </span>',
--             txt = "Mevcut Fiyat: $: $"..Config.CopperPrice.."",
--             icon = "fas fa-comment-dollar",
--             params = {
-- 				isServer = true,
--                 event = "ra1derMiner:server:Sell",
-- 				args = 3
--             }
--         },
--         {
--             header = '<span style="color:#b3b3b3;">İşlenmiş Demir Külçesi Sat </span>',
--             txt = "Mevcut Fiyat: $: $"..Config.IronPrice.."",
--             icon = "fas fa-comment-dollar",
--             params = {
-- 				isServer = true,
--                 event = "ra1derMiner:server:Sell",
-- 				args = 4
--             }
--         },
--         {
--             header = '<span style="color:#ffbe00;">İşlenmiş Altın Külçesi Sat </span>',
--             txt = "Mevcut Fiyat: $: $"..Config.GoldPrice.."",
--             icon = "fas fa-comment-dollar",
--             params = {
-- 				isServer = true,
--                 event = "ra1derMiner:server:Sell",
-- 				args = 5
--             }
--         },
--         {
--             header = '<span style="color:#00eeff;">İşlenmiş Elmas Parçacıkları Sat </span>',
--             txt = "Mevcut Fiyat: $"..Config.DiamondPrice.."",
--             icon = "fas fa-comment-dollar",
--             params = {
-- 				isServer = true,
--                 event = "ra1derMiner:server:Sell",
-- 				args = 6
--             }
--         },
--         {
--             header = '<span style="color:#ff0000;">Menüyü Kapat </span>',
--             txt = "",
--             icon = "fas fa-times",
--             params = {
--                 event = "qb-menu:closeMenu"
--             }
--         },
--     })
-- end)

RegisterNetEvent("ra1derMiner:client:Interactions") 
AddEventHandler("ra1derMiner:client:Interactions", function()
    exports['qb-menu']:openMenu({
		{
            header = "Miner Transactions",
            icon = "fas fa-question-circle",
            isMenuHeader = true
        },
        {
            header = "Buy Mine Pickaxe",
            icon = "fas fa-money-bill-wave-alt",
            txt = "Current Fee $" .. Config.PickaxePrice.. "",
			isServer = false,
            params = {
                event = "ra1derMiner:client:BuyPickaxe"
            }
        },
        {
            header = "Rent a Mine Vehicle",
            icon = "fas fa-money-check-alt",
            txt = "Current Fee $" .. Config.MinerCarPrice.. "",
			isServer = true,
            params = {
                event = "ra1derMiner:server:RentMinerCar"
            }
        },
        {
            header = "Return the Mine Vehicle",
            txt = "Deposit 250$",
            icon = "fas fa-undo-alt",
			isServer = true,
            params = {
                event = "ra1derMiner:client:DeleteCar"
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
end)

RegisterNetEvent("ra1derMiner:client:BuyPickaxe", function()
    local PlayerData = QBCore.Functions.GetPlayerData()
    TriggerServerEvent("ra1derMiner:server:BuyPickaxe", src)
end)

exports["qb-target"]:AddTargetModel(Config.PedModels, {
    options = {
        {
            event = "ra1derMiner:client:Interactions",
            icon = "bi bi-currency-dollar",
            label = "Mining Operations",
        },
    },
    distance = 4.0
})

Citizen.CreateThread(function()
     exports['qb-target']:AddBoxZone("ananın", vector3(1086.129, -2003.67, 31.973), 5.3, 4.0, {
        name="ananın",
        heading=314.2,
        debugPoly=false,
        minZ=28.8,
        maxZ=33.2
    }, {
        options = {
            {
                type = "client",
				event = "ra1derMiner:client:MadenIsle",
                icon = "far fa-credit-card",
                label = "Process Mines",
                jobs = {"all"},
            },
        },
        distance = 2
    })
end)


RegisterNetEvent("ra1derMiner:client:MadenIsle") 
AddEventHandler("ra1derMiner:client:MadenIsle", function()
    local function progressbar(miktar, item, fitem)
        miktar = math.floor(miktar / 10) * 10
        QBCore.Functions.Progressbar('name', 'Processing...', 2000*miktar*1.5, false, true, { -- Name | Label | Time | useWhileDead | canCancel
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {
            animDict = 'anim@gangops@facility@servers@',
            anim = 'hotwire',
            flags = 16,
        }, {}, {}, function() -- Play When Done
            QBCore.Functions.Notify("Processing completed.")
            TriggerServerEvent("ra1derMiner:server:IslemeEsyaVer", miktar, item, fitem)
        end, function() -- Play When Cancel
            --Stuff goes here
        end)
    end
    exports['qb-menu']:openMenu({
		{
            header = "Smelt and Process Minerals",
            icon = "fas fa-dungeon",
            isMenuHeader = true
        },
        {
            header = '<span style="color:#ffffff;">Taş İşle </span>',
            icon = "fas fa-chevron-right",
            txt = "Minimum of 40 required.",
            params = {
                functions = function()
                    QBCore.Functions.TriggerCallback("MadenIsleme", function(data)
                        if data >= 40 then
                          progressbar(data, "stone", "finishedstone")
                        else
                            QBCore.Functions.Notify("A minimum of 40 pieces is required to craft stones", "error")
                        end
                    end, "stone")
                end
            }
        },
        {
            header = '<span style="color:#929292;">Process Metal </span>',
            icon = "fas fa-chevron-right",
            txt = "Minimum of 30 required.",
            params = {
                functions = function()
                    QBCore.Functions.TriggerCallback("MadenIsleme", function(data)
                        if data >= 30 then
                            progressbar(data, "crudemetal", "finishedmetal")
                        else
                            QBCore.Functions.Notify("Minimum 30 pieces are required to craft stones", "error")
                          end
                    end, "crudemetal")
                end
            }
        },
        {
            header = '<span style="color:#6b3900;">Process Copper </span>',
            icon = "fas fa-chevron-right",
            txt = "Minimum of 30 required.",
            params = {
                functions = function()
                    QBCore.Functions.TriggerCallback("MadenIsleme", function(data)
                        if data >= 30 then
                            progressbar(data, "crudecopper", "finishedcopper")
                        else
                            QBCore.Functions.Notify("Minimum 30 pieces are required to process copper", "error")
                          end
                    end, "crudecopper")
                end
            }
        },
        {
            header = '<span style="color:#b3b3b3;">Process Iron </span>',
            icon = "fas fa-chevron-right", 
            txt = "Minimum 20 adet gerekiyor.",
            params = {
                functions = function()
                    QBCore.Functions.TriggerCallback("MadenIsleme", function(data)
                        if data >= 20 then
                            progressbar(data, "crudeiron", "finishediron")
                        else
                            QBCore.Functions.Notify("A minimum of 20 pieces is required to craft iron", "error")
                          end
                    end, "crudeiron")
                end
            }
        },
        {
            header = '<span style="color:#ffbe00;">Altın İşle </span>',
            icon = "fas fa-chevron-right", 
            txt = "Minimum of 10 required.",
            params = {
                functions = function()
                    QBCore.Functions.TriggerCallback("MadenIsleme", function(data)
                        if data >= 10 then
                            progressbar(data, "crudegold", "finishedgold")
                        else
                            QBCore.Functions.Notify("Minimum 10 pieces required to craft gold", "error")
                          end
                    end, "crudegold")
                end
            }
        },
        {
            header = '<span style="color:#00eeff;">Diamond Process </span>',
            icon = "fas fa-chevron-right",
            txt = "Minimum of 10 required.",
			isServer = true,
            params = {
                functions = function()
                    QBCore.Functions.TriggerCallback("MadenIsleme", function(data)
                        if data >= 10 then
                          progressbar(data, "crudediamond", "finisheddiamond")
                        else
                            QBCore.Functions.Notify("A minimum of 10 diamonds is required to process diamonds.", "error")
                        end
                    end, "crudediamond")
                end
            }
        },
        {
            header = '<span style="color:#ff0000;">Close Menu </span>',
            icon = "fas fa-times",
            txt = "",
            params = {
                event = "qb-menu:closeMenu"
            }
        },
    })
end)



RegisterNetEvent("ra1derMiner:server:RentMinerCar", function()
    PlayerData = QBCore.Functions.GetPlayerData()
    TriggerServerEvent("ra1derMiner:server:RentMinerCar")
end)

RegisterNetEvent("ra1derMiner:client:GiveCar")
AddEventHandler("ra1derMiner:client:GiveCar", function()
    if vehicle == nil then
        local modelHash = GetHashKey("Rebel2")
        local ped = PlayerPedId()
        if not HasModelLoaded(modelHash) and IsModelInCdimage(modelHash) then
            RequestModel(modelHash)
        
            while not HasModelLoaded(modelHash) do
                Citizen.Wait(1)
            end
        end
        local platetextrandom = math.random(111, 999)
            vehicle = CreateVehicle(modelHash, Config.MinerCarCoords, Config.MinerCarCoordHeading, 1, 0)
            local id = NetworkGetNetworkIdFromEntity(vehicle)
            SetNetworkIdCanMigrate(id, true)
            SetVehicleDirtLevel(vehicle, 0)
            exports[Config.FuelScript]:SetFuel(vehicle, 100.0)
            SetVehicleNumberPlateText(vehicle, "Miner" .. platetextrandom .. "")
            SetPedIntoVehicle(GetPlayerPed(-1), vehicle,-1) -- put player inside
            SetVehicleColours(vehicle, 135, 135)
            SetVehicleEngineOn(vehicle, true)
            SetVehicleMaxSpeed(vehicle, Config.MaxSpeed)
            TriggerEvent("x-hotwire:give-keys", vehicle) --Your need change this with your vehiclekeys script events
            SetNewWaypoint(2937.587, 2786.557)
    else
        QBCore.Functions.Notify(Config.Text["already_car"], "error", 5000)
    end
end)


RegisterNetEvent("ra1derMiner:client:DeleteCar")
AddEventHandler("ra1derMiner:client:DeleteCar", function()
    if vehicle ~= nil then
        DeleteEntity(vehicle)
        DeleteVehicle(vehicle)
        QBCore.Functions.DeleteVehicle(vehicle)
        vehicle = nil
        QBCore.Functions.Notify(Config.Text["return_car"], "success")
        Wait(600)
        TriggerServerEvent('ra1derMiner:server:AddMoney')
    else
        QBCore.Functions.Notify(Config.Text["error_car_message"], "error", 5000)
    end
end)


Citizen.CreateThread(function()
    RequestModel(GetHashKey(Config.PedModels))
    while not HasModelLoaded(GetHashKey(Config.PedModels)) do
        Wait(1)
    end
    npc = CreatePed(1, GetHashKey(Config.PedModels), Config.PedCoord.x, Config.PedCoord.y, Config.PedCoord.z, Config.PedHeading, false, true)
    SetPedCombatAttributes(npc, 46, true)               
    SetPedFleeAttributes(npc, 0, 0)               
    SetBlockingOfNonTemporaryEvents(npc, true)
    SetEntityAsMissionEntity(npc, true, true)
    SetEntityInvincible(npc, true)
    FreezeEntityPosition(npc, true)
end)

