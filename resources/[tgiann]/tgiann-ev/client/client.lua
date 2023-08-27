QBCore = nil
coreLoaded = false

local evim = nil
local evBlip = nil
local evBenim = false
-- local rastgeleEvsizEv = nil
local anahtarNo = ""

Citizen.CreateThread(function()
    while QBCore == nil do
        TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)
        Citizen.Wait(200)
    end
    coreLoaded = true
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    firstLogin()
end)

RegisterCommand("tgiannevload", function()
    firstLogin()
end)

function firstLogin()
    PlayerData = QBCore.Functions.GetPlayerData()
    TriggerEvent("tgiann-ev:ev-ayarla")
end

RegisterNetEvent('tgiann-ev:ev-ayarla')
AddEventHandler('tgiann-ev:ev-ayarla', function()
    QBCore.Functions.TriggerCallback("tgiann-ev:ilg-giris", function(evData)
        evBenim = false
        evim = nil
        rastgeleEvsizEv = nil
        if evData == nil then return end
        if evData then
            evim = evData.id
            for x,y in pairs(evData) do
                if x ~= id then
                    if y == PlayerData.citizenid then
                        anahtarNo = x
                        if anahtarNo == "anahtar1" then
                            evBenim = true
                        end
                        break
                    end
                end
            end
            evBlipYarat(evler[evim]["coord"]["depo"], "Evin", 40, 3)
        else
            -- rastgeleEvsizEv = evsizKonumlar[math.random(1, #evsizKonumlar)]
            -- evBlipYarat(rastgeleEvsizEv, "Çadırın", 587, 10)
        end
    end)
end)

function evBlipYarat(coord, yazi, sprite, renk)
    if evBlip then RemoveBlip(evBlip) end
    evBlip = AddBlipForCoord(coord)
    SetBlipSprite(evBlip, sprite)
    SetBlipColour(evBlip, renk)
    SetBlipAsShortRange(evBlip, true)
    SetBlipScale(evBlip, 0.7)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(yazi)
    EndTextCommandSetBlipName(evBlip)
end

RegisterNetEvent('QBCore:Client:OnJobUpdate')
AddEventHandler('QBCore:Client:OnJobUpdate', function(job)
    PlayerData.job = job
end)

local satinAlNokta = vector3(-479.36, 218.03, 84.5)
local markerYazi = {
    ["kapi"] = "Door",
    ["depo"] = "Depo",
    ["kiyafet"] = "Change Clothes",
}

Citizen.CreateThread(function()
    local DepoEv = AddBlipForCoord(vector3(satinAlNokta["x"], satinAlNokta["y"], satinAlNokta["z"]))
    SetBlipSprite(DepoEv, 375)
    SetBlipColour(DepoEv, 2)
    SetBlipAsShortRange(DepoEv, true)
    SetBlipScale(DepoEv, 0.5)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Home Sales Office")
    EndTextCommandSetBlipName(DepoEv)

    while true do
        local time = 1000
        local playerPed = PlayerPedId()
        local playerCoord = GetEntityCoords(playerPed)
        if coreLoaded then
            if evim then
                local evData = evler[evim]
                if #(playerCoord - evData.coord.depo) < 100 then
                    for tip, coord in pairs(evData.coord) do
                        local yaziMesafe = #(playerCoord - coord)
                        if yaziMesafe < 30 then
                            time = 1
                            DrawMarker(2, coord.x, coord.y, coord.z-0.65, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.4, 0.4, 0.3, 255, 00, 0, 200, false, true, false, false, false, false, false)
                            if yaziMesafe < 3 then
                                local yazi = ""
                                if yaziMesafe < 1 then
                                    yazi = "[E] "
                                    if IsControlJustReleased(0, 38) then
                                        TriggerEvent("tgiann-ev:e", tip)
                                    end
                                end
                                QBCore.Functions.DrawText3D(coord.x, coord.y, coord.z-0.35, yazi..markerYazi[tip])
                            end
                        end
                    end

                    for kapiNo, coord in pairs(evData.kapilar) do
                        local yaziMesafe = #(playerCoord - coord)
                        -- if yaziMesafe < 3 then
                        --     time = 1
                        --     local kapiData = exports["tgiann-kapikilit"]:kapidurum(kapiNo)
                        --     if kapiData then
                        --         local yazi = ""
                        --         if yaziMesafe < 1 then
                        --             yazi = "[E] "
                        --             if IsControlJustReleased(0, 38) then
                        --                 TriggerEvent("esx_doorlock:ev-kapi", kapiNo)
                        --             end
                        --         end
                            
                        --         QBCore.Functions.DrawText3D(kapiData.coord.x, kapiData.coord.y, kapiData.coord.z, yazi..kapiData.durum)
                        --     else
                        --         print("[TGIANN-EV] Kapi Data Yok!")
                        --     end
                        -- end
                    end
                end
            else
                if rastgeleEvsizEv then
                    local yaziMesafe = #(playerCoord - rastgeleEvsizEv)
                    if yaziMesafe < 20 then
                        time = 1
                        DrawMarker(2, rastgeleEvsizEv.x, rastgeleEvsizEv.y, rastgeleEvsizEv.z-0.65, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.4, 0.4, 0.3, 110, 55, 0, 200, false, true, false, false, false, false, false)
                        if yaziMesafe < 3 then
                            local yazi = ""
                            if yaziMesafe < 1 then
                                yazi = "[E] "
                                if IsControlJustReleased(0, 38) then
                                    TriggerEvent("inventory:client:SetCurrentStash", "motel_"..PlayerData.citizenid, QBCore.Key)
                                    TriggerServerEvent("inventory:server:OpenInventory", "stash", "motel_"..PlayerData.citizenid, {
                                        maxweight = 500000,
                                        slots = 5,
                                    })
                                end
                            end
                            -- QBCore.Functions.DrawText3D(rastgeleEvsizEv.x, rastgeleEvsizEv.y, rastgeleEvsizEv.z-0.35, yazi.."Çadır")
                        end
                    end
                end
            end

            local yaziMesafe = #(playerCoord - satinAlNokta)
            if yaziMesafe < 22 then
                time = 1
                DrawMarker(29, satinAlNokta.x, satinAlNokta.y, satinAlNokta.z-0.65, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.4, 0.4, 0.3, 255, 00, 0, 200, false, true, false, false, false, false, false)
                if yaziMesafe < 3 then
                    if yaziMesafe < 1 then
                        yazi = "[E] "
                        if IsControlJustReleased(0, 38) then
                            menuAc()
                        end
                    end
                    QBCore.Functions.DrawText3D(satinAlNokta.x, satinAlNokta.y, satinAlNokta.z-0.35, "[E] Buy Home")
                end
            end

        end
        Citizen.Wait(time)
    end
end)

RegisterNetEvent('tgiann-ev:e')
AddEventHandler('tgiann-ev:e', function(tip)
    if tip == "depo" then
        TriggerEvent("inventory:client:SetCurrentStash", "TEv_"..tostring(evim), QBCore.Key)
        TriggerServerEvent("inventory:server:OpenInventory", "stash", "TEv_"..tostring(evim), {
            maxweight = 4000000,
            slots = 500,
        })
    elseif tip == "kiyafet" then
        TriggerEvent("qb-clothing:client:openOutfitMenu", "ev")
    end
end)

function menuAc()
    if evim then
        evimMenu()
    else
        satilikEvler()
    end
end

function satilikEvler()
    local elements = {}
    for i=1, #evler do
        table.insert(elements, {label = evler[i].isim.."("..i..") $"..evler[i].fiyat, value = i, fiyat = evler[i].fiyat})
    end
    QBCore.UI.Menu.Open('default', GetCurrentResourceName(), 'evSatinAlMenu', {
        title    = 'Homes For Sale',
        align    = 'left',
        elements = elements
    }, function(data2, menu2)
        if data2.current.value then
            -- Soru Menu
            QBCore.UI.Menu.Open('default', GetCurrentResourceName(), 'evSoruMenu', {
                title    = 'Are You Sure You Want To Buy? <div style="font-size:18px; padding-bottom:5px">(You Will Never Use Your Current Tent!!!)</div>',
                align    = 'left',
                elements = {
                    {label = "No", value = "no"},
                    {label = "Yes", value = "yes"},
                }
            }, function(data3, menu3)
                if data3.current.value == "yes" then
                    TriggerServerEvent("tgiann-ev:satin-al", data2.current.value, data2.current.fiyat)
                    QBCore.UI.Menu.CloseAll()
                else
                    menu3.close()
                end
            end,function(data3, menu3)
                menu3.close()
            end)

        end
    end,function(data2, menu2)
        menu2.close()
    end)
end

function evimMenu()
    if evBenim then
        local evSatFiyat = evler[evim].fiyat * 0.5
        QBCore.UI.Menu.Open('default', GetCurrentResourceName(), 'evimMenu', {
            title    = 'My home',
            align    = 'left',
            elements = {
                {label = "Change Key", value = "anahtar"},
                {label = "Give Key to Someone Near You", value = "ver"},
                {label = "Sell ​the House $"..evSatFiyat, value = "sat", fiyat = evSatFiyat},
            }
        }, function(data, menu)
            if data.current.value == "anahtar" then
                -- Anahtar Sıfırlama
                QBCore.UI.Menu.Open('default', GetCurrentResourceName(), 'evSatSoruMenu', {
                    title    = 'Are You Sure You Want To Change Your House Key??',
                    align    = 'left',
                    elements = {
                        {label = "No", value = "no"},
                        {label = "Yes", value = "yes"},
                    }
                }, function(data2, menu2)
                    if data2.current.value == "yes" then
                        TriggerServerEvent("tgiann-ev:anahtar-degis", evim, QBCore.Key)
                    end
                    menu2.close()
                end,function(data2, menu2)
                    menu2.close()
                end)

            elseif data.current.value == "ver" then
                local player, distance = QBCore.Functions.GetClosestPlayer()
                if distance ~= -1 and distance <= 3.0 then
                    TriggerServerEvent("tgiann-ev:anahtar-ver", GetPlayerServerId(player), evim, QBCore.Key)
                else
                    QBCore.Functions.Notify("No One Nearby", "error")
                end

            elseif data.current.value == "sat" then
                -- Ev Sat Soru Menu
                QBCore.UI.Menu.Open('default', GetCurrentResourceName(), 'evSatSoruMenu', {
                    title    = 'Are you sure you want to sell your house?',
                    align    = 'left',
                    elements = {
                        {label = "No", value = "no"},
                        {label = "Yes", value = "yes"},
                    }
                }, function(data2, menu2)
                    if data2.current.value == "yes" then
                        TriggerServerEvent("tgiann-ev:sat", data.current.fiyat, evim, QBCore.Key)
                        TriggerEvent("tgiann-ev:sifirla")
                        QBCore.UI.Menu.CloseAll()
                    else
                        menu2.close()
                    end
                end,function(data2, menu2)
                    menu2.close()
                end)
            end
        end,function(data, menu)
            menu.close()
        end)
    else
        QBCore.UI.Menu.Open('default', GetCurrentResourceName(), 'tgiannnahtarBirak', {
            title    = 'My Home',
            align    = 'left',
            elements = {{label = "Leave the House Key", value = "abirak"}}
        }, function(data, menu)
            if data.current.value then
                -- Soru Menu
                QBCore.UI.Menu.Open('default', GetCurrentResourceName(), 'evSoruMenu', {
                    title    = 'Are You Sure You Want To Leave The Key Of The House You Own?',
                    align    = 'left',
                    elements = {
                        {label = "No", value = "no"},
                        {label = "Yes", value = "yes"},
                    }
                }, function(data2, menu2)
                    if data2.current.value == "yes" then
                        TriggerServerEvent("tgiann-ev:anahtar-birak", evim, anahtarNo)
                        QBCore.UI.Menu.CloseAll()
                    else
                        menu2.close()
                    end
                end,function(data2, menu2)
                    menu2.close()
                end)
    
            end
        end,function(data, menu)
            menu.close()
        end)
    end
end

local goster = false
local blips = {}
RegisterCommand("houses", function()
    satilanEvler()
end)

function satilanEvler()
    if not goster then
        for k, v in pairs(evler) do
            CreateBlip(v['coord']["depo"], 374, 0, 0.45, '')
        end
        QBCore.Functions.Notify('Houses Opened on the Map')
    else
        for k, v in pairs(blips) do
            RemoveBlip(v)
        end
        blips = {}
        QBCore.Functions.Notify('Houses Closed on the Map')
    end
    goster = not goster
end

function CreateBlip(coords, sprite, colour, scale, text)
    local blip = AddBlipForCoord(coords)
    SetBlipSprite(blip, sprite)
    SetBlipColour(blip, colour)
    SetBlipAsShortRange(blip, true)
    SetBlipScale(blip, scale)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(text)
    EndTextCommandSetBlipName(blip)
    table.insert(blips, blip)
end

RegisterNetEvent('tgiann-ev:sifirla')
AddEventHandler('tgiann-ev:sifirla', function()
    -- rastgeleEvsizEv = evsizKonumlar[math.random(1, #evsizKonumlar)]
    -- evBlipYarat(rastgeleEvsizEv, "Çadırın", 587, 10)
    evim = nil
end)

local cadirbolge1 = PolyZone:Create({
    vector2(184.05780029297, -1191.8176269531),
    vector2(185.63987731934, -1235.0103759766),
    vector2(151.58462524414, -1227.5280761719),
    vector2(144.25149536133, -1230.9525146484),
    vector2(141.64547729492, -1236.6441650391),
    vector2(119.87334442139, -1237.0325927734),
    vector2(120.20207214355, -1178.7797851562),
    vector2(140.26713562012, -1176.92578125),
    vector2(183.10484313965, -1184.5518798828)
}, {
    name="cadirbolge1",
    minZ = 28.198457717896,
    maxZ = 33.593721389771
})

local cadirbolge2 = PolyZone:Create({
    vector2(385.47064208984, -1107.3502197266),
    vector2(385.30606079102, -1113.9938964844),
    vector2(383.81256103516, -1117.9207763672),
    vector2(380.03729248047, -1119.9255371094),
    vector2(340.28967285156, -1119.3112792969),
    vector2(334.84808349609, -1101.6896972656),
    vector2(334.55828857422, -1073.7935791016),
    vector2(342.78128051758, -1074.064453125),
    vector2(343.63851928711, -1091.5843505859),
    vector2(350.04385375977, -1091.4818115234),
    vector2(349.83822631836, -1107.4119873047)
}, {
    name="cadirbolge2",
    minZ = 28.361854553223,
    maxZ = 32.587312698364
})

local cadirbolge3 = PolyZone:Create({
    vector2(450.58193969727, -871.49481201172),
    vector2(450.12652587891, -836.8896484375),
    vector2(487.94061279297, -835.89373779297),
    vector2(488.16018676758, -870.45446777344)
}, {
    name="cadirbolge3",
    minZ = 24.078262329102,
    maxZ = 30.905048370361
})

exports("cadirRaid", function(citizenid)
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    if cadirbolge1:isPointInside(playerCoords) or cadirbolge2:isPointInside(playerCoords) or cadirbolge3:isPointInside(playerCoords) then
        QBCore.Functions.Progressbar("motelraid", "Searching Inside the Tent", 5000, false, true, { 
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {}, {}, {}, function() -- Done
            TriggerEvent("inventory:client:SetCurrentStash", "motel_"..citizenid, QBCore.Key)
            TriggerServerEvent("inventory:server:OpenInventory", "stash", "motel_"..citizenid, {
                maxweight = 500000,
                slots = 5,
            })
        end, function() -- Cancel
        end)
        return true
    else
        return false
    end
end)

exports("evRaid", function(evNo)
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    if #(playerCoords - evler[tonumber(evNo)]["coord"]["depo"]) < 150 then
        QBCore.Functions.Progressbar("motelraid", "Home Wanted", 35000, false, true, { 
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {}, {}, {}, function() -- Done
            TriggerEvent("inventory:client:SetCurrentStash", "TEv_"..evNo, QBCore.Key)
            TriggerServerEvent("inventory:server:OpenInventory", "stash", "TEv_"..evNo, {
                maxweight = 4000000,
                slots = 500,
            })
        end, function() -- Cancel
        end)
        return true
    else
        return false
    end
end)