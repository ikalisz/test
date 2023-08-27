local isDead = false
local eskiArac = nil
local eskiAracModel = nil
local bussy = true
local playerPerm = "user"
local PlayerData = {}

QBCore = nil
Citizen.CreateThread(function()
    while QBCore == nil do
        TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)
        Citizen.Wait(200)
    end
end)  

AddEventHandler('tgiann:playerdead', function(dead)
    isDead = dead
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    PlayerData = QBCore.Functions.GetPlayerData()
    QBCore.Functions.TriggerCallback('tgiann-hackkoruma:GetPermissions', function(UserGroup)
        playerPerm = UserGroup
    end)
end)

local disableWeapon = {
    [`weapon_stungun`] = true
}

RegisterNetEvent('tgiann-hackkoruma:client:kick')
AddEventHandler('tgiann-hackkoruma:client:kick', function(hack)
    if bussy then
        if checkPerm() then
            bussy = false
            Citizen.CreateThread(function()
                Citizen.Wait(10000)
                bussy = true
            end)
            if hack == nil then hack = "No reason! Unknown!" end
            local url = exports['elixir-base']:screenShot()
            if url then
                TriggerServerEvent("tgiann-hackkoruma:kick", url, hack)
            else
                TriggerServerEvent("tgiann-hackkoruma:kick", "No Picture Taken!", hack)
            end
            bussy = true
        else
            -- TriggerEvent('chatMessage', "KORUMA", "error", hack)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5000) -- 5000
        if checkPerm() then
            local PlayerId = PlayerId()
            local PlayerPed = PlayerPedId()
            local _,SilahHash = GetCurrentPedWeapon(PlayerPedId()) -- Silah Hash
            local _,sMermi = GetAmmoInClip(PlayerPedId(), SilahHash) -- Silah Mermi
            local sFullMermi = GetAmmoInPedWeapon(PlayerPedId(), SilahHash) -- Silahın Toplam Mermisi

            -- Karakter Canı 200 Den Fazla İSe
            if GetEntityHealth(PlayerPed) > 200 or GetEntityMaxHealth(PlayerPed) > 200 then 
                local bilgi = GetEntityHealth(PlayerPed)
                local bilgi_2 = GetEntityMaxHealth(PlayerPed)
                TriggerEvent("tgiann-hackkoruma:client:kick", "Max Health Limit Exceeded! Current Life: " .. bilgi .. " Max Health: " .. bilgi_2)
            end
            --Zırh 200'den Fazla İse
            if GetPedArmour(PlayerPed) > 200 or GetPlayerMaxArmour(PlayerPed) > 200 then
                local bilgi = GetPedArmour(PlayerPed)
                local bilgi_2 = GetPlayerMaxArmour(PlayerPed)
                TriggerEvent("tgiann-hackkoruma:client:kick", "Max Exceeded Armor Limit! Current Armor: " .. bilgi .. " Max Armor Value: " .. bilgi_2)
            end
            -- Karakter Hasar Alma
            if not GetEntityCanBeDamaged(PlayerPed) == 1 then 
                TriggerEvent("tgiann-hackkoruma:client:kick", "Character Doesn't Take Damage")
            end
            -- Araç Canı Fazla İse
             if IsPedInAnyVehicle(PlayerPed, false) and (GetVehicleEngineHealth(GetVehiclePedIsIn(PlayerPed, false)) > 1000 or GetVehicleBodyHealth(GetVehiclePedIsIn(PlayerPed, false)) > 1000) then
                local bilgi = GetVehicleEngineHealth(GetVehiclePedIsIn(PlayerPed, false))
                local bilgi2 = GetVehicleBodyHealth(GetVehiclePedIsIn(PlayerPed, false))
                TriggerEvent("tgiann-hackkoruma:client:kick", "Exceeded Max Vehicle Health Limit! Motor:" .. bilgi .. " Body:" .. bilgi2)
            end 
            -- Şarjördeki Max Mermi Hilesi
            if sMermi > 99 or sFullMermi > 599 then
                if not disableWeapon[SilahHash] then
                    TriggerEvent("tgiann-hackkoruma:client:kick", "Max Exceeded Bullet Limit! Magazine: " .. sMermi .. " Total: " .. sFullMermi)
                end
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(250)
        if checkPerm() then
            local playerPed = PlayerPedId()
            local arac = GetVehiclePedIsUsing(playerPed)
            local model = GetEntityModel(arac)

            if (IsPedSittingInAnyVehicle(playerPed)) then
                if (arac == eskiArac and model ~= eskiAracModel and eskiAracModel ~= nil and eskiAracModel ~= 0) then
                    N_0xEA386986E786A54F(arac)
                    TriggerEvent("tgiann-hackkoruma:client:kick", "Vehicle Model Changed! Old:" .. eskiAracModel .. " New: " .. model)
                    return
                end
            end

            eskiArac = arac
            eskiAracModel = model
        end
    end
end)

Citizen.CreateThread(function()
	while true do
        Citizen.Wait(500)
        if checkPerm() then
            local ped = PlayerPedId()
            local pedId = PlayerPedId()

            if IsPedJumping(pedId) then
                local firstCoord = GetEntityCoords(ped)

                while IsPedJumping(pedId) do
                    Citizen.Wait(0)
                end
        
                local secondCoord = GetEntityCoords(ped)
                local lengthBetweenCoords = GetDistanceBetweenCoords(firstCoord, secondCoord, false)

                if (lengthBetweenCoords > 20.0) then
                    TriggerEvent("tgiann-hackkoruma:client:kick", "Super Jump, Jump value:" .. lengthBetweenCoords)
                end
            end
        end
    end
end)
 
Citizen.CreateThread(function()
	while true do
        Citizen.Wait(500)
        if checkPerm() then 
            local ped = PlayerPedId()
            local speed = GetEntitySpeed(ped) 
            local inveh = IsPedInAnyVehicle(ped, false)
            local ragdoll = IsPedRagdoll(ped)
            local jumping = IsPedJumping(ped)
            local falling = IsPedFalling(ped)
    
            if not inveh then
                if not ragdoll then 
                    if not falling then 
                        if not jumping then 
                            if speed > 13 then 
                                TriggerEvent("tgiann-hackkoruma:client:kick", "Speed Hack, Speed: " .. speed)
                            end
                        end
                    end
                end
            end
        end
    end
end) 

function checkPerm()
    if playerPerm ~= "god" and playerPerm ~= "admin" then
        return true
    else
        return false
    end
end