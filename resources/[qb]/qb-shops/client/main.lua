QBCore = nil
local coreLoaded = false
Citizen.CreateThread(function()
    while QBCore == nil do
        TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)
        Citizen.Wait(200)
    end
    coreLoaded = true
end)

RegisterNetEvent('shops:ac')
AddEventHandler('shops:ac', function()
    if coreLoaded then
        local PlayerPos = GetEntityCoords(PlayerPedId())
        for shop, data in pairs(Config.Locations) do
            for _, loc in pairs(Config.Locations[shop]["coords"]) do
                if #(PlayerPos - vector3(loc["x"], loc["y"], loc["z"])) < 2 then
                    local marketismiamk = Config.Locations[shop]["label"]
                    if marketismiamk == 'Weapon Shop' then
                        -- if exports['jtLevelSystem']:getXP() >= 150 then
                            local ShopItems = {}
                            ShopItems.label = Config.Locations[shop]["label"]
                            ShopItems.items = Config.Locations[shop]["products"]
                            ShopItems.slots = #Config.Locations[shop]["products"]
                            TriggerServerEvent("inventory:server:OpenInventory", "shop", "Itemshop_"..shop, ShopItems)
                        -- else
                        --     QBCore.Functions.Notify("Silah alabilecek bir tecrüben yok!", "error")
                        -- end
                    elseif marketismiamk == 'Eyşan Abla' then
                        if QBCore.Functions.GetPlayerData().job.name == "picler" then
                            local ShopItems = {}
                            ShopItems.label = Config.Locations[shop]["label"]
                            ShopItems.items = Config.Locations[shop]["products"]
                            ShopItems.slots = #Config.Locations[shop]["products"]
                            TriggerServerEvent("inventory:server:OpenInventory", "shop", "Itemshop_"..shop, ShopItems)
                        else
                            QBCore.Functions.Notify("Even trial to me!", "error")
                        end
                    else
                        local ShopItems = {}
                        ShopItems.label = Config.Locations[shop]["label"]
                        ShopItems.items = Config.Locations[shop]["products"]
                        ShopItems.slots = #Config.Locations[shop]["products"]
                        TriggerServerEvent("inventory:server:OpenInventory", "shop", "Itemshop_"..shop, ShopItems)
                    end
                end
            end
        end
    end
end)

RegisterNetEvent('qb-shops:client:UpdateShop')
AddEventHandler('qb-shops:client:UpdateShop', function(shop, itemData, amount)
    TriggerServerEvent('qb-shops:server:UpdateShopItems', shop, itemData, amount)
end)

RegisterNetEvent('qb-shops:client:SetShopItems')
AddEventHandler('qb-shops:client:SetShopItems', function(shop, shopProducts)
    Config.Locations[shop]["products"] = shopProducts
end)

RegisterNetEvent('qb-shops:client:RestockShopItems')
AddEventHandler('qb-shops:client:RestockShopItems', function(shop, amount)
    if Config.Locations[shop]["products"] ~= nil then 
        for k, v in pairs(Config.Locations[shop]["products"]) do 
            Config.Locations[shop]["products"][k].amount = Config.Locations[shop]["products"][k].amount + amount
        end
    end
end)

Citizen.CreateThread(function()
    for store,data in pairs(Config.Locations) do
        for i=1, #data.coords do
            -- exports["elixir-base"]:addNotif("E", data["label"], 2, 2, vector3(data.coords[i].x, data.coords[i].y, data.coords[i].z))
            exports["elixir-base"]:pedcreate("qb-shops-"..store.."-"..i, data.pedHash, data.coords[i].x, data.coords[i].y, data.coords[i].z - 1, data.coords[i].h)
            exports['qb-target']:AddTargetModel(data.pedHash, {
                options = {
                    {
                        type = "client",
                        event = "shops:ac",
                        icon = "fas fa-shopping-basket",
                        label = data["label"],
                    },
                },
                distance = 2,
            })
        end

        if data["blip"] then
            for i=1, #Config.Locations[store]["coords"] do
                local StoreBlip = AddBlipForCoord(Config.Locations[store]["coords"][i]["x"], Config.Locations[store]["coords"][i]["y"], Config.Locations[store]["coords"][i]["z"])

                SetBlipColour(StoreBlip, data["blip"]["colour"])
                SetBlipSprite(StoreBlip, data["blip"]["sprite"])
                SetBlipScale(StoreBlip, data["blip"]["scale"])
                
                SetBlipDisplay(StoreBlip, 4)
                SetBlipAsShortRange(StoreBlip, true)

                BeginTextCommandSetBlipName("STRING")
                AddTextComponentSubstringPlayerName(Config.Locations[store]["label"])
                EndTextCommandSetBlipName(StoreBlip)
            end
        end

    end
end)

