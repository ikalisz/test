QBCore = nil
local coreLoaded = false
local depoKordinat = vector3(1197.250, -3253.49, 7.0951)


Citizen.CreateThread(function()
    while QBCore == nil do
        TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)
        Citizen.Wait(200)
    end
    coreLoaded = true

    local blip = AddBlipForCoord(depoKordinat)
    SetBlipSprite(blip, 473)
    SetBlipDisplay(blip, 4)
    SetBlipScale(blip, 0.7)
    SetBlipColour(blip, 41)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Depo")
    EndTextCommandSetBlipName(blip)
end)


RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    firstLogin()
end)

RegisterNetEvent('tgiann-depo:yenile')
AddEventHandler('tgiann-depo:yenile', function()
    depoAc()
end)

function firstLogin()
    PlayerData = QBCore.Functions.GetPlayerData()
end



function depoAc()
    local PlayerData = QBCore.Functions.GetPlayerData()
    QBCore.Functions.TriggerCallback("tgiann-depo:depolar", function(data)
        SendNUIMessage({type = "open", data = data, citizenid = PlayerData.citizenid})
        SetNuiFocus(true, true)
    end)
end

AddEventHandler('onResourceStop', function(resourceName)
    if (GetCurrentResourceName() == resourceName) then
        SetNuiFocus(false, false)
    end
end)

RegisterNUICallback('kapat', function(data, cb)
    SetNuiFocus(false, false)
end)

RegisterNUICallback('satinal', function(data, cb)
    TriggerServerEvent("tgiann-depo:satin-al", data)
end)

RegisterNUICallback('deposat', function(data, cb)
    TriggerServerEvent("tgiann-depo:sat")
end)

RegisterNUICallback('ac', function(data, cb)
    TriggerEvent("inventory:client:SetCurrentStash", "kDepo_"..data.citizenid, QBCore.Key)
    TriggerServerEvent("inventory:server:OpenInventory", "stash", "kDepo_"..data.citizenid, {
        maxweight = 10000000,
        slots = 140,
    })
end)


exports['qb-target']:AddBoxZone("pdbooss", vector3(1197.26, -3253.57, 7.09), 1.1, 1.1, {
    heading=270.59,
    minZ=5.73,
    maxZ=9.46,
	debugPoly = false 
}, {
    options = {
        {
            event = "tgiann-depo:yenile",
            icon = "fas fa-box",
            label = "Depo"
        },
    },
    distance = 2
})


