local bussy = false
local inAnimation = false
local barCount = 0
local esktraBarCount = 3
local targetPlayer = 0
local taskBarActive = false

QBCore = nil
Citizen.CreateThread(function()
    while QBCore == nil do
        TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)
        Citizen.Wait(200)
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        if inAnimation then
            DisableControlAction(0, 73, true)
            if IsDisabledControlJustReleased(0, 73) then
                clearAnim(true)
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        if inAnimation then
            barCount = barCount + 1
            local playerPed = PlayerPedId()
            local cd = math.random(4000,6000)
            if GetEntityModel(PlayerPedId()) ~= 1885233650 then cd = math.random(25000,35000) end 
            Citizen.Wait(cd)
            if inAnimation and taskBarActive then
                local taskBarTime = (8-barCount)
                local random = math.random(10,15)
                if taskBarTime < 1 then 
                    TriggerServerEvent("3dme:display", "Person is about to come", QBCore.Key, "do")
                    taskBarTime = 1 
                    esktraBarCount = esktraBarCount - 1 
                    if esktraBarCount < 0 then
                        random =  math.random(1,5)
                    elseif esktraBarCount < 2 then
                        taskBarTime = 0.5
                    end
                end
                local finished = exports["tgiann-skillbar"]:taskBar(taskBarTime*1000, random, true)
                if not finished then
                    TriggerServerEvent("3dme:display", "The Person Has Arrived", QBCore.Key, "do")
                    Citizen.Wait(2500)
                    clearAnim(true)
                end
            end
        end
    end
end)

RegisterNetEvent('tgiann-erp:client:clear-anim')
AddEventHandler('tgiann-erp:client:clear-anim', function()
    clearAnim(false)
end)

RegisterNetEvent('tgiann-erp:izin')
AddEventHandler('tgiann-erp:izin', function(gonderen, name)
    if not bussy then
        bussy = true
        QBCore.Functions.Notify(name .." E-RP Requests Permission, Press [Y] to Accept", "primary", 15000)
        local time = 1000
        while time > 0 do
            Citizen.Wait(1)
            time = time - 1
            if time == 0 then
                QBCore.Functions.Notify("Request Timed Out", "error")
                TriggerServerEvent("tgiann-erp:cancel", gonderen)
            end
            if IsControlJustPressed(0, 246) then
                time = 0
                QBCore.Functions.Notify("Request Accepted", "success")
                TriggerServerEvent("tgiann-erp:ok", gonderen)
            end
        end
        bussy = false
    end
end)

RegisterNetEvent('tgiann-erp:animasyon')
AddEventHandler('tgiann-erp:animasyon', function(car, driveSeat, flag, dict, anim, konumZorla, target, rot, x, y)
    if not inAnimation then
        taskBarActive = true
        barCount = 0
        local playerPed = PlayerPedId()
        if not IsPedSittingInAnyVehicle(playerPed) and car then
            QBCore.Functions.Notify("You are not in the vehicle!", "error")
            return
        elseif IsPedSittingInAnyVehicle(playerPed) and car then
            local playerVehicle = GetVehiclePedIsIn(playerPed)
            if driveSeat then
                if GetPedInVehicleSeat(playerVehicle, -1) ~= playerPed then
                    QBCore.Functions.Notify("You Are Not In The Right Seat!", "error")
                    return
                end
            else
                if GetPedInVehicleSeat(playerVehicle, 0) ~= playerPed then
                    QBCore.Functions.Notify("You Are Not In The Right Seat!", "error")
                    return
                end
            end
        elseif IsPedSittingInAnyVehicle(playerPed) and not car then
            QBCore.Functions.Notify("You Can't Make This Animation In The Vehicle!", "error")
            return
        end

        targetPlayer = target

        if anim == "bj_loop_prostitute" or anim == "f_blow_job_loop" or anim == "pimpsex_hooker" then taskBarActive = false end
        inAnimation = true
        if konumZorla then
            SetEntityCollision(playerPed, false, false)
            FreezeEntityPosition(playerPed, true)
            local player = GetPlayerFromServerId(targetPlayer)
            local ped = GetPlayerPed(player)

            local playerheading = GetEntityHeading(ped)
            local playerlocation = GetEntityForwardVector(ped)
            local playerCoords = GetEntityCoords(ped)
            konumaldir(playerPed, playerlocation, playerheading, playerCoords, x, y, rot)
        end

        QBCore.Shared.RequestAnimDict(dict, function() 
            while inAnimation do
                if not IsEntityPlayingAnim(PlayerPedId(), dict, anim, 1) then
                    TaskPlayAnim(PlayerPedId(), dict, anim, 8.0, 8.0, -1, flag, 0.0, false, false, false)
                end
                Citizen.Wait(100)
            end
        end)
    else
        QBCore.Functions.Notify("You Are Already On A Job!", "error")
    end
end)

function konumaldir(playerPed, playerlocation, playerheading, playerCoords, nx, ny, rot)
    SetCurrentPedWeapon(playerPed, `WEAPON_UNARMED`, true) -- unarm player
    if nx == nil then nx = 0 end
    if ny == nil then ny = 0 end
    local x, y, z = table.unpack(playerCoords + playerlocation * vector3(nx, ny, 0.0))
    SetEntityCoords(playerPed, x, y, z-1.0)
    if rot then
        SetEntityHeading(playerPed, playerheading-180)
    else
        SetEntityHeading(playerPed, playerheading)
    end
end

function clearAnim(targetClear)
    inAnimation = false
    local playerPed = PlayerPedId()
    if not IsPedSittingInAnyVehicle(playerPed) then
        SetEntityCollision(playerPed, true, true)
        FreezeEntityPosition(playerPed, false)
        ClearPedTasksImmediately(playerPed)
    else
        ClearPedTasks(playerPed)
    end
    if targetClear then
        TriggerServerEvent("tgiann-erp:clear-anim", targetPlayer)
    end
end