local blip = false
local weaponShopBlip = {}
RegisterNetEvent("esx_weaponshop:blipAcKapa")
AddEventHandler("esx_weaponshop:blipAcKapa", function()
	if blip then
		pasifblip()
		blip = false
	else
		aktifblip()
		blip = true
	end
end)

function aktifblip()
    for k,location in pairs(Config.Locations["Weapons"]["coords"]) do
        local blip = AddBlipForCoord(location.x, location.y, location.z)
        SetBlipSprite (blip, 110)
        SetBlipDisplay(blip, 4)
        SetBlipScale  (blip, 0.5)
        SetBlipColour (blip, 81)
        SetBlipAsShortRange(blip, true)

        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName("Weapon Shop")
        EndTextCommandSetBlipName(blip)
        table.insert(weaponShopBlip, blip)
	end		
end

function pasifblip()
	for i = 1, #weaponShopBlip do
		RemoveBlip(weaponShopBlip[i])
	end
	weaponShopBlip = {}
end

RegisterNetEvent("blackmarket")
AddEventHandler("blackmarket", function()
    if GetClockHours() > 21 or GetClockHours() < 8 then
        TriggerServerEvent("inventory:server:OpenInventory", "shop", "karadayi", Karadayi)
    end
end)

Karadayi = {
    label = "Uncle Black",
    slots = 40,
    items = {    
        {
            name = "lowgrademaleseed",
            amount = 1,
            type = "item",
            slot = 1,
            price = 200,
        },
        {
            name = "lowgradefemaleseed",
            amount = 1,
            type = "item",
            slot = 2,
            price = 600,
        },
        {
            name = "lockpick3",
            amount = 1,
            type = "item",
            slot = 3,
            price = 150,
        },
        {
            name = "weapon_shiv",
            amount = 1,
            type = "weapon",
            slot = 4,
            price = 500,
        },
        {
            name = "hydrochloric_acid",
            amount = 1,
            type = "item",
            slot = 5,
            price = 300,
        },
        {
            name = "sodium_hydroxide",
            amount = 1,
            type = "item",
            slot = 6,
            price = 250,
        },
        {
            name = "sulfuric_acid",
            amount = 1,
            type = "item",
            slot = 7,
            price = 200,
        },
        {
            name = "methkey",
            amount = 1,
            type = "item",
            slot = 8,
            price = 350,
        },
        {
            name = "poset",
            amount = 5,
            type = "item",
            slot = 9,
            price = 5,
        },
        {
            name = "lowgradefert",
            amount = 5,
            type = "item",
            slot =10,
            price = 100,
        },
        {
            name = "finescale",
            amount = 5,
            type = "item",
            slot =11,
            price = 200,
        },  
        {        
            name = "aseton",
            amount = 5,
            type = "item",
            slot =12,
            price = 20,
         },  
         {        
            name = "bakingsoda",
            amount = 5,
            type = "item",
            slot =13,
            price = 15,
         }, 
         {        
            name = "thionyl_chloride",
            amount = 5,
            type = "item",
            slot =14,
            price = 100,
         },        
    }
}


    exports['qb-target']:AddBoxZone("karadayi", vector3(3310.76, 5176.32, 19.61), 0.6, 0.8, {
        heading=233.2,
        debugPoly = false,
        minZ=18.0,
        maxZ=20.66
    }, {
        options = {
            {
                type = "client",
                event = "blackmarket",
                icon = "fas fa-comment",
                label = "Talk to Uncle",
            },
        },
        job = {"all"},
        distance = 2.2
    })

local gececikacaklar = {
    ["31"] = {
        spawned = false,
        pedmodel = 0x6C19E962,
        konum = { 
            x = 3310.76,  
            y =  5176.3,
            z = 19.61,
            h = 233.99952697754
        },
    },
}


Citizen.CreateThread(function()
    while true do
        local sleep = 1000
        if GetClockHours() > 21 or GetClockHours() < 8 then
            for k, value in pairs(gececikacaklar) do
                if not value.spawned then
                    value.spawned = true

                    exports["elixir-base"]:pedcreate("otuzbir-" .. k, value.pedmodel, value.konum.x, value.konum.y,
                    value.konum.z - 1, value.konum.h, value.dict, value.anim)

                end
            end
        else
            for k, v in pairs(gececikacaklar) do
                if v.spawned then
                    v.spawned = false
                    exports["elixir-base"]:peddelete("otuzbir-" .. k, v.pedmodel, v.konum.x, v.konum.y,
                    v.konum.z - 1, v.konum.h, v.dict, v.anim)
                end
            end
        end

        Wait(sleep)
    end
end)
