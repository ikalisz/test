QBCore = nil
coreLoaded = false
PlayerData = {}

local girilenDepo = ""
local depolar = {
    ["depo-1"] = vector3(-318.01306152344, -1349.8723144531, 24.904268264771),
    ["depo-2"] = vector3(156.60992431641, -1701.3039550781, 22.80224609375),
    ["depo-3"] = vector3(-1258.1221923828, -1115.8336181641, 1.3839250802994),
    ["depo-4"] = vector3(586.95825195312, -418.28936767578, 18.218395233154),
    ["depo-5"] = vector3(933.4375, -1483.9365234375, 23.641704559326),
    ["depo-6"] = vector3(-1983.4993896484, -232.97116088867, 28.458934783936),
    ["depo-7"] = vector3(-56.872539520264, -1296.3093261719, 24.386636734009),
    ["depo-8"] = vector3(792.0439453125, -94.09700012207, 75.514602661133),
    ["depo-9"] = vector3(-156.42451477051, 6301.5263671875, 25.16583442688),
    ["depo-10"] = vector3(-28.770761489868, 6459.5268554688, 24.930545806885),
    ["depo-11"] = vector3(1393.3786621094, -2080.7553710938, 46.093948364258),
    ["depo-12"] = vector3(2852.828125, 4458.3232421875, 41.916942596436),
    ["depo-13"] = vector3(550.38427734375, 2671.3640136719, 35.639636993408),
    ["depo-14"] = vector3(2530.154296875, 4127.2802734375, 32.061946868896),
    ["depo-15"] = vector3(441.22613525391, -1981.5428466797, 17.879531860352),
    ["depo-16"] = vector3(969.8582, 3613.496, 32.733),
}

Citizen.CreateThread(function()
    while QBCore == nil do
        TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)
        Citizen.Wait(200)
    end
    coreLoaded = true
    TriggerServerEvent("tgiann-dg:durum")
    PlayerData = QBCore.Functions.GetPlayerData()
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    PlayerData = QBCore.Functions.GetPlayerData()
end)

RegisterNetEvent('tgiann-dg:depo-guncelle')
AddEventHandler('tgiann-dg:depo-guncelle', function(yeniDepoData)
    depoData = yeniDepoData
    for depo, coords in pairs(depolar) do
        seviyeAyarla(depoData[depo]["tip"], depoData[depo]["seviye"], coords, depoData[depo]["buyume-aktif"], depoData[depo]["buyume-seviye"])
    end
end)

Citizen.CreateThread(function()
    Citizen.CreateThread(function()
        while true do
            local time = 1000
            if coreLoaded then
                local playerPed = PlayerPedId()
                local playerCoords = GetEntityCoords(playerPed)
                for depo, coords in pairs(depolar) do
                    local mesafe = #(coords - playerCoords) 
                    if mesafe < 30 then
                        time = 1
                        DrawMarker(2, coords.x, coords.y, coords.z-0.65, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.4, 0.4, 0.3, 255, 00, 0, 200, false, true, false, false, false, false, false)
                        if mesafe < 3 then
                            yazi = ""
                            if mesafe < 1 then
                                yazi = "[E] "
                                if IsControlJustReleased(0, 38) then
                                    depoIslemleri()
                                end
                            end
                            QBCore.Functions.DrawText3D(coords.x, coords.y, coords.z-0.35, yazi.."Warehouse Operations")
                        end
                        girilenDepo = depo
                    end
                end
            end
            Citizen.Wait(time)
        end
    end)
end)

