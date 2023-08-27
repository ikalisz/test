local arayuz = false
local openUi = false
local sezer20, allahsizvoyvoda36 = nil, 1
local jameshunt = vector3(-322.247, -1545.90, 31.019)
local kaptanyilmaz = false
local trigger = 0
local cooldown = nil

QBCore = nil
Citizen.CreateThread(function()
    while QBCore == nil do
        TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)
        Citizen.Wait(200)
    end
end)

Citizen.CreateThread(function()
	local blip = AddBlipForCoord(jameshunt)

	SetBlipSprite (blip, 318)
	SetBlipDisplay(blip, 4)
    SetBlipScale  (blip, 0.5)
    SetBlipColour (blip, 43)
	SetBlipAsShortRange(blip, true)

	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Cleaning Center")
	EndTextCommandSetBlipName(blip)
end)

local copler = {
    {
        ["isim"] = "Square Park",
        ["kordinatlar"] = {
            vector3(167.6645, -1003.87, 29.344),
            vector3(157.93, -994.77, 29.36),
            vector3(156.13, -986.6, 30.09),
            vector3(164.8, -984.13, 30.09),
            vector3(170.16, -989.32, 30.09),
            vector3(180.15, -1005.27, 29.33),
            vector3(191.89, -1012.88, 29.33),
            vector3(177.41, -1011.28, 29.22),
            vector3(162.62, -1007.94, 29.47),
        }
    },
    {
        ["isim"] = "Southside  Megamall",
        ["kordinatlar"] = {
            vector3(69.35, -1710.57, 29.14),
            vector3(61.67, -1706.74, 29.28),
            vector3(54.65, -1698.3, 29.26),
            vector3(42.34, -1697.19, 29.27),
            vector3(39.22, -1692.41, 29.19),
            vector3(52.95, -1696.53, 29.17),
            vector3(58.12, -1707.1, 29.31),
            vector3(63.68, -1715.31, 29.31),
            vector3(85.33, -1700.39, 29.24),
            vector3(79.65, -1695.9, 29.24),
            vector3(94.35, -1687.37, 29.21),
            vector3(100.99, -1692.91, 29.2),
        }
    },
    {
        ["isim"] = "Police Department",
        ["kordinatlar"] = {
            vector3(418.32, -945.5, 29.37),
            vector3(427.46, -944.51, 29.22),
            vector3(436.98, -946.94, 29.04),
            vector3(445.12, -944.24, 28.74),
            vector3(456.1, -948.37, 28.33),
            vector3(392.74, -946.28, 29.27),
            vector3(390.79, -963.25, 29.36),
            vector3(390.92, -971.98, 29.44),
            vector3(409.99, -965.51, 29.46),
            vector3(420.94, -963.72, 29.39),
            vector3(431.68, -963.04, 29.24),
            vector3(414.26, -977.37, 29.46),
            vector3(412.27, -986.21, 29.41)
        }
    },
}




        RegisterCommand("start", function()
            kaptanyilmaz = true
            exports['qb-ui']:hideInteraction()
            sezer20 = math.random(1, #copler)
            QBCore.Functions.Notify("Your job application to the cleaning center has been accepted!, The place you need to clean: ".. copler[sezer20]["isim"] .."")
            Wait(1000)
            QBCore.Functions.Notify("You can use the /twitter command to cancel the job you inherited from the cleaning center..", "primary", 15000)
            SetNewWaypoint(copler[sezer20]["kordinatlar"][1].x, copler[sezer20]["kordinatlar"][1].y)
            QBCore.Functions.Notify("Location marked on GPS")
        end, true)

local arayuz = false
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        local PlayerPed = PlayerPedId()
        local PlayerKordinat = GetEntityCoords(PlayerPed)

        local mesafe = #(PlayerKordinat - jameshunt)
        local openUi = false
        if mesafe < 20 then 
            DrawMarker(2, jameshunt.x, jameshunt.y, jameshunt.z-0.5, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.3, 0.3, 0.2, 100, 0, 0, 100, false, true, 2, false, false, false, false)
            if mesafe < 1.3 then
                openUi = true
                arayuz = true
                exports['qb-ui']:showInteraction("[E] Temizlik Merkezine Başvur")
                if IsControlJustPressed(0, 38) then
                    arayuz = false
                    exports['qb-ui']:hideInteraction()
                    if not cooldown then
                        if not kaptanyilmaz then
                            kaptanyilmaz = true
                            exports['qb-ui']:hideInteraction()
                            sezer20 = math.random(1, #copler)
                            QBCore.Functions.Notify("Your job application to the cleaning center has been accepted!, The place you need to clean: ".. copler[sezer20]["isim"] .."")
                            Wait(1000)
                            QBCore.Functions.Notify("You can use the /tbitir command to cancel the job you inherited from the cleaning center..", "primary", 15000)
                            SetNewWaypoint(copler[sezer20]["kordinatlar"][1].x, copler[sezer20]["kordinatlar"][1].y)
                            QBCore.Functions.Notify("Location marked on GPS")
                        else
                            QBCore.Functions.Notify("You're already doing this job!", "error")
                        end
                    else
                        QBCore.Functions.Notify("Dude, you gotta wait a while, there's no place to clean.", "error")
                    end
                end
            end
        end

        if kaptanyilmaz then
            local konum = copler[sezer20]["kordinatlar"][allahsizvoyvoda36]
            local copMesafe = #(GetEntityCoords(PlayerPedId()) - konum)
            if copMesafe < 100 then 
                DrawMarker(2, konum.x, konum.y, konum.z-0.5, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.5, 0.5, 0.4, 100, 0, 0, 100, false, true, 2, false, false, false, false)
                if copMesafe < 0.5 then
                    openUi = true
                    arayuz = true
                    exports['qb-ui']:showInteraction("[E] Temizle")
                    if IsControlJustPressed(0, 38) then
                        arayuz = false
                        exports['qb-ui']:hideInteraction()
                        local yeniallahsizvoyvoda36 = math.random(1, #copler[sezer20]["kordinatlar"])
                        allahsizvoyvoda36 = yeniallahsizvoyvoda36
                        QBCore.Functions.Progressbar("temizlik_isi", "Cleaning up...", 11000, false, cancel, { -- p1: menu name, p2: yazı, p3: ölü iken kullan, p4:iptal edilebilir
                        disableMovement = true,
                        disableCarMovement = true,
                        disableMouse = false,
                        disableCombat = true,
                    }, {
                        animDict = "amb@world_human_janitor@male@idle_a",
                        anim = "idle_a",
                        flags = 33,
                    }, { -- prop1
                        model = "prop_tool_broom",
                        bone = 28422,
                        coords = { x = -0.005, y = 0.0, z = 0.0 },
                        rotation = { x = 360.0, y = 360.0, z = 0.0 },
                    }, {}, function(cancelled) -- Done
                            if not cancelled then
                                if trigger < 8 then
                                        TriggerServerEvent('ra1der:para')
                                        QBCore.Functions.Notify("Some money has been deposited into your bank account for cleaning the floor!")
                                        trigger = trigger + 1
                                    if trigger == 25 then
                                        cooldown = true
                                        kaptanyilmaz = false
                                    end
                                else
                                    if not cooldown then
                                        trigger = trigger + 1
                                    else
                                        QBCore.Functions.Notify("Dude, you gotta wait a while, there's no place to clean.", "error")
                                    end

                                end
                            end
                        end)
                    end
                end
            end
        end
        if arayuz and not openUi then 
            arayuz = false
            openUi = false
            exports['qb-ui']:hideInteraction()
        end

        if cooldown then
            Citizen.Wait(Config.Cooldown * 60000)
            cooldown = false
            trigger = 0
        end

    end
end)

RegisterCommand("cfinish", function()
	if kaptanyilmaz then
		kaptanyilmaz = false
        QBCore.Functions.Notify("Cleaning mission canceled.", "error")
        exports['qb-ui']:hideInteraction()
		-- exports['mythic_notify']:SendAlert('error', 'Temizlik görevi iptal edildi')
	else
        QBCore.Functions.Notify("You can't cancel before you start your cleaning mission.", "error")
        exports['qb-ui']:hideInteraction()
		-- exports['mythic_notify']:SendAlert('error', 'Temizlik görevine başlamadan iptal edemezsin')
	end
end, false)

function DrawText3D(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    SetTextScale(0.30, 0.30)
    SetTextFont(0)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 250
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 0, 0, 0, 75)
end

