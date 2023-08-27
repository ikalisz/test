local karakterisim = "Known..."
local tedaviSure = 65000
local dinlenmeSure = 10000
local olumu, yatakta = false, false
local PlayerData = {}

local blips = {
    {name="Hospital", id=80, x = 1609.435, y = 3574.589, z = 37.775, h= 119.24, doktorismi = "Doktor Tuğrul"},
    {name="Hospital", id=80, x= 309.53344726562, y= -593.77777099609, z= 42.284122467041, h= 25.30, doktorismi = "Civan"},
    {name="Hospital", id=80, x= -253.2, y= 6327.62, z= 31.43, h= 224.04, doktorismi = "Serkan"},
    {name="Hospital", id=80, x= 1825.41, y= 3667.81, z= 33.27, h= 37.72, doktorismi = "Arda"},
}

local yataklar = {
    ["Civan"] = {
        ["olu"] = {
            {x=315.24, y= -566.73, z=43.28, h=158.37},
            {x=321.16, y= -568.05, z=43.28, h=158.37},
            {x=326.81, y= -570.99, z=43.28, h=158.37},
        },
        ["normal"] = {
            { x = 309.35, y= -577.38, z = 43.34, h = 160.0},
            { x = 313.93, y= -579.04, z = 43.34, h = 160.0},
            { x = 319.41, y= -581.04, z = 43.34, h = 160.0},
            { x = 324.26, y= -582.8, z = 43.34, h = 160.0},
            { x = 322.62, y= -587.17, z = 43.34, h = 340.0},
            { x = 317.67, y= -585.37, z = 43.34, h = 340.0},
            { x = 314.47, y= -584.2, z = 43.34, h = 340.0},
            { x = 311.06, y= -582.96, z = 43.34, h = 340.0},
            { x = 307.72, y= -581.75, z = 43.34, h = 340.0},
        } 
    },

    ["Serkan"] = {
        ["olu"] = {
            {x=-248.55, y= 6316.59, z=32.43, h=45.82},
            {x=-250.76, y= 6314.35, z=32.43, h=45.82},
        },
        ["normal"] = {
            { x = -256.42, y= 6327.83, z = 32.49, h = 135.07},
            { x = -258.73, y= 6330.06, z = 32.49, h = 135.07},
            { x = -262.46, y= 6326.5, z = 32.49, h = 314.37},
            { x = -260.11, y= 6324.2, z = 32.49, h = 314.37},
            { x = -257.73, y= 6321.82, z = 32.49, h = 314.37},
        } 
    },

    ["Arda"] = {
        ["olu"] = {
            {x=1825.76, y= 3685.59, z=34.27, h=333.08},
            {x=1834.86, y= 3691.28, z=34.27, h=107.63},
            {x=1835.91, y= 3689.04, z=34.27, h=92.05},
        },
        ["normal"] = {
            { x = 1820.07, y= 3669.6, z = 34.34, h = 300.0},
            { x = 1819.09, y= 3671.3, z = 34.34, h = 300.0},
            { x = 1818.11, y= 3673.0, z = 34.34, h = 300.0},
            { x = 1817.13, y= 3674.69, z = 34.34, h = 300.0},
            { x = 1823.29, y= 3672.22, z = 34.34, h = 120.0},
            { x = 1822.24, y= 3674.04, z = 34.34, h = 120.0},
            { x = 1818.27, y= 3677.85, z = 34.34, h = 210.0},
            { x = 1819.97, y= 3678.83, z = 34.34, h = 210.0},
            { x = 1821.67, y= 3679.81, z = 34.34, h = 210.0},
            { x = 1821.67, y= 3679.81, z = 34.34, h = 210.0},
        } 
    }
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

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    PlayerData = QBCore.Functions.GetPlayerData()
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate')
AddEventHandler('QBCore:Client:OnJobUpdate', function(job)
    PlayerData.job = job
end)

AddEventHandler('tgiann:playerdead', function(dead)
    olumu = dead
end)

RegisterNetEvent('tgiann-npcdoktor:yatakKontrol')
AddEventHandler('tgiann-npcdoktor:yatakKontrol', function()
    yatakYatir("Civan", 0)
end)

local lastTime = 0
Citizen.CreateThread(function()
    for i, item in pairs(blips) do
        exports["elixir-base"]:pedcreate("doktor-"..i, 0xD47303AC, item.x, item.y, item.z, item.h)
        exports['qb-target']:AddTargetModel('s_m_m_doctor_01', {
            options = {
                {
                    type = "client",
                    event = "tedaviolaq",
                    icon = "fas fa-hands",
                    label = "Get Treated",
                },
            },
            distance = 2.5,
        })
        -- exports["elixir-base"]:addNotif("E", item.doktorismi.." Doktor", 2, 2, vector3(item.x, item.y, item.z))
	end
end)

-- RegisterNetEvent('npcdoktorKeybindGeneral')
-- AddEventHandler('npcdoktorKeybindGeneral', function()
--     if coreLoaded then
--         for _, item in pairs(blips) do
--             if #(GetEntityCoords(PlayerPedId()) - vector3(item.x, item.y, item.z)) < 3 then
--                 if lastTime == 0 or GetGameTimer() > lastTime then
--                     lastTime = GetGameTimer() + 15000
--                     QBCore.Functions.TriggerCallback('elixir-base:ems-sayi', function(count)
--                         if count <= 1 or item.doktorismi == "İllegal Bahadır" then
--                             if count == 1 and item.doktorismi ~= "İllegal Bahadır" then
--                                 QBCore.Functions.Notify("Şehirde şuan ".. count .." adet EMS birimi var istersen onu bekleyebilirsin.", "primary", 10000)
--                             end
--                             OpenSoruMenu(item.doktorismi)
--                         else
--                             QBCore.Functions.Notify("Şehirde iki veya ikiden fazla EMS birimleri var onları bekle", "error")
--                         end
--                     end)
--                 else
--                     QBCore.Functions.Notify("Biraz Bekle!", "error")
--                 end
--             end
--         end
--     end
-- end)

RegisterNetEvent('tedaviolaq')
AddEventHandler('tedaviolaq', function()
    if coreLoaded then
        for _, item in pairs(blips) do
            if #(GetEntityCoords(PlayerPedId()) - vector3(item.x, item.y, item.z)) < 3 then
                if lastTime == 0 or GetGameTimer() > lastTime then
                    lastTime = GetGameTimer() + 15000
                    QBCore.Functions.TriggerCallback('elixir-base:ems-sayi', function(count)
                        if count <= 1 or item.doktorismi == "İllegal Bahadır" then
                            if count == 1 and item.doktorismi ~= "İllegal Bahadır" then
                                QBCore.Functions.Notify("There are "..count .." EMS units in the city now, you can wait for it if you want.", "primary", 10000)
                            end
                            OpenSoruMenu(item.doktorismi)
                        else
                            QBCore.Functions.Notify("There are two or more EMS units in the city, wait for them", "error")
                        end
                    end)
                else
                    QBCore.Functions.Notify("Wait a little!", "error")
                end
            end
        end
    end
end)

function hastaKayitEt(doktorIsmi, para)
    local serverId = GetPlayerServerId(PlayerId())
    QBCore.Functions.TriggerCallback('elixir-base:xplayer-kullanici-bilgi', function(data) 
        karakterisim = data.firstname ..' ' .. data.lastname
        if not doktorIsmi ~= "İllegal Bahadır" and not doktorIsmi ~= "İllegal Aruba" then
            TriggerServerEvent("esx_ambulancejob_hastakayit", serverId, karakterisim, para .. "$ Treated and Took in Return", doktorIsmi)
        end
    end, serverId)
end

function OpenSoruMenu(doktorismi)    
    if doktorismi == "İllegal Bahadır" or doktorismi == "İllegal Aruba" then
        para = exports["elixir-base"]:itemPrice('NpcIllegalDoktor')
        if PlayerData.job and PlayerData.job.name == "police" then
            if doktorismi == "İllegal Bahadır" then
                TriggerServerEvent("3dme:server:tgiann-doctor", "Idiots Did You Seriously Bring Me A Cop?", {x = blips[1].x, y = blips[1].y, z = blips[1].z+0.8}, QBCore.Key)
            else
                TriggerServerEvent("3dme:server:tgiann-doctor", "Idiots Did You Seriously Bring Me A Cop?", {x = blips[2].x, y = blips[2].y, z = blips[2].z+0.8}, QBCore.Key)
            end
            return
        end
    else
        para = exports["elixir-base"]:itemPrice('NpcDoktor')
    end

    QBCore.UI.Menu.Open('default', GetCurrentResourceName(), 'hasta_kayit', {
        title    = para ..'$ Are you sure you want to be treated in return! ',
        align    = 'top-left',
        elements = {
            {label = 'Yes', value = 'evet'},
            {label = 'No', value = 'hayir'},
        }
    }, function(data, menu)
        if data.current.value == 'evet' then
            menu.close()
            if (doktorismi == "İllegal Bahadır" or  doktorismi == "İllegal Aruba") and PlayerData.job and PlayerData.job.name == "police" then
                QBCore.Functions.Notify("Go Die in the Corner I Will Not Treat You!", "error", 10000)
                return
            end
            yatakYatir(doktorismi, para)

        elseif data.current.value == 'hayir' then
            menu.close()
        end
    
    end, function(data, menu)
        menu.close()
    end) 
end

function yatakYatir(doktorismi, para)
    local playerPed = PlayerPedId()
    local canlandi = false
    if para > 0 then TriggerServerEvent('hospital:legal', para) end
    yatakta = true
    TriggerEvent("ChairBedSystem:disable-script", true)
    FreezeEntityPosition(playerPed, true)
    if doktorismi ~= "İllegal Bahadır" and doktorismi ~= "İllegal Aruba" then
        if olumu then
            canlandi = true
            TriggerEvent('esx_ambulancejob:revive', true)
            Citizen.Wait(1000)    
            for i=1, #yataklar[doktorismi]["olu"] do
                local yatak = yataklar[doktorismi]["olu"][i]
                local yatakBosDurum = QBCore.Functions.GetPlayersInArea(vector3(yatak.x, yatak.y, yatak.z), 1.5)
                if #yatakBosDurum == 0 or i == #yataklar[doktorismi]["olu"] then
                    SetEntityCoords(playerPed, yatak.x, yatak.y, yatak.z)
                    SetEntityHeading(playerPed, yatak.h)

                    QBCore.Functions.Progressbar("hastane_tedavi", "You are being treated", tedaviSure, false, false, { -- p1: menu name, p2: yazı, p3: ölü iken kullan, p4:iptal edilebilir
                        disableMovement = true,
                        disableCarMovement = true,
                        disableMouse = false,
                        disableCombat = true,
                    }, {
                        animDict = "anim@gangops@morgue@table@",
                        anim = "ko_front",
                        flags = 33,
                    }, {}, {}, function() -- Done
                        -- Done
                    end, function() -- Cancel
                        -- Cancel
                    end)

                    Citizen.Wait(tedaviSure)  
                    break
                end
            end               
        end
        if not canlandi then
            TriggerEvent('esx_ambulancejob:revive', false)
        end

        Citizen.Wait(1000) 
        for i=1, #yataklar[doktorismi]["normal"] do
            local yatak = yataklar[doktorismi]["normal"][i]
            local yatakBosDurum = QBCore.Functions.GetPlayersInArea(vector3(yatak.x, yatak.y, yatak.z), 1.5)
            if #yatakBosDurum == 0 or i == #yataklar[doktorismi]["normal"] then
                SetEntityCoords(playerPed, yatak.x, yatak.y, yatak.z)
                SetEntityHeading(playerPed, yatak.h)    
                local bugfix = GetEntityCoords(playerPed)

                QBCore.Functions.Progressbar("hastane_dinlen", "you are resting", dinlenmeSure, false, false, { -- p1: menu name, p2: yazı, p3: ölü iken kullan, p4:iptal edilebilir
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                }, {
                    animDict = "anim@gangops@morgue@table@",
                    anim = "ko_front",
                    flags = 33,
                }, {}, {}, function() -- Done
                    Citizen.Wait(500)
                    hastaKayitEt(doktorismi, para)
                    SetEntityCoords(playerPed, bugfix.x+1.3, bugfix.y, bugfix.z-1)
                end, function() -- Cancel
                    -- Cancel
                end)

                Citizen.Wait(dinlenmeSure)
                TriggerEvent("ChairBedSystem:disable-script", false)
                yatakta = false
                FreezeEntityPosition(playerPed, false)
                break
            end
        end  
    else
        QBCore.Functions.Progressbar("hastane_tedavi_god", "You Are Being Treated [Cancelled DEL]", 120000, false, true, { -- p1: menu name, p2: yazı, p3: ölü iken kullan, p4:iptal edilebilir
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {
            animDict = "anim@gangops@morgue@table@",
            anim = "ko_front",
            flags = 33,
        }, {}, {}, function() -- Done
            QBCore.Functions.Notify('You were treated by Doctor!')
            TriggerEvent('esx_ambulancejob:revive', false)
            yatakta = false
            TriggerEvent("ChairBedSystem:disable-script", false)
            FreezeEntityPosition(playerPed, false)
        end, function() -- Cancel
            yatakta = false
            TriggerEvent("ChairBedSystem:disable-script", false)
            FreezeEntityPosition(playerPed, false)
        end)
       
    end
end

Citizen.CreateThread(function()
    while true do
        local time = 1000
        if yatakta then
            time = 1
            local playerPed = PlayerPedId()
            DisablePlayerFiring(playerPed, true)
            SetPedCanPlayGestureAnims(playerPed, false)
    
            DisableControlAction(0, 24, true) -- Attack
            DisableControlAction(0, 257, true) -- Attack 2
            DisableControlAction(0, 25, true) -- Aim
            DisableControlAction(0, 263, true) -- Melee Attack 1
            DisableControlAction(0, 56, true) -- F9
    
            DisableControlAction(0, 45, true) -- Reload
            DisableControlAction(0, 22, true) -- Jump
            DisableControlAction(0, 44, true) -- Cover
            DisableControlAction(0, 37, true) -- Select Weapon
    
            DisableControlAction(0, 288,  true) --F1
            DisableControlAction(0, 289, true) -- F2
            DisableControlAction(0, 170, true) -- F3
            DisableControlAction(0, 167, true) -- F6

            DisableControlAction(0, 244, true) -- m
    
            DisableControlAction(0, 0, true) -- Disable changing view
            DisableControlAction(0, 26, true) -- Disable looking behind
            DisableControlAction(0, 73, true) -- Disable clearing animation
            DisableControlAction(2, 199, true) -- Disable pause screen
    
            DisableControlAction(0, 59, true) -- Disable steering in vehicle
            DisableControlAction(0, 71, true) -- Disable driving forward in vehicle
            DisableControlAction(0, 72, true) -- Disable reversing in vehicle
    
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

            DisableControlAction(0, 157, true) -- 1
            DisableControlAction(0, 158, true) -- 2
            DisableControlAction(0, 160, true) -- 3
            DisableControlAction(0, 164, true) -- 4
            DisableControlAction(0, 165, true) -- 5
        end
        Citizen.Wait(time)
    end
end)  