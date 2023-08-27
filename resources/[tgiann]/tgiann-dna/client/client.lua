local clientDnalar, toplananDnalar, PlayerData = {}, {}, {}
local menuAcik, bilgiGeldimi, dnaAktif, zombi = false, false, true, false
local OyuncununCani, lastSeria = nil, nil
local isleme = {
    vector3(484.8828125, -989.08563232422, 30.689640045166),
    vector3(-1098.2, -831.13, 10.28), 
    vector3(-459.76, -285.36, -130.88),
    vector3(841.72, -1296.14, 24.32),
    vector3(-433.7, 5996.16, 31.72),
}

local menu = {
    vector3(483.55987548828, -987.91314697266, 30.18963432312),
    vector3(-1103.34, -830.06, 10.0),
    vector3(-460.54, -283.41, -131.3),
    vector3(841.72, -1296.14, 24.32),
    vector3(-433.7, 5996.16, 31.22),
}

QBCore = nil
local coreLoaded = false
Citizen.CreateThread(function()
    while QBCore == nil do
        TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)
        Citizen.Wait(200)
    end
    coreLoaded = true
end)

AddEventHandler('tgiann:playerdead', function(dead)
    OyuncununCani = 200
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    PlayerData = QBCore.Functions.GetPlayerData()
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate')
AddEventHandler('QBCore:Client:OnJobUpdate', function(job)
    PlayerData.job = job
end)

RegisterNetEvent("tgiann-dna:set-serial")
AddEventHandler("tgiann-dna:set-serial", function(seria)
    lastSeria = seria
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5000)
        if zombi then
            dnaAktif = false
        else
            dnaAktif = true
        end
    end
end)

RegisterNetEvent("elixir-base:set-zombie")
AddEventHandler("elixir-base:set-zombie", function(zombiData)
    zombi = zombiData
end)

local sonIsleme = GetGameTimer()

RegisterNetEvent("tgiann-dna:dna-menu")
AddEventHandler("tgiann-dna:dna-menu", function()
    QBCore.UI.Menu.CloseAll()
    local PlayerPed = PlayerPedId()
    if #toplananDnalar == 0 then
        TriggerServerEvent("tgiann-dna:bozuk-delil-sil")
        QBCore.UI.Menu.Open('default', GetCurrentResourceName(), 'dna_menu_bozuk', {
            title    = 'DNA',
            align    = 'left',
            elements = {
                {label = "His/His Evidence Is Distorted!"}
            }
        },function(data, menu)   
        end,function(data, menu)
            menu.close()
        end)
    else
        QBCore.UI.Menu.Open('default', GetCurrentResourceName(), 'dna_menu', {
            title    = 'DNA',
            align    = 'left',
            elements = toplananDnalar
        }, function(data, menu)
            menu.close()
            for i=1, #isleme do
                local dogruAlan = false
                local mesafe = #(GetEntityCoords(PlayerPed) - isleme[i])
                if mesafe < 8 then dogruAlan = true end
                if dogruAlan then
                    if sonIsleme > GetGameTimer() then
                        TriggerServerEvent("tgiann-dna:delil-sil", data.current.data)
                        for i=1, #toplananDnalar do
                            if toplananDnalar[i].label == data.current.label then
                                table.remove(toplananDnalar, i)
                                break
                            end
                        end
                        QBCore.Functions.Notify("Evidence Uploaded Successfully", "success")
                    else
                        TriggerEvent("utk_fingerprint:Start", 2, 2, 2, function(outcome, reason) -- level, can, süre
                            if outcome == true then
                                TriggerServerEvent("tgiann-dna:delil-sil", data.current.data)
                                for i=1, #toplananDnalar do
                                    if toplananDnalar[i].label == data.current.label then
                                        table.remove(toplananDnalar, i)
                                        break
                                    end
                                end
                                sonIsleme = GetGameTimer() + 60000 * 5
                                QBCore.Functions.Notify("Evidence Uploaded Successfully", "success")
                            elseif outcome == false then
                                QBCore.Functions.Notify("You Walked Through Evidence", "error")
                                TriggerServerEvent("tgiann-dna:basarisiz-delil-sil", data.current.data)
                                for i=1, #toplananDnalar do
                                    if toplananDnalar[i].label == data.current.label then
                                        table.remove(toplananDnalar, i)
                                        break
                                    end
                                end
                            end
                        end)
                    end


                end
            end 
        end,function(data, menu)
            menu.close()
        end)
    end
end)

