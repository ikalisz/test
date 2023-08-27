QBCore = nil
local coreLoaded = false
local nuiFocus = false
local active = false
local tab = 0
Citizen.CreateThread(function()
    while QBCore == nil do
        TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)
        Citizen.Wait(200)
    end
    coreLoaded = true
end)

local PlayerData = {}

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    firstLogin()
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate')
AddEventHandler('QBCore:Client:OnJobUpdate', function(job)
    firstLogin()
end)

function firstLogin()
    PlayerData = QBCore.Functions.GetPlayerData()
    if PlayerData.job.name == "ambulance" then
        local firstData = {}
        firstData.name = PlayerData.charinfo.firstname .. " " .. PlayerData.charinfo.lastname
        firstData.rank = QBCore.Shared.Jobs["ambulance"]["grade"][PlayerData.job.grade].label
        firstData.items = {}
        for item, data in pairs(QBCore.Shared.Items) do
            table.insert(firstData.items, data.label)
        end
        SendNUIMessage({type = 'ilk-bilgi', data = firstData})
    end
end

RegisterNUICallback('sorgula', function(data, cb)
    local sorguData = nil
    QBCore.Functions.TriggerCallback("tgiann-emstab:sorgula", function(result)
        sorguData = result
    end, data)
    while sorguData == nil do Citizen.Wait(0) end
    cb(sorguData)
end)

RegisterNUICallback('cezakaydetclient', function(data)
    TriggerServerEvent("tgiann-emstab:ceza-kaydet", data.data)
end)

local olaylarDataLast = nil
local olaylarDataTime = 0
RegisterNUICallback('olaylardata', function(data, cb)
    if GetGameTimer() > olaylarDataTime or olaylarDataTime == 0 then
        olaylarDataTime = GetGameTimer() + 30000
        QBCore.Functions.TriggerCallback("tgiann-emstab:olaylardata", function(result)
            olaylarDataLast = result
            cb(result)
        end)
    else
        cb(olaylarDataLast)
    end
end)

local sabikaDataLast = nil
local sabikaDataTime = 0
RegisterNUICallback('sabikadata', function(data, cb)
    if GetGameTimer() > sabikaDataTime or sabikaDataTime == 0 then
        sabikaDataTime = GetGameTimer() + 30000
        QBCore.Functions.TriggerCallback("tgiann-emstab:sabikadata", function(result)
            sabikaDataLast = result
            cb(result)
        end, data.id)
    else
        cb(sabikaDataLast)
    end
end)

RegisterNUICallback('sabikasil', function(data, cb)
    TriggerServerEvent("tgiann-emstab:sabikasil", data.id)
end)

function openClose()
    nuiFocus = not nuiFocus
    SetNuiFocus(nuiFocus, nuiFocus)
    if nuiFocus then
        startAnim()
        SendNUIMessage({type = 'open'})
    else
        stopAnim()
        SendNUIMessage({type = 'close'})
    end
end

function stopAnim()
	StopAnimTask(PlayerPedId(), "amb@code_human_in_bus_passenger_idles@female@tablet@idle_a", "idle_a" ,8.0, -8.0, -1, 50, 0, false, false, false)
	DeleteObject(tab)
end

function startAnim()
    RequestAnimDict("amb@code_human_in_bus_passenger_idles@female@tablet@idle_a")
    while not HasAnimDictLoaded("amb@code_human_in_bus_passenger_idles@female@tablet@idle_a") do
        Citizen.Wait(0)
    end
    TaskPlayAnim(PlayerPedId(), "amb@code_human_in_bus_passenger_idles@female@tablet@idle_a", "idle_a" ,8.0, -8.0, -1, 50, 0, false, false, false)
    tab = CreateObject(`prop_cs_tablet`, 0, 0, 0, true, true, true)
	AttachEntityToEntity(tab, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 28422), -0.05, 0.0, 0.0, 0.0, 0.0, 0.0, true, true, false, true, 1, true)
end

RegisterNUICallback('olaysil', function(data, cb)
    TriggerServerEvent("tgiann-emstab:olaysil", data.id)
end)

RegisterNetEvent('tgiann-denizalti:emp')
AddEventHandler('tgiann-denizalti:emp', function(_active)
	active = _active
	if active then
        if nuiFocus then
            openClose()
        end
  	end
end)

RegisterCommand("emstablet", function()
    if PlayerData.job == nil then firstLogin() end
	if PlayerData.job and PlayerData.job.name == "ambulance"  then
		if not active then
			openClose()
		else
			QBCore.Functions.Notify("You Can't Use the Tablet Right Now!", "error")
		end
	end
end)


RegisterNUICallback('kapat', function(data, cb)
    if nuiFocus then openClose() end
end)

AddEventHandler('onResourceStop', function(resourceName)
    if (GetCurrentResourceName() == resourceName) then
        if nuiFocus then openClose() end
    end
end)

RegisterNUICallback('olayara', function(data, cb)
    QBCore.Functions.TriggerCallback("tgiann-emstab:olayara", function(result)
        cb(result)
    end, data.id)
end)

RegisterNetEvent("tgiann-mdtv2:zoom")
AddEventHandler("tgiann-mdtv2:zoom", function(data)
    if PlayerData.job and PlayerData.job.name == "ambulance"  then
        if data == nil then
            QBCore.Functions.Notify("You Didn't Enter a Value! (50-100)", "error")
        end

        if tonumber(data) < 50 then
            QBCore.Functions.Notify("You cannot enter a value less than 50", "error")
        elseif tonumber(data) > 100 then
            QBCore.Functions.Notify("You cannot enter a value greater than 100", "error")
        else
            QBCore.Functions.Notify("Tablet Size Adjusted", "success")
            SendNUIMessage({type = 'zoom', val = data})
        end
    end
end)