function depoIslemleri()
    if depoData[girilenDepo]["satinAlindi"] then
        if depoData[girilenDepo]["depoSahibi"] == PlayerData.citizenid then
            if depoData[girilenDepo]["seviye"] == "" then -- Hiç Bir Şey Ekili Değil
                QBCore.UI.Menu.Open('default', GetCurrentResourceName(), 'depoIslemeleri', {
                    title    = 'Warehouse Operations',
                    align    = 'left',
                    elements = {
                        {label = "Wrap Grass", value = "sarma_ot"},
                        {label = "Generate Doping", value = "doping"},
                        {label = "Generate ABC", value = "abc"},
                        {label = "Clear Money", value = "money"},
                    }
                }, function(data, menu)
                    QBCore.Functions.TriggerCallback("tgiann-dg:malzeme-kontrol", function(result)
                        if result then
                            seviyeAyarla(depoData[girilenDepo]["tip"], "seviye-1", depolar[girilenDepo])
                        end
                    end, data.current.value, "seviye-1", girilenDepo) 
                    menu.close()
                end,function(data, menu)
                    menu.close()
                end)
            elseif depoData[girilenDepo]["seviye"] == "seviye-1" and (depoData[girilenDepo]["tip"] == "doping" or depoData[girilenDepo]["tip"] == "sarma_ot") then -- Seviye 1
                local menuYazi = ""
                if depoData[girilenDepo]["tip"] == "sarma_ot" then -- Seviye 1 sarma_ot Saksı ekme vs
                    menuYazi = "Place Pots and Seeds"
                elseif depoData[girilenDepo]["tip"] == "doping" then -- Seviye 1 doping Saksı ekme vs 
                    menuYazi = "Place Extra Materials"
                end
                QBCore.UI.Menu.Open('default', GetCurrentResourceName(), 'depoIslemeleri', {
                    title    = 'Warehouse Operations',
                    align    = 'left',
                    elements = {
                        {label = menuYazi},
                    }
                }, function(data, menu)
                    QBCore.Functions.TriggerCallback("tgiann-dg:malzeme-kontrol", function(result)
                        if result then
                            seviyeAyarla(depoData[girilenDepo]["tip"], "seviye-2", depolar[girilenDepo])
                        end
                    end, depoData[girilenDepo]["tip"], "seviye-2", girilenDepo) 
                    menu.close()
                end,function(data, menu)
                    menu.close()
                end)
            elseif depoData[girilenDepo]["seviye"] == "seviye-1" and (depoData[girilenDepo]["tip"] == "abc" or depoData[girilenDepo]["tip"] == "money") then
                if depoData[girilenDepo]["tip"] == "abc" then -- abc Yetişme aşaması
                    if depoData[girilenDepo]["buyume-aktif"] then -- abc Yetiştirme Aşama Kontrol
                        if depoData[girilenDepo]["buyume-seviye"] == 6 then
                            TriggerServerEvent("tgiann-dg:son-asama", "curudu", girilenDepo)
                            QBCore.Functions.Notify("Üretilen Malzeme Doesn't Work Anymore", "error")
                        elseif depoData[girilenDepo]["buyume-seviye"] >= 4 then 
                            TriggerServerEvent("tgiann-dg:son-asama", "topla", girilenDepo)
                            QBCore.Functions.Notify("Produced Material Collected", "success")
                        else
                            QBCore.Functions.Notify("Material Still Produced(Stage "..depoData[girilenDepo]["buyume-seviye"]..")", "error")
                        end
                    end
                elseif depoData[girilenDepo]["tip"] == "money" then -- para Yetişme aşaması
                    if depoData[girilenDepo]["buyume-aktif"] then -- para Yetiştirme Aşama Kontrol
                        if depoData[girilenDepo]["buyume-seviye"] == 4 then
                            TriggerServerEvent("tgiann-dg:son-asama", "curudu", girilenDepo)
                            QBCore.Functions.Notify("Printed Money Burned!", "error")
                        elseif depoData[girilenDepo]["buyume-seviye"] >= 2 then 
                            TriggerServerEvent("tgiann-dg:son-asama", "topla", girilenDepo)
                            QBCore.Functions.Notify("Minted Money Collected", "success")
                        else
                            QBCore.Functions.Notify("Money Still Printing(Stage "..depoData[girilenDepo]["buyume-seviye"]..")", "error")
                        end
                    end
                end

            elseif depoData[girilenDepo]["seviye"] == "seviye-2" then
                if depoData[girilenDepo]["tip"] == "sarma_ot" then -- sarma_ot Yetişme aşaması
                    if depoData[girilenDepo]["buyume-aktif"] then -- sarma_ot Yetiştirme Aşama Kontrol
                        if depoData[girilenDepo]["buyume-seviye"] == 10 then
                            TriggerServerEvent("tgiann-dg:son-asama", "curudu", girilenDepo)
                            QBCore.Functions.Notify("Crop Grown Decayed", "error")
                        elseif depoData[girilenDepo]["buyume-seviye"] >= 8 then 
                            TriggerServerEvent("tgiann-dg:son-asama", "topla", girilenDepo)
                            QBCore.Functions.Notify("Grown Product Collected", "success")
                        else
                            QBCore.Functions.Notify("Crop Still Growing(Stage "..depoData[girilenDepo]["buyume-seviye"]..")", "error")
                        end
                    end
                elseif depoData[girilenDepo]["tip"] == "doping" then -- doping Yetişme aşaması
                    if depoData[girilenDepo]["buyume-aktif"] then -- doping Yetiştirme Aşama Kontrol
                        if depoData[girilenDepo]["buyume-seviye"] == 10 then
                            TriggerServerEvent("tgiann-dg:son-asama", "curudu", girilenDepo)
                            QBCore.Functions.Notify("Produced Product No Longer Working", "error")
                        elseif depoData[girilenDepo]["buyume-seviye"] >= 8 then 
                            TriggerServerEvent("tgiann-dg:son-asama", "topla", girilenDepo)
                            QBCore.Functions.Notify("Produced Product Collected", "success")
                        else
                            QBCore.Functions.Notify("Product Still in Production(Stage "..depoData[girilenDepo]["buyume-seviye"]..")", "error")
                        end
                    end
                end
            end
        else
            QBCore.Functions.Notify("This Warehouse Belongs to Someone Else", "error")
        end
    else
        QBCore.UI.Menu.Open('default', GetCurrentResourceName(), 'depoSoruMenu', {
            title    = 'Rent the Warehouse for 24 Hours (X20 Item)',
            align    = 'left',
            elements = {
                {label = "Cancel", value = "no"},
                {label = "Rent", value = "yes"},
            }
        }, function(data, menu)
            if data.current.value == "yes" then
                TriggerServerEvent("tgiann-dg:satin-al", girilenDepo)
                QBCore.Functions.Notify("Warehouse Rented!", "success")
            end
            menu.close()
        end,function(data, menu)
            menu.close()
        end)
    end
