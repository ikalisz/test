QBCore = nil
Citizen.CreateThread(function()
    while QBCore == nil do
        TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)
        Citizen.Wait(200)
    end
end)

local isDead = false
local aktif = false
local tip = ""
local oyuncu = ""
local targetId = 0

AddEventHandler('tgiann:playerdead', function(dead) 
    isDead = dead
end)

local animasyonlar = {
    ["kucak"] = {
        ["oyuncu1"] = {
            ["dic"] = "anim@heists@box_carry@",
			["anim"] = "idle",
			["flag"] = 49,
        },
        ["oyuncu2"] = {
            ["dic"] = "amb@code_human_in_car_idles@generic@ps@base",
			["anim"] = "base",
			["flag"] = 33,
        }
    },
    ["rehin"] = {
        ["oyuncu1"] = {
            ["dic"] = "anim@gangops@hostage@",
			["anim"] = "perp_idle",
			["flag"] = 49,
        },
        ["oyuncu2"] = {
            ["dic"] = "anim@gangops@hostage@",
			["anim"] = "victim_idle",
			["flag"] = 49,
        }
    },
    ["sirt"] = {
        ["oyuncu1"] = {
            ["dic"] = "missfinale_c2mcs_1",
			["anim"] = "fin_c2_mcs_1_camman",
			["flag"] = 49,
        },
        ["oyuncu2"] = {
            ["dic"] = "amb@world_human_bum_slumped@male@laying_on_left_side@base",
			["anim"] = "base",
			["flag"] = 33,
        }
    }
}

RegisterNetEvent('esx_barbie_lyftupp:TgiannKucak', function()
    TriggerEvent("tgiann-kucakla:kontrol", "kucak")
end)

RegisterNetEvent('esx_barbie_lyftupp:TgiannSirtla', function()
    TriggerEvent("tgiann-kucakla:kontrol", "sirt")
end)

RegisterNetEvent('esx_barbie_lyftupp:TgiannTasi', function()
    TriggerEvent("tgiann-kucakla:kontrol", "tasi")
end)

RegisterNetEvent('esx_barbie_lyftupp:TgiannRehinAl', function()
    TriggerEvent("tgiann-kucakla:kontrol", "rehin")
end)

local bussy = true
RegisterNetEvent('tgiann-kucakla:kontrol')
AddEventHandler('tgiann-kucakla:kontrol', function(xtip)
    if bussy then
        bussy = false
        local playerPed = PlayerPedId()
        if not IsEntityAttached(playerPed) then
            QBCore.Functions.Notify('Processing!', "primary", 2300)
            if not aktif then Citizen.Wait(1000) end
            if targetId == 0 then
                local player, distance = QBCore.Functions.GetClosestPlayer()
                targetId =  GetPlayerServerId(player)
                local playerServerId = GetPlayerFromServerId(targetId)
                local targetPed = GetPlayerPed(playerServerId)
                local model = GetEntityModel(targetPed)
                if (distance == -1 or distance > 3.0) or not IsEntityVisible(targetPed) then -- or (model ~= 1885233650 and model ~= -1667301416)
                    QBCore.Functions.Notify('No players nearby!', 'error')
                    bussy = true
                    return
                end
            end
            if not aktif then 
                oyuncu = "oyuncu1"
                tip = xtip



                if tip == "rehin" then
                    local anim = animasyonlar[tip]["oyuncu1"]

                    local _, hash = GetCurrentPedWeapon(playerPed)
                    if GetWeapontypeGroup(hash) ~= 416676503 then
                        QBCore.Functions.Notify('You Need to Have a Pistol to Take a Person Hostage!', 'error')
                        bussy = true
                        return
                    end
                    QBCore.Functions.Notify('Player Taken Hostage!')
                    QBCore.Shared.RequestAnimDict(anim.dic, function()
                        TaskPlayAnim(playerPed, anim.dic, anim.anim, 8.0, -8.0, -1, anim.flag, 0, false, false, false)
                    end)
                elseif tip == "tasi" then

                else
                    local anim = animasyonlar[tip]["oyuncu1"]

                    QBCore.Shared.RequestAnimDict(anim.dic, function()
                        TaskPlayAnim(playerPed, anim.dic, anim.anim, 8.0, -8.0, -1, anim.flag, 0, false, false, false)
                    end)
                end
                QBCore.Functions.Notify('[X] Let go the Person', "primary", 2500)
                TriggerServerEvent("tgiann-kucakla:server:oyuncu-2-anim", targetId, tip)
                aktif = true
            else
                QBCore.Functions.Notify('Player Dropping!')
                if tip == "rehin" then
                    TriggerServerEvent("tgiann-kucakla:server:rehin-birak", targetId, "birak")
                    rehineBirak("oyuncu1")
                else
                    TriggerServerEvent("tgiann-kucakla:server:anim-iptal", targetId)
                    animIptal()
                end
            end
        end
        bussy = true
    end
end)

