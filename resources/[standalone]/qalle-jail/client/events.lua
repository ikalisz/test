yemekcd = false
gorusme = false
yemekhane = false
sayibisiklet = 0


RegisterNetEvent("jail:yiyecekicecek", function()
    if not yemekcd then
        QBCore.Functions.Notify("Here you go...", "success")
        TriggerServerEvent("jail:yiyecekal")
        yemekcd = true
    else
        QBCore.Functions.Notify("How about you eat all the prison supplies if you want??", "error")
    end
end)

RegisterNetEvent("jail:telefonal", function()
        QBCore.Functions.Notify("Here you go...", "success")
        TriggerServerEvent("jail:phoneverabi")
end)


exports['qb-target']:AddBoxZone("313", vector3(1781.042, 2560.953, 46.599), 0.7, 0.7, {
    heading=179.1,
    debugPoly= false,
    minZ=44.66,
    maxZ=46.66
}, {
    options = {
                {
                event = "jail:yiyecekicecek",
                icon = "fas fa-circle",
                label = "Request French Fries & Coke",
            },
                {
                event = "jail:telefonal",
                icon = "fas fa-circle",
                label = "Buy Phone ($100)",
            },
    },
    job = {"all"},
    distance = 10
})

RegisterNetEvent("jail:gorusme", function()
    if not gorusme then
        QBCore.Functions.Notify("Let's go in front of me, don't try to make a wrong move!")
        DoScreenFadeOut(0)
        SetEntityCoords(PlayerPedId(), vector3(1828.8361816406, 2591.3735351563, 46.01432800293))
        Wait(400)
        DoScreenFadeIn(1000)
        gorusme = true
    else
        QBCore.Functions.Notify("Let's go in front of me, don't try to make a wrong move!")
        DoScreenFadeOut(0)
        SetEntityCoords(PlayerPedId(), vector3(1761.298828125, 2485.1472167969, 45.740734100342))
        Wait(400)
        DoScreenFadeIn(1000)
        gorusme = false
    end
end)

RegisterNetEvent("jail:bisikletkirala", function()
    if sayibisiklet == 0 then
        bmx = nil
        QBCore.Functions.SpawnVehicle("bimx", function(yourVehicle)
            bmx = yourVehicle
            NetworkFadeInEntity(yourVehicle, true, true)
            TaskWarpPedIntoVehicle(PlayerPedId(), yourVehicle, -1)
            SetVehicleHasBeenOwnedByPlayer(yourVehicle, true)
            local id = NetworkGetNetworkIdFromEntity(yourVehicle)
            SetNetworkIdCanMigrate(id, true)
            TriggerEvent("x-hotwire:give-keys", yourVehicle)
            TriggerServerEvent("jail:removemoney")
            QBCore.Functions.Notify("The bike is rented, in 15 minutes the cyclist will get it back from you.")
        end, {x=1643.6965332031, y=2589.9711914063, z=44.552791595459, h=4}, true) -- coords, isnetwork

        sayibisiklet = 15
        checkbisiklet = 0
        CreateThread(function()
            while true do

                sayibisiklet = sayibisiklet - 1
                checkbisiklet = checkbisiklet + 1

                if checkbisiklet == 5 then
                    checkbisiklet = 0

                    if sayibisiklet == 0 then
                        QBCore.Functions.Notify("The bike has expired.")
                    else
                        QBCore.Functions.Notify("Your bike ".. sayibisiklet.." minutes left.")
                    end
                end

                if sayibisiklet == 0 then
                    DoScreenFadeOut(0)
                    Wait(200)
                    DeleteEntity(bmx)
                    Wait(200)
                    DoScreenFadeIn(1000)
                    sayibisiklet = 0
                    break
                end

                Wait(1000 * 60)
            end
        end)
    else
        QBCore.Functions.Notify("You already have a bike.", "error")
    end
end)

RegisterNetEvent("jail:gerialesya", function()
    PlayerData = QBCore.Functions.GetPlayerData()
    TriggerEvent("inventory:client:SetCurrentStash", "Güvenlik_"..QBCore.Functions.GetPlayerData().citizenid, QBCore.Key)
    TriggerServerEvent("inventory:server:OpenInventory", "stash", "Güvenlik_"..QBCore.Functions.GetPlayerData().citizenid, {maxweight = 500000, slots = 60,})
end)

local kamu = {
    vector3(1694.610, 2469.146, 47.298),
    vector3(1723.265, 2506.167, 45.552),
    vector3(1755.639, 2502.829, 47.134),
    vector3(1766.722, 2531.255, 45.552),
    vector3(1627.213, 2490.060, 44.627),
    vector3(1617.301, 2527.889, 44.552),
}


inkamu = false
inkamu2 = nil
RegisterNetEvent("jail:kamugorev", function()
    if not inkamu then
        for i = 1, #kamu do
            -- exports["qtarget"]:AddBoxZone("kamu"..i, kamu[i], 1, 1, {
                exports['qb-target']:AddBoxZone("kamu"..i, kamu[i], 2, 2, {
                name="kamu"..i,
                heading=336.0,
                debugPoly=false,
                minZ=44.20,
                maxZ=46.20 ,
            },
                {
                    options = {
                        {
                            event = "jail:kamugorevp2",
                            icon = "fas fa-circle",
                            label = "Fix it",
                            id = i,
                        },
                    },
                    job = {"all"},
                    distance = 1,
                    -- spritecoord = kamu[i],
                }
            )
        end

        inkamu = true
        inkamu2 = kamu[1]
        SetNewWaypoint(kamu[1].x, kamu[1].y)
        QBCore.Functions.Notify("Fix the marked fuse boxes outside.")
    else
        QBCore.Functions.Notify("You are already doing public service..", "error")
    end
end)

RegisterNetEvent("jail:kamugorevp2", function(data) 
    id = data.id 

    QBCore.Functions.Progressbar("kamugorev", "You are repairing the fuse box..", 30000, false, true, { -- p1: menu name, p2: yazı, p3: ölü iken kullan, p4:iptal edilebilir
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        task = "WORLD_HUMAN_WELDING",
    }, {}, {}, function() -- Done
        if kamu[id+1] then
            -- exports["qtarget"]:RemoveZone("kamu"..id)
            exports['qb-target']:RemoveZone("kamu"..id)
            ClearPedTasks(PlayerPedId())
            StopAnimTask(PlayerPedId(), WORLD_HUMAN_WELDING)
            SetNewWaypoint(kamu[id+1].x, kamu[id+1].y)
            inkamu2 = kamu[id+1]
        else
            inkamu = false
            inkamu2 = nil
            QBCore.Functions.Notify("You fixed all the fuse boxes.")
        end

        jailTime = jailTime - 2
        TriggerEvent("comServUI:set", "to the end of the sentence " .. jailTime .. " month left.", true)
        ClearPedTasks(PlayerPedId)

        if jailTime <= 0 then
            UnJail()
        end
    end, function() -- Cancel
    end)
end)

CreateThread(function()
    while true do
        sleep = 5000
        if inkamu2 then
            DrawMarker(2, inkamu2.x, inkamu2.y, inkamu2.z+1.5, 0.0, 0.0, 0.0, 180.0, 0.0, 0.0, 0.75, 0.75, 0.75, 255, 0, 0, 100, true, true, 2, false, false, false, false)
            sleep = 1
        end
        Wait(sleep)
    end
end)