end

function seviyeAyarla(tip, seviye, coords, buyumeAktif, buyumeSeviye)
    local interiorHash = GetInteriorAtCoords(coords)
    clearInterior(interiorHash)
    if tip == "sarma_ot" then
        if seviye == "seviye-1" then
            otSeviyeBir(interiorHash)
        elseif seviye == "seviye-2" then
            otSeviyeBir(interiorHash)
            EnableInteriorProp(interiorHash, "weed_plant_v1")
        end

        if buyumeAktif then
            if buyumeSeviye == 2 then
                EnableInteriorProp(interiorHash, "weed_plant_v2")
            elseif buyumeSeviye == 3 then
                EnableInteriorProp(interiorHash, "weed_plant_v3")
            elseif buyumeSeviye == 4 then
                EnableInteriorProp(interiorHash, "weed_plant_v4")
            elseif buyumeSeviye == 5 then
                EnableInteriorProp(interiorHash, "weed_plant_v5")
            elseif buyumeSeviye == 6 then
                EnableInteriorProp(interiorHash, "weed_plant_v6")
            elseif buyumeSeviye == 7 then
                EnableInteriorProp(interiorHash, "weed_plant_v7")
            elseif buyumeSeviye >= 8 and buyumeSeviye < 10 then
                EnableInteriorProp(interiorHash, "weed_plant_v8")
            elseif buyumeSeviye == 10 then -- Çürüme
                EnableInteriorProp(interiorHash, "weed_plant_v9")
            end
        end
    elseif tip == "doping" then
        if seviye == "seviye-1" then
            EnableInteriorProp(interiorHash, "light_stock")
            EnableInteriorProp(interiorHash, "meth_app")
            EnableInteriorProp(interiorHash, "meth_staff_01")
            EnableInteriorProp(interiorHash, "meth_staff_02")
            EnableInteriorProp(interiorHash, "meth_basic_lab_01")
            EnableInteriorProp(interiorHash, "meth_basic_lab_02")
            EnableInteriorProp(interiorHash, "meth_basic_lab_01_2")
            EnableInteriorProp(interiorHash, "meth_basic_lab_02_2")
            EnableInteriorProp(interiorHash, "meth_stock")
        elseif seviye == "seviye-2" then
            EnableInteriorProp(interiorHash, "light_stock")
            EnableInteriorProp(interiorHash, "meth_app")
            EnableInteriorProp(interiorHash, "meth_staff_01")
            EnableInteriorProp(interiorHash, "meth_staff_02")
            EnableInteriorProp(interiorHash, "meth_update_lab_01")
            EnableInteriorProp(interiorHash, "meth_update_lab_02")
            EnableInteriorProp(interiorHash, "meth_update_lab_01_2")
            EnableInteriorProp(interiorHash, "meth_update_lab_02_2")
            EnableInteriorProp(interiorHash, "meth_stock")
        end
    elseif tip == "abc" then
        if seviye == "seviye-1" then
            EnableInteriorProp(interiorHash, "coke_app")
            EnableInteriorProp(interiorHash, "coke_staff_01")
            EnableInteriorProp(interiorHash, "coke_staff_02")
            EnableInteriorProp(interiorHash, "coke_stock")
        end

    elseif tip == "money" then
        if seviye == "seviye-1" then
            EnableInteriorProp(interiorHash, "light_stock")
            EnableInteriorProp(interiorHash, "money_app")
            EnableInteriorProp(interiorHash, "money_stock")
            EnableInteriorProp(interiorHash, "money_staff_02")
        end

    end