RegisterNetEvent('tgiann-kucakla:client:anim-iptal')
AddEventHandler('tgiann-kucakla:client:anim-iptal', function()
    animIptal()
end)

function animIptal()
    aktif = false
    targetId = 0
    local playerPed = PlayerPedId()
    ClearPedSecondaryTask(playerPed)
    if IsEntityAttached(playerPed) then
        DetachEntity(playerPed, true, false)
    end
end

RegisterNetEvent('tgiann-kucakla:client:oyuncu-2-anim')
AddEventHandler('tgiann-kucakla:client:oyuncu-2-anim', function(xtip, oyuncu1)
    if not aktif then
        local playerPed = PlayerPedId()
        local playerServerId = GetPlayerFromServerId(oyuncu1)
        local targetPed = GetPlayerPed(playerServerId)
        oyuncu = "oyuncu2"
        tip = xtip
        if tip == "kucak" then
            local anim = animasyonlar[tip][oyuncu]

            QBCore.Shared.RequestAnimDict(anim.dic, function()
                AttachEntityToEntity(playerPed, targetPed, 9816, 0.015, 0.38, 0.11, 0.9, 0.30, 90.0, false, false, false, false, 2, false)
                TaskPlayAnim(playerPed, anim.dic, anim.anim, 8.0, -8.0, -1, anim.flag, 0, false, false, false)
            end)
        elseif tip == "rehin" then
            local anim = animasyonlar[tip][oyuncu]

            QBCore.Shared.RequestAnimDict(anim.dic, function()
                AttachEntityToEntity(playerPed, targetPed, 0, -0.24, 0.11, 0.0, 0.5, 0.5, 0.0, false, false, false, false, 2, false)
                TaskPlayAnim(playerPed, anim.dic, anim.anim, 8.0, -8.0, -1, anim.flag, 0, false, false, false)
            end)
        elseif tip == "sirt" then
            local anim = animasyonlar[tip][oyuncu]

            QBCore.Shared.RequestAnimDict(anim.dic, function()
                AttachEntityToEntity(playerPed, targetPed, 1, -0.68, -0.1, 0.94, 1.0, 1.0, 240.0, false, false, false, false, 2, false)
                TaskPlayAnim(playerPed, anim.dic, anim.anim, 8.0, -8.0, -1, anim.flag, 0, false, false, false)
            end)

        elseif tip == "tasi" then
            AttachEntityToEntity(playerPed, targetPed, 11816, 0.54, 0.54, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
        end
        aktif = true
    end
end)

Citizen.CreateThread(function()
    while true do
        local time = 1000
        if aktif then
            time = 1
            local playerPed = PlayerPedId()
            if tip ~= "tasi" then
                local anim = animasyonlar[tip][oyuncu]

                if not IsEntityPlayingAnim(PlayerPedId(), anim.dic, anim.anim, 3) then
                    TaskPlayAnim(playerPed, anim.dic, anim.anim, 8.0, -8.0, -1, anim.flag, 0, false, false, false)
                end
            end

     

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
            DisableControlAction(0, 167, true) -- F6
            DisableControlAction(0, 73, true) -- Disable clearing animation
            DisableControlAction(0, 47, true)  -- Disable weapon
            DisableControlAction(0, 264, true) -- Disable melee
            DisableControlAction(0, 257, true) -- Disable melee
            DisableControlAction(0, 140, true) -- Disable melee
            DisableControlAction(0, 141, true) -- Disable melee
            DisableControlAction(0, 142, true) -- Disable melee
            DisableControlAction(0, 143, true) -- Disable melee

            if oyuncu == "oyuncu2" or tip == "rehin" then
                DisableControlAction(0, 23, true) -- enter
                DisableControlAction(0, 170, true) -- F3
                DisableControlAction(0, 0, true) -- Disable changing view
                DisableControlAction(2, 199, true) -- Disable pause screen
                DisableControlAction(0, 59, true) -- Disable steering in vehicle
                DisableControlAction(0, 71, true) -- Disable driving forward in vehicle
                DisableControlAction(0, 72, true) -- Disable reversing in vehicle
                DisableControlAction(0, 75, true)  -- Disable exit vehicle
                DisableControlAction(0, 301, true)  -- Disable exit vehicle
                DisableControlAction(27, 75, true) -- Disable exit vehicle
            end

            if oyuncu == "oyuncu1" then
                DisableControlAction(0, 23) -- F


                if IsPedInAnyVehicle(playerPed) then
                    local vehicle = GetVehiclePedIsIn(playerPed, false)
                    TaskLeaveVehicle(playerPed, vehicle, 16)
                    QBCore.Functions.Notify('You cannot get in a vehicle while carrying someone.!', "primary", 2300)
                end
            end

            DisableControlAction(0, 73, true)
            if oyuncu == "oyuncu1" and IsDisabledControlJustPressed(0,73) then --x
                exports['qb-ui']:hideInteraction("rehin")
                if tip == "rehin" then
                    exports['qb-ui']:hideInteraction("rehin")
                    TriggerServerEvent("tgiann-kucakla:server:rehin-birak", targetId, "birak")
                    rehineBirak("oyuncu1")
                else
                    TriggerServerEvent("tgiann-kucakla:server:anim-iptal", targetId)
                    animIptal()
                    exports['qb-ui']:hideInteraction("rehin")
                end
                exports['qb-ui']:hideInteraction("rehin")
            end


            if oyuncu == "oyuncu1" and tip == "rehin" then
                SetFollowPedCamViewMode(4)
                local playerCoords = GetEntityCoords(playerPed)
                exports['qb-ui']:showInteraction("[X] Release | [H] Kill", nil, "rehin")
                if IsDisabledControlJustPressed(0,74) then --kill 
                    TriggerServerEvent("tgiann-kucakla:server:rehin-birak", targetId, "oldur")
                    rehineOldur("oyuncu1")
                    exports['qb-ui']:hideInteraction("rehin")
                end
            end
        end
        Citizen.Wait(time)
    end
end)

RegisterNetEvent('tgiann-kucakla:client:rehin-birak')
AddEventHandler('tgiann-kucakla:client:rehin-birak', function(rehintip)
    if rehintip == "birak" then
        rehineBirak("oyuncu2")
        exports['qb-ui']:hideInteraction("rehin")
    else
        rehineOldur("oyuncu2")
        exports['qb-ui']:hideInteraction("rehin")
    end
end)

function rehineBirak(oyuncu)
    animIptal()
    exports['qb-ui']:hideInteraction("rehin")
    local playerPed = PlayerPedId()
    if oyuncu == "oyuncu1" then
        QBCore.Shared.RequestAnimDict("reaction@shove", function()
            TaskPlayAnim(playerPed, "reaction@shove", "shove_var_a", 8.0, -8.0, -1, 120, 0, false, false, false)
        end)
    else
        QBCore.Shared.RequestAnimDict("reaction@shove", function()
            TaskPlayAnim(playerPed, "reaction@shove", "shoved_back", 8.0, -8.0, -1, 0, 0, false, false, false)
        end)
    end
end

function rehineOldur(oyuncu)
    animIptal()
    exports['qb-ui']:hideInteraction("rehin")
    local playerPed = PlayerPedId()
    if oyuncu == "oyuncu1" then
        QBCore.Shared.RequestAnimDict("anim@gangops@hostage@", function()
            TaskPlayAnim(playerPed, "anim@gangops@hostage@", "perp_fail", 8.0, -8.0, -1, 168, 0, false, false, false)
            SetPedShootsAtCoord(playerPed, 0.0, 0.0, 0.0, 0)
        end)
    else
        QBCore.Shared.RequestAnimDict("anim@gangops@hostage@", function()
            TaskPlayAnim(playerPed, "anim@gangops@hostage@", "victim_fail", 8.0, -8.0, -1, 0, 0, false, false, false)
            Citizen.Wait(1000)
            SetEntityHealth(playerPed, 0)
        end)
    end
end