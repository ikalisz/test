local QBCore = exports['qb-core']:GetCoreObject()
local coreLoaded = false
local depoKordinat = vector3(1197.13, -3253.61, 7.1)


Citizen.CreateThread(function()
    local blip = AddBlipForCoord(depoKordinat)
    SetBlipSprite(blip, 473)
    SetBlipDisplay(blip, 4)
    SetBlipScale(blip, 0.4)
    SetBlipColour(blip, 4)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Depo")
    EndTextCommandSetBlipName(blip)

    PlayerData = QBCore.Functions.GetPlayerData()
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function() -- Core stuff
    PlayerData = QBCore.Functions.GetPlayerData()
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
    QBCore.Functions.TriggerCallback("tgiann:depo:server:readSQL", function(data)
        SendNUIMessage({type = "open", data = data, identifier = PlayerData.identifier})
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
    QBCore.Functions.TriggerCallback('tgiann:depo:writesql', function(data)
	end, data)
end)
    
RegisterNUICallback('deposat', function(data, cb)
    TriggerServerEvent("tgiann:depo:server:sat")
    QBCore.Functions.Notify('Repository Deleted', 'error', 7500)
end)

RegisterNUICallback('ac', function(data, cb)
    coksexigorunuyorsun = {}
    coksexigorunuyorsun.ad = data.ad
    coksexigorunuyorsun.sifre = data.sifre
    TriggerServerEvent("ananinami", coksexigorunuyorsun)
end)

RegisterNetEvent("dogrulandiacilacakkasa")
AddEventHandler("dogrulandiacilacakkasa", function(data)
    TriggerEvent("inventory:client:SetCurrentStash", "kDepo_" ..data)
    TriggerServerEvent("inventory:server:OpenInventory", "stash", "kDepo_" ..data, {
        maxweight = 100000,
        slots = 50,
    })
end)


RegisterNetEvent('just_stash:client:paramyok')
AddEventHandler('just_stash:client:paramyok', function()
    QBCore.Functions.Notify('You dont have $5000 on it', "error")
end)

RegisterNetEvent('sifreyanlis')
AddEventHandler('sifreyanlis', function()
    QBCore.Functions.Notify('Wrong password', "error")
end)