-- Silah Ateş Edince Mermi Kovanı
Citizen.CreateThread(function()
    while true do
        local time = 1000
        local PlayerPed = PlayerPedId()
        if IsPedArmed(PlayerPed, 7) and dnaAktif then
            time = 1
            if IsPedShooting(PlayerPed) then
                local random = math.random(0,100)
                if random < 35 then
                    local id, silahHash = GetCurrentPedWeapon(PlayerPedId())
                    local kordinat = GetEntityCoords(PlayerPed)
                    local id = ""
                    if PlayerData.job == nil then PlayerData = QBCore.Functions.GetPlayerData() end
                    if PlayerData.job.name == "police" then
                        id = "PD-".. math.random(0, 99) .. "-" .. math.random(0, 99) .. "-" .. math.random(0, 99)
                    else
                        id = math.random(0, 99) .. "-" .. math.random(0, 99) .. "-" .. math.random(0, 99) .. "-" .. math.random(0, 99)
                    end
                    local dna = {
                        ["tip"] = "kovan",
                        ["kordinat"] = { 
                            ["x"] = kordinat.x,
                            ["y"] = kordinat.y,
                            ["z"] = kordinat.z + 0.03
                        },
                        ["data"] = {
                            ["saat"] = 123,
                            ["tip"] = "Hive Case",
                            ["rastgeleid"] = id,
                            ["id"] = "Series no: "..lastSeria
                        }
                    }
                    TriggerServerEvent("tgiann-dna:dna-ekle", dna)
                    Citizen.Wait(5000)
                end
                Citizen.Wait(1000)
            end
        end
        Citizen.Wait(time)
    end
end)

-- Canı azalınca
Citizen.CreateThread(function() 
	while true do
        Citizen.Wait(1) 
        if dnaAktif then
            local PlayerPed = PlayerPedId()
            local can = GetEntityHealth(PlayerPed)
            if not OyuncununCani or OyuncununCani == 0 then
                OyuncununCani = can
            end

            local HasarAlindi = (OyuncununCani ~= can and can < (OyuncununCani - 10))
            if HasarAlindi then -- Silahtan Hasar Alınca
                local random = math.random(0,100)
                if random < 75 then
                    local kordinat = GetEntityCoords(PlayerPed)
                    local dna = {
                        ["tip"] = "kan",
                        ["kordinat"] = { 
                            ["x"] = kordinat.x,
                            ["y"] = kordinat.y,
                            ["z"] = kordinat.z
                        },
                        ["data"] = {
                            ["saat"] = 123,
                            ["tip"] = "Human Blood",
                            ["rastgeleid"] = math.random(0, 99) .. "-" .. math.random(0, 99) .. "-" .. math.random(0, 99) .. "-" .. math.random(0, 99),
                            ["id"] = PlayerData.charinfo.firstname.. " " ..PlayerData.charinfo.lastname
                        }
                    }
                    TriggerServerEvent("tgiann-dna:dna-ekle", dna)
                    Citizen.Wait(20000)
                end
                Citizen.Wait(1000)
                OyuncununCani = can
            end 
        end
    end
end)