end

function otSeviyeBir(interiorHash)
    EnableInteriorProp(interiorHash, "weed_app")
    EnableInteriorProp(interiorHash, "weed_staff_01")
    EnableInteriorProp(interiorHash, "weed_staff_02")
    EnableInteriorProp(interiorHash, "weed_update_lamp")
    EnableInteriorProp(interiorHash, "weed_fan_update")
    EnableInteriorProp(interiorHash, "weed_stock")
end

function clearInterior(interiorHash)
    RefreshInterior(interiorHash)
    DisableInteriorProp(interiorHash, "light_stock")
    DisableInteriorProp(interiorHash, "meth_app")
    DisableInteriorProp(interiorHash, "meth_staff_01")
    DisableInteriorProp(interiorHash, "meth_staff_02")
    DisableInteriorProp(interiorHash, "meth_basic_lab_01")
    DisableInteriorProp(interiorHash, "meth_basic_lab_02")
    DisableInteriorProp(interiorHash, "meth_basic_lab_01_2")
    DisableInteriorProp(interiorHash, "meth_basic_lab_02_2")
    DisableInteriorProp(interiorHash, "meth_stock")

    DisableInteriorProp(interiorHash, "light_stock")
    DisableInteriorProp(interiorHash, "meth_app")
    DisableInteriorProp(interiorHash, "meth_staff_01")
    DisableInteriorProp(interiorHash, "meth_staff_02")
    DisableInteriorProp(interiorHash, "meth_update_lab_01")
    DisableInteriorProp(interiorHash, "meth_update_lab_02")
    DisableInteriorProp(interiorHash, "meth_update_lab_01_2")
    DisableInteriorProp(interiorHash, "meth_update_lab_02_2")
    DisableInteriorProp(interiorHash, "meth_stock")

    DisableInteriorProp(interiorHash, "weed_app")
    DisableInteriorProp(interiorHash, "weed_staff_01")
    DisableInteriorProp(interiorHash, "weed_staff_02")
    DisableInteriorProp(interiorHash, "weed_basic_lamp")
    DisableInteriorProp(interiorHash, "weed_fan_basick")
    DisableInteriorProp(interiorHash, "weed_stock")

    DisableInteriorProp(interiorHash, "weed_app")
    DisableInteriorProp(interiorHash, "weed_staff_01")
    DisableInteriorProp(interiorHash, "weed_staff_02")
    DisableInteriorProp(interiorHash, "weed_update_lamp")
    DisableInteriorProp(interiorHash, "weed_fan_update")
    DisableInteriorProp(interiorHash, "weed_stock")

    DisableInteriorProp(interiorHash, "weed_plant_v1")

    DisableInteriorProp(interiorHash, "weed_plant_v2")

    DisableInteriorProp(interiorHash, "weed_plant_v3")

    DisableInteriorProp(interiorHash, "weed_plant_v4")

    DisableInteriorProp(interiorHash, "weed_plant_v5")

    DisableInteriorProp(interiorHash, "weed_plant_v6")

    DisableInteriorProp(interiorHash, "weed_plant_v7")

    DisableInteriorProp(interiorHash, "weed_plant_v8")

    DisableInteriorProp(interiorHash, "weed_plant_v9")

    DisableInteriorProp(interiorHash, "coke_app")
    DisableInteriorProp(interiorHash, "coke_staff_01")
    DisableInteriorProp(interiorHash, "coke_staff_02")
    DisableInteriorProp(interiorHash, "coke_stock")

    DisableInteriorProp(interiorHash, "light_stock")
    DisableInteriorProp(interiorHash, "money_app")
    DisableInteriorProp(interiorHash, "money_staff_01")
    DisableInteriorProp(interiorHash, "money_stock")

    DisableInteriorProp(interiorHash, "money_staff_01")
    DisableInteriorProp(interiorHash, "money_staff_02")

    DisableInteriorProp(interiorHash, "light_stock")
    DisableInteriorProp(interiorHash, "weapon_app")
    DisableInteriorProp(interiorHash, "weapon_staff_01")
    DisableInteriorProp(interiorHash, "weapon_stock")
end

AddEventHandler('onResourceStop', function(resourceName)
    if (GetCurrentResourceName() == resourceName) then
        QBCore.UI.Menu.CloseAll()
    end
end)