-- Yeri fener ile inceleme
Citizen.CreateThread(function()
    while true do
        local time = 1000
        local PlayerPed = PlayerPedId()
        if IsPedArmed(PlayerPed, 7) and IsPlayerFreeAiming(PlayerId()) and IsFlashLightOn(PlayerPed) then
            time = 1
            if not bilgiGeldimi and coreLoaded then
                QBCore.Functions.TriggerCallback('tgiann-dna:ilk-bilgi', function(data)
                    clientDnalar = data
                    bilgiGeldimi = true
                end)   

                while not bilgiGeldimi do
                    Citizen.Wait(200)
                end
            end

            for x,dna in pairs(clientDnalar) do
                local mesafe = #(vector3(dna["kordinat"]["x"], dna["kordinat"]["y"], dna["kordinat"]["z"]) - GetEntityCoords(PlayerPedId()) )
                if mesafe < 20 then
                    if dna["tip"] == "kovan" then
                        markerCiz(3, dna["kordinat"]["x"], dna["kordinat"]["y"], dna["kordinat"]["z"]-1.0, 255, 255, 0)
                    elseif dna["tip"] == "kan" then
                        markerCiz(28, dna["kordinat"]["x"], dna["kordinat"]["y"], dna["kordinat"]["z"]-1.05, 202, 22, 22)
                    end

                    if mesafe < 0.5 then
                        if PlayerData.job.name == "ambulance" then
                            if dna["tip"] == "kovan" then
                                yazi = "[H] Clean"
                            elseif dna["tip"] == "kan" then
                                yazi = "[H] Gather"
                            end

                        elseif PlayerData.job.name == "police" then
                            yazi = "[H] Gather"
                            
                        else
                            yazi = "[H] Clean"
                        end

                        DrawText3D(dna["kordinat"]["x"], dna["kordinat"]["y"], dna["kordinat"]["z"]-0.7, yazi)
                        if IsControlJustPressed(0,74) then  
                            animasyon(yazi, x, dna)
                        end

                    end
                end
            end
        else
            bilgiGeldimi = false
        end
        Citizen.Wait(time)
    end
end)

-- Citizen.CreateThread(function()
--     for i=1, #menu do
--         exports["elixir-base"]:addNotif("E", "Delillere Bak", 4, 2, menu[i])
--     end
-- end)

-- RegisterNetEvent("dnaKeybindGeneral")
-- AddEventHandler("dnaKeybindGeneral", function()
--     local PlayerPed = PlayerPedId()
--     if not menuAcik then
--         for i=1, #menu do
--             local mesafe = #(GetEntityCoords(PlayerPed) - menu[i])
--             if mesafe < 2 then
--                 menuAcik = true
--                 dnaMenu()
--             end
--             break
--         end
--     end
-- end)

RegisterNetEvent('pddelil')
AddEventHandler('pddelil', function()
    dnaMenu()
end)

function dnaMenu()
    QBCore.Functions.TriggerCallback('tgiann-dna:cek', function(data)
        local elements = {}
        for i=1, #data do
            table.insert(elements, {label = data[i].tip.."(".. data[i].rastgeleid ..") " .. data[i].isim})
        end

        QBCore.UI.Menu.Open('default', GetCurrentResourceName(), 'dna_menu_yeni',{
            title    = 'DNA',
            align    = 'left',
            elements = elements
        }, function(data, menu)   

        end, function(data, menu)
            menu.close()
            menuAcik = false
        end)
    end)
end

function DrawText3D(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    SetTextScale(0.28, 0.28)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 245)
    SetTextOutline(true)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
end

function markerCiz(tip, x, y, z, r, g, b)
    DrawMarker(tip, x, y, z, 0, 0, 0, 0, 0, 0, 0.1, 0.1, 0.1, r, g, b, 255, 0, 1, 0, 0)
end

function animasyon(yazi, x, dna)
    local time = 35000
    if PlayerData.job.name == "police" or PlayerData.job.name == "ambulance" then time = 5000 end
    QBCore.Functions.Progressbar("topla", "Evidence Collecting/Clearing", time, false, true, { -- p1: menu name, p2: yazı, p3: ölü iken kullan, p4:iptal edilebilir
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = 'random@domestic',
        anim = 'pickup_low',
        flags = 48,
    }, {}, {}, function() -- Done
        if yazi == "[H] Gather" then
            table.insert(toplananDnalar, {label = dna["data"]["tip"] .." id:".. dna["data"]["rastgeleid"], value = dna["tip"], data = dna["data"]})
            TriggerServerEvent("tgiann-dna:dna-topla", x)
            TriggerServerEvent("tgiann-dna:dna-sil", x)
            table.remove(clientDnalar, x)
        else
            TriggerServerEvent("tgiann-dna:dna-sil", x)
            table.remove(clientDnalar, x)
        end
    end, function() -- Cancel
    